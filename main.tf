variable "ssh_host" {}
variable "ssh_user" {}
variable "ssh_password" {}
variable "ssh_key" {}
variable "php_port" {}

module "docker_install" {
  source        = "./modules/docker_install"
  ssh_host      = var.ssh_host
  ssh_user      = var.ssh_user
  ssh_key       = var.ssh_key
  ssh_password  = var.ssh_password
}


module "docker_run" {
  source        = "./modules/docker_run"
  ssh_host      = var.ssh_host
}
module "docker_mysql" {
  source                = "./modules/docker_php"
  ssh_host              = var.ssh_host
  ssh_user              = var.ssh_user
  ssh_key               = var.ssh_key
  php_port              = var.php_port
  ssh_password          = var.ssh_password
}

output "docker_ip_db" {
  value = module.docker_mysql.docker_ip_db
}
output "docker_ip_php" {
  value = module.docker_mysql.docker_ip_php
}
output "docker_volume" {
  value = module.docker_mysql.docker_volume
}
