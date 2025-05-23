output "account_id" {
  value = var.account_id
}

output "tunnel_cloudflared_name" {
  value = cloudflare_zero_trust_tunnel_cloudflared.tunnel_cloudflared.name
}

output "tunnel_cloudflared_id" {
  value = cloudflare_zero_trust_tunnel_cloudflared.tunnel_cloudflared.id
}

output "tunnel_cloudflared_secret" {
  value     = var.tunnel_cloudflared_secret
  sensitive = true
}
