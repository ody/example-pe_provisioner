forge 'https://forge.puppet.com'

# Modules from the Puppet Forge
mod 'puppetlabs-stdlib', '7.0.0'
mod 'puppetlabs-apply_helpers', '0.2.1'
mod 'puppetlabs-bolt_shim', '0.3.2'
mod 'puppetlabs-terraform', '0.6.1'
mod 'puppet-format', '1.0.0'
mod 'WhatsARanjit-node_manager', '0.7.5'

# Modules from Git
mod 'puppetlabs-peadm',
    git: 'https://github.com/puppetlabs/puppetlabs-peadm.git',
    ref: 'main'
mod 'puppetlabs-pecdm',
    git: 'https://github.com/puppetlabs/puppetlabs-pecdm.git',
    ref: 'composited'

# External non-Puppet content
#
# Not a perfect solution given some assumptions made by r10k about repository
# naming, specifically that there can only be one "-" or "/" in the name and
# the component preceding those characters is dropped. These assumptions make
# using content from other tool that follow a different naming pattern
# sub-optimal but ultimately the on disk name and the name of the source
# repository are not required to match and naming is irrelevant to Bolt when the
# content is outside the modules and site-modules directories.
#
mod 'terraform-google_pe_arch',
    git:          'https://github.com/puppetlabs/terraform-google-pe_arch.git',
    ref:          '3be30239a12e7c27efdd00f5213de804d03c9b17',
    install_path: '.terraform'

mod 'terraform-aws_pe_arch',
   git:          'https://github.com/puppetlabs/terraform-aws-pe_arch.git',
   ref:          'main',
   install_path: '.terraform'

mod 'terraform-azure_pe_arch',
   git:          'https://github.com/puppetlabs/terraform-azure-pe_arch.git',
   ref:          'main',
   install_path: '.terraform'

mod 'terraform-example_pe_dns',
   git:          'https://github.com/ody/terraform-example-pe_dns.git',
   ref:          'main',
   install_path: '.terraform'
