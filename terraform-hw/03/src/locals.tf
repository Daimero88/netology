locals {
  metadata = {
    serial-port-enable = 1
    ssh-keys           = "${var.vm_web_user}:${file(var.ssh_key)}"
  }
}
