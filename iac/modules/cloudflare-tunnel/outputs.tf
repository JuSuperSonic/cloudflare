output "dns_records" {
  description = "Created DNS records."
  value       = cloudflare_dns_record.tunnel_subdomains
}

output "tunnel_cloudflared_id" {
  description = "Cloudflared Access Id."
  value       = cloudflare_zero_trust_tunnel_cloudflared.tunnel_cloudflared.id
}

output "tunnel_cloudflared_name" {
  description = "Cloudflared Tunnel Name."
  value       = cloudflare_zero_trust_tunnel_cloudflared.tunnel_cloudflared.name
}

output "tunnel_cloudflared_secret" {
  description = "Cloudflared Tunnel Secret."
  value       = cloudflare_zero_trust_tunnel_cloudflared.tunnel_cloudflared.tunnel_secret
  sensitive   = true
}
