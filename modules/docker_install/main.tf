resource "null_resource" "ssh_target" {
  connection {
    type        = "ssh"
    user        = var.ssh_user
    host        = var.ssh_host
    password    = var.ssh_password
    private_key = file(var.ssh_key)
  }
  provisioner "remote-exec" {
    inline = [
      "echo ${var.ssh_password} | sudo -S apt update -qq >/dev/null",
      "curl -fsSL https://get.docker.com -o get-docker.sh",
      "echo ${var.ssh_password} | sudo -S chmod 755 get-docker.sh",
      "echo ${var.ssh_password} | sudo -S ./get-docker.sh >/dev/null"
    ]
  }
  provisioner "file" {
    source      = "startup-options.conf"
    destination = "/tmp/startup-options.conf"
  }
  provisioner "remote-exec" {
    inline = [
      "echo ${var.ssh_password} | sudo -S mkdir -p /etc/systemd/system/docker.service.d/",
      "echo ${var.ssh_password} | sudo -S cp /tmp/startup-options.conf /etc/systemd/system/docker.service.d/startup-options.conf",
      "echo ${var.ssh_password} | sudo -S systemctl daemon-reload",
      "echo ${var.ssh_password} | sudo -S systemctl restart docker",
      "echo ${var.ssh_password} | sudo -S usermod -aG docker hugo2"
    ]
  }
}
