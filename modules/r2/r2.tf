provider "cloudflare" {
  api_token = "var.cloudflare_api_token"
}

resource "cloudflare_r2_bucket" "cloudflare-bucket" {
  account_id = "<YOUR_ACCOUNT_ID>"
  name       = "r2-vlk-hub-"
  location   = "auto"
}