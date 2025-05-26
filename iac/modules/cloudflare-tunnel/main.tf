resource "cloudflare_zero_trust_tunnel_cloudflared" "tunnel_cloudflared" {
  account_id    = var.account_id
  name          = var.tunnel_name
  config_src    = "local"
  tunnel_secret = var.tunnel_secret
}

resource "cloudflare_dns_record" "tunnel_subdomains" {
  for_each = var.subdomains

  zone_id = var.zone_id
  comment = "Subdomain for Tunnel."
  content = format("%s.cfargotunnel.com", cloudflare_zero_trust_tunnel_cloudflared.tunnel_cloudflared.id)
  name    = format("%s.%s", each.key, var.domain)
  proxied = each.value.proxied
  ttl     = each.value.ttl
  type    = "CNAME"
}
