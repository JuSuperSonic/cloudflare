output "account_id" {
  description = "Account Id."
  value = var.account_id
}

output "tunnel_cloudflared_name" {
  description = "Cloudflared Tunnel Name."
  value = cloudflare_zero_trust_tunnel_cloudflared.tunnel_cloudflared.name
}

output "tunnel_cloudflared_id" {
  description = "Cloudflared Access Id."
  value = cloudflare_zero_trust_tunnel_cloudflared.tunnel_cloudflared.id
}

output "tunnel_cloudflared_secret" {
  description = "Cloudflared Tunnel Secret."
  value     = var.tunnel_cloudflared_secret
  sensitive = true
}
