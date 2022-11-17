# @summary Deploy PE to the cloud with specific DNS additions
#
plan pe_provisioner::aws::deploy_with_dns(
  String[1]                                 $domain_name,
  Enum['development', 'production', 'user'] $cluster_profile      = 'development',
  String[1]                                 $version              = '2021.7.1',
  Optional[String[1]]                       $ssh_pub_key_file     = undef,
  Optional[String[1]]                       $console_password     = undef,
  Boolean                                   $replica              = false,
  Optional[String[1]]                       $ssh_user             = undef,
  Optional[String[1]]                       $cloud_region         = 'us-west-2',
  Array                                     $firewall_allow       = [],
) {

  # Ask for a password if not passed on the CLI and then fail if one was not
  # provided. No insecure defaults here!
  if $console_password {
    $_console_password = $console_password
  } else {
    $_console_password = prompt('Input Puppet Enterprise console password now',
      'sensitive' => true, 'default' => '')
    if $_console_password.empty {
      fail_plan('Must provide a password when prompted or via CLI argument')
    }
  }

  # Provision infrastructure with reduced number of parameters which will not
  # change in this custom user specific environment.
  $provisioned = run_plan('pecdm::subplans::provision', {
    architecture         => 'large',
    cluster_profile      => $cluster_profile,
    compiler_count       => 3,
    ssh_pub_key_file     => $ssh_pub_key_file,
    replica              => $replica,
    provider             => 'aws',
    ssh_user             => $ssh_user,
    cloud_region         => $cloud_region,
    firewall_allow       => $firewall_allow,
    extra_terraform_vars => { 'domain_name' => $domain_name }
  })

  # Collect the names of all provisioned instances to be passed to our special
  # Cloud DNS entry module, it uses these names to lookup instance IP addresses
  $instances = $provisioned['pe_inventory'].map |$_, $v| {
    $v.map |$target| {
      $target['name'].split('[.]')[0]
    }
  }.flatten()

  # Construct the Terraform resource name from the returned load balancer DNS
  # name to create a CNAME
  $lb_resource_name = $provisioned['compiler_pool_address'].split('[.]')[0].split('-').delete_at(-1).join('-')

  # Prepare and run custom Terraform module that will create Cloud DNS records
  run_task('terraform::initialize', 'localhost', dir => '.terraform/example_pe_dns/aws')

  $dns_tfvars_template = @(TFVARS)
    region       = "<%= $cloud_region %>"
    loadbalancer = "<%= $lb_resource_name %>" 
    zone         = "<%= $domain_name %>"
    instances    = <%= String($instances).regsubst('\'', '"', 'G') %>
    |TFVARS

  $dns_tfvars = inline_epp($dns_tfvars_template)

  $dns_tf_apply = pecdm::with_tempfile_containing('', $dns_tfvars, '.tfvars') |$tfvars_file| {
    # Stands up our cloud infrastructure that we'll install PE onto, returning a
    # specific set of data via TF outputs that if replicated will make this plan
    # easily adaptable for use witj multiple cloud providers
    run_plan('terraform::apply',
      dir           => '.terraform/example_pe_dns/aws',
      return_output => true,
      var_file      => $tfvars_file
    )
  }

  # Deploy PE using peadm. While this passes a chosen load balancer name instead
  # of the GCP generated one as compiler_pool_address, it is still a good idea
  # to pass the generated name as an extra DNS ALT NAME
  run_plan('pecdm::subplans::deploy', {
    inventory              => $provisioned['pe_inventory'],
    compiler_pool_address  => "${lb_resource_name}.${domain_name}",
    dns_alt_names          => [$provisioned['compiler_pool_address']],
    version                => $version,
    console_password       => $_console_password.unwrap,
    extra_peadm_params     => {
      'r10k_remote'           => 'git@github.com:ody/control-repo.git',
      'r10k_private_key_file' => '/home/cody/.ssh/code-manager',
      'deploy_environment'    => 'production'
    },
  })

  run_plan('pecdm::utils::inventory_yaml', {
    provider    => 'aws',
    ssh_ip_mode => 'public',
    native_ssh  => pecdm::is_windows(),
  })
}
