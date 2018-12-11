logdna-instance:
	terraform init && terraform apply -target ibm_resource_instance.instance

logsource-ubuntu:
	terraform init && terraform apply -target ibm_compute_ssh_key.ssh_public_key_for_logdna -target ibm_compute_vm_instance.logdna_ubuntu

logsource-rhel:
	terraform init && terraform apply -target ibm_compute_ssh_key.ssh_public_key_for_logdna -target ibm_compute_vm_instance.logdna_rhel

show-resources:
	terraform show

clean-up-resources:
	terraform destroy