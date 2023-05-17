# Configuration-Management ReadMe

Configuration Management using Ansible and (possibly) Ansible AWX (Open source version of Ansible Tower).

Terraform (IaC) can be used to define and create infrastructure resources in a declarative manner. This will provision resources such as virtual machines, networks, storages, and more.

However, Terraform will only create those resources and does not allow us to configure and manage these systems. 

This is where a Configuration Management tool such as Ansible comes clutch. Ansible will allow us to configure and manage these systems by defining the desired state with Ansible playbooks. These playbooks are YAML files that specify tasks and configurations to be applied on target systems.

Still a WIP :computer: