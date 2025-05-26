# R2 Bucket to store backend state.
resource "cloudflare_r2_bucket" "r2_bucket" {
  account_id    = var.account_id
  name          = var.r2_bucket_name
  location      = "WEUR"
  storage_class = "Standard"
}

# Create cloudflare tunnel configuration for Cloudflared.
module "cloudflare_tunnel" {
  source        = "./modules/cloudflare-tunnel"
  account_id    = var.account_id
  zone_id       = var.zone_id
  domain        = var.domain
  tunnel_name   = var.tunnel_cloudflared_name
  tunnel_secret = var.tunnel_cloudflared_secret

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
