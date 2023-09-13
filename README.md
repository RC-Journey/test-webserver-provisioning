# Test Server Setup #

This repo is used to provision a new test server on DigitalOcean. It uses Terraform for provisioning and Ansible for configuration.

## Terraform | Config ##

Before Terraform can be applied, some configuration must be handled. The `terraform.tfvars.template` file should be renamed `terraform.tfvars`. It will then be protected by version control. It should contain the following content:

```terraform
ssh_key_fingerprint = "ssh-key-fingerprint"
do_token            = "do-token"
```

You should replace the two values with your own from DigitalOcean.

## Terraform | Provisioning ##

The Terraform plan can be checked by running:

```shell
terraform plan
```

To apply the plan and provision the server, run:

```shell
terraform apply
```

## Terraform | Tearing Down the Server ##

The test server can easily be torn down with:

```shell
terraform destroy
```

## Ansible | Configuring the Inventory ##

Before the play can be run, the `inventory` file need to be configured. 

Change the name of the `inventory.template` file to `inventory`. This will protect it from version control, and it should have the following content:

```
[webservers]
rcjourney.test.webserver ansible_host=<host_ipv4> ansible_connection=ssh ansible_user=root
```

Replace `<host_ip4>` with the public IPv4 address returned by the Terraform output from above.

To check the inventory, run:

```shell
ansible-inventory -i inventory --list
```

## Ansible | Configuring the External Variables ##

Next, change the name of the `external_vars.yml.template` file to `external_vars.yml`. This will protect it from version control, and it should have the following content:

```yaml
---
app_root: /var/www/rcjourney.test.webserver/html
```

## Ansible | Running the Play ##

To run the Ansible play, run:

```shell
ansible-playbook -i inventory playbook.yml
```
