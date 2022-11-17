# PE Cloud Provisioning Bolt Project for Example Organization

A sample Bolt Project that might be used by a hypothetical Example organization which augments [puppetlabs/pecdm](https://github.com/puppetlabs/puppetlabs-pecdm) to deploy Puppet Enterprise to Google Cloud Platform or AWS with an organization owned DNS zone managed by GCP Cloud DNS or Route53.

**Table of Contents**

1. [Description](#description)
2. [Setup - The basics of getting started with pe_provisioner](#setup)
    * [Beginning with pe_provisioner](#beginning-with-pecdm)
4. [Limitations - OS compatibility, etc.](#limitations)

## Description

It is impossible for pecdm and peadm to support all user requirements for deploying Puppet Enterprise to various cloud providers. To address this unpredictability, both modules are modular so that actions can be split out and recomposed into custom workflows. This Bolt Project illustrates that composability by eschewing the `pecdm::provision` plan, taking its subplans and combining them together with some custom code, including a custom Terraform module which creates DNS records for each provisioned instance and load balancer so that an organization owned DNS zone can be used instead of what is provided by Google Cloud Platform.

## Setup

## Beginning with pe_provisioner

1. Clone this repository: `git clone https://github.com/ody/example-pe_provisioner.git && cd example-pe_provisioner`
2. Install module dependencies: `bolt module install --no-resolve`
3. For GCP run plan: `bolt plan run pe_provisioner::google::deploy_with_dns zone=example domain_name=example.com project=example ssh_user=john.doe`
3. For AWS run plan: `bolt plan run pe_provisioner::aws::deploy_with_dns domain_name=example.com firewall_allow='["1.2.3.4/32"]'`
4. Input a PE console password when asked
5. Wait...

## Limitations

This is meant to illustrate a solution which could be adopted and modified by an organization which is interested in building cloud automation for deploying Puppet Enterprise with specific customizations which is not possible or appropriate to be added directly to pecdm or peadm. As such, this project is very limited and will not attempt to be any more configurable than is now.
