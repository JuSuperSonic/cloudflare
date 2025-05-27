variable "account_id" {
  description = "Cloudflare account Id."
  type        = string
}

variable "zone_id" {
  description = "Cloudflare Zone Id."
  type        = string
}

variable "domain" {
  description = "Domain name."
  type        = string
}

variable "tunnel_name" {
  description = "Name for the Cloudflared tunnel."
  type        = string
}

variable "tunnel_secret" {
  description = "Cloudflare tunnel secret."
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
