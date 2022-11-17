forge 'https://forge.puppet.com'

# Modules from the Puppet Forge
mod 'puppetlabs-stdlib', '8.5.0'
mod 'puppetlabs-apply_helpers', '0.3.0'
mod 'puppetlabs-bolt_shim', '0.4.0'
mod 'puppetlabs-inifile', '5.4.0'
mod 'WhatsARanjit-node_manager', '0.7.5'
mod 'puppetlabs-ruby_task_helper', '0.6.1'
mod 'puppetlabs-ruby_plugin_helper', '0.2.0'

# Modules from Git
mod 'puppetlabs-peadm',
    git: 'https://github.com/puppetlabs/puppetlabs-peadm.git',
    ref: '5509de5cbded4486a3f84f49d67b83da464746ad'
mod 'puppetlabs-pecdm',
    git: 'https://github.com/puppetlabs/puppetlabs-pecdm.git',
    ref: 'eb63830170af6924275f40d6f7e483d960ba3e81'
mod 'puppetlabs-terraform',
    git: 'https://github.com/puppetlabs/puppetlabs-terraform.git',
    ref: 'a57808f7477204681d27f6d7dee9b89bf714d9e7'

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
    ref:          '5772aebc633f72acb031d6c4b5f786e99a451a65',
    install_path: '.terraform'
mod 'terraform-aws_pe_arch',
    git:          'https://github.com/puppetlabs/terraform-aws-pe_arch.git',
    ref:          '3c9b4c06c55ac95177d5fd3756c8fa9ee6fa45c0',
    install_path: '.terraform'
mod 'terraform-azure_pe_arch',
    git:          'https://github.com/puppetlabs/terraform-azure-pe_arch.git',
    ref:          '483636c175379e7e199b4de796ef71f1d9e69299',
    install_path: '.terraform'
mod 'terraform-example_pe_dns',
    git:          'https://github.com/ody/terraform-example-pe_dns.git',
    ref:          '8280cac734a6da4667e22f0a048cec1d439b0124',
    install_path: '.terraform'
