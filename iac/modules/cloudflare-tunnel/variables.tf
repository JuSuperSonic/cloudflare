variable "account_id" {
  description = "Cloudflare account ID"
  type        = string
}

variable "zone_id" {
  description = "Cloudflare Zone ID"
  type        = string
}

variable "domain" {
  description = "Domain name, e.g. example.com"
  type        = string
}

variable "tunnel_name" {
  description = "Name for the Cloudflared tunnel"
  type        = string
}

variable "tunnel_secret" {
  description = "Tunnel secret"
  type        = string
  sensitive   = true
  # ephemeral   = true
}

variable "subdomains" {
  description = "Map of subdomains with proxied and ttl settings"
  type = map(object({
    proxied = bool
    ttl     = number
  }))
}
