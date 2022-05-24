
resource "vault_pki_secret_backend_cert" "app" {
  backend     = "pki_int"
  name        = var.pki_name
  common_name = var.common_name
}

resource "bigip_as3" "app_services" {
  as3_json = local.as3_json
}

resource "local_file" "as3" {
    content     = local.as3_json
    filename    = "${path.module}/as3-bigip.json"
}

locals {
    as3_json = templatefile("./as3templates/https.tpl", {
    TENANT          = var.tenant
    VIP_ADDRESS     = var.vip_address
    MY_POOLMEMBERS = jsonencode(var.pool_members)
    CERT        = jsonencode(vault_pki_secret_backend_cert.app.certificate)
    KEY = jsonencode(vault_pki_secret_backend_cert.app.private_key)
    CA_CHAIN = jsonencode(vault_pki_secret_backend_cert.app.ca_chain)
  })
}



