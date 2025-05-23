resource "cloudflare_r2_bucket" "r2_bucket" {
  account_id    = var.account_id
  name          = var.r2_bucket_name
  location      = "WEUR"
  storage_class = "Standard"
}

resource "cloudflare_dns_record" "atlas_subdomain" {
  zone_id = var.zone_id
  comment = "Subdomain for Tunnel."
  content = format("%s.cfargotunnel.com", cloudflare_zero_trust_tunnel_cloudflared.tunnel_cloudflared.id)
  name    = format("atlas.%s", var.domain)
  proxied = false
  ttl     = 60
  type    = "CNAME"
}

resource "cloudflare_dns_record" "warp_subdomain" {
  zone_id = var.zone_id
  comment = "Subdomain for Tunnel."
  content = format("%s.cfargotunnel.com", cloudflare_zero_trust_tunnel_cloudflared.tunnel_cloudflared.id)
  name    = format("warp.%s", var.domain)
  proxied = true
  ttl     = 1
  type    = "CNAME"
}

resource "cloudflare_zero_trust_tunnel_cloudflared" "tunnel_cloudflared" {
  account_id    = var.account_id
  name          = var.tunnel_name
  config_src    = "local"
  tunnel_secret = var.tunnel_cloudflared_secret
}
