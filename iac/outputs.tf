output "account_id" {
  description = "Account Id."
  value       = var.account_id
}

output "zone_id" {
  description = "Zone Id."
  value       = var.account_id
}

output "domain" {
  description = "Domain."
  value       = var.domain
}

output "dns_records" {
  description = "Subdomain and associated DNS records."
  value = {
    for name, record in module.cloudflare_tunnel.dns_records :
    format("%s.%s", name, var.domain) => record.content
  }
}

output "tunnel_cloudflared_id" {
  description = "Cloudflared Access Id."
  value       = module.cloudflare_tunnel.tunnel_cloudflared_id
}

output "tunnel_cloudflared_name" {
  description = "Cloudflared Tunnel Name."
  value       = module.cloudflare_tunnel.tunnel_cloudflared_name
}

output "tunnel_cloudflared_secret" {
  description = "Cloudflared Tunnel Secret."
  value       = module.cloudflare_tunnel.tunnel_cloudflared_secret
  sensitive   = true
}
