# Test Server Setup #

This repo is used to provision a new test server on DigitalOcean. It uses Terraform for provisioning and Ansible for configuration.

## Terraform | Provisioning ##

The server can be spun up by running:

```shell
terraform apply
```

Before this can be run, however, the `terraform.tfvars` file must be configured. To check the plan beforehand, run:

```shell
terraform plan
```

## Terraform | Tearing Down the Server ##

The test server can easily be torn down with:

```shell
terraform destroy
```

## Ansible | Configuring the Inventory ##

Before the play can be run, the `inventory` and `external_vars.yml` files need to be configured. To check the inventory, run:

```shell
ansible-inventory -i inventory --list
```

## Ansible | Running the Play ##

To run the Ansible play, run:

```shell
ansible-playbook -i inventory playbook.yml
```