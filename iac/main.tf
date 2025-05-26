resource "cloudflare_r2_bucket" "r2_bucket" {
  account_id    = var.account_id
  name          = var.r2_bucket_name
  location      = "WEUR"
  storage_class = "Standard"
}

locals {
  subdomains = {
    atlas = {
      proxied = false
      ttl     = 60
    }
    warp = {
      proxied = true
      ttl     = 1
    }
  }
}

resource "cloudflare_dns_record" "tunnel_subdomains" {
  for_each = local.subdomains

  zone_id = var.zone_id
  comment = "Subdomain for Tunnel."
  content = format("%s.cfargotunnel.com", cloudflare_zero_trust_tunnel_cloudflared.tunnel_cloudflared.id)
  name    = format("%s.%s", each.key, var.domain)
  proxied = each.value.proxied
  ttl     = each.value.ttl
  type    = "CNAME"
}
resource "cloudflare_zero_trust_tunnel_cloudflared" "tunnel_cloudflared" {
  account_id    = var.account_id
  name          = var.tunnel_name
  config_src    = "local"
  tunnel_secret = var.tunnel_cloudflared_secret
}
