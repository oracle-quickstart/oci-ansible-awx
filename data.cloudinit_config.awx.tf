data cloudinit_config awx {
  gzip          = false
  base64_encode = true
  part {
    content_type = "text/cloud-config"
    content = templatefile(
      "./metadata.awx.cloud-config",
      {
        GIT_CHECKOUT       = "/root/awx",
        GIT_REPO           = "https://github.com/ansible/awx",
        GIT_TAG            = var.awx_version,
        AWX_ADMIN_USERNAME = var.awx_admin_username,
        AWX_ADMIN_PASSWORD = var.awx_admin_password,
        AWX_PG_USERNAME    = var.awx_pg_username,
        AWX_PG_PASSWORD    = var.awx_pg_password,
        AWX_DOCKER_COMPOSE = "/srv/awx",
        AWX_PG_DATA        = "/srv/pgdata",
        AWX_SECRET_KEY     = var.awx_secret,
      }
    )
  }
  part {
    content_type = "text/x-shellscript"
    content = templatefile(
      "./metadata.awx.sh", {
        GIT_CHECKOUT       = "/root/awx",
        GIT_REPO           = "https://github.com/ansible/awx",
        GIT_TAG            = var.awx_version,
        AWX_ADMIN_USERNAME = var.awx_admin_username,
        AWX_ADMIN_PASSWORD = var.awx_admin_password,
        AWX_PG_USERNAME    = var.awx_pg_username,
        AWX_PG_PASSWORD    = var.awx_pg_password,
        AWX_DOCKER_COMPOSE = "/srv/awx",
        AWX_PG_DATA        = "/srv/pgdata",
        AWX_SECRET_KEY     = var.awx_secret,
      }
    )
  }
}
