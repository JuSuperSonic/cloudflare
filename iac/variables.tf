variable "cloudflare_api_token" {
  description = "Api Token to manage Cloudflare resources."
  type        = string
  # ephemeral   = true
}

variable "zone_id" {
  description = "Zone Id."
  type        = string
}

variable "account_id" {
  description = "Account Id."
  type        = string
}

variable "domain" {
  description = "Domain manage in Cloudflare."
  type        = string
}

variable "tunnel_cloudflared_secret" {
  description = "Cloudflared Tunnel Secret."
  type        = string
  # ephemeral   = true
}

variable "r2_bucket_name" {
  description = "R2 Bucket Name."
  type        = string
  default     = "r2-vlk-iac-ez39js"
}

variable "cloudflare_access_key" {
  description = "Acces Key."
  type        = string
  # ephemeral   = true
}

variable "cloudflare_access_secret" {
  description = "Cloudflared Access Secret."
  type        = string
  # ephemeral   = true
}

variable "tunnel_cloudflared_name" {
  description = "Cloudflared Tunnel Name."
  type        = string
}
