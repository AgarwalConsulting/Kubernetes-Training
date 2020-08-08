# Render a multi-part cloud-init config making use of the part
# above, and other source files
data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "script-rendered.sh"
    content_type = "text/x-shellscript"
    content      = templatefile("${path.module}/vmsetup.tpl", {
      project_id             = var.project_id
      region                 = var.region
      zone                   = var.zone
    })
  }
}
