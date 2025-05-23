terraform {
  backend "s3" {
    bucket                      = var.r2_bucket_name
    key                         = "valkhium/state/terraform.tfstate"
    region                      = "auto"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    use_path_style              = true
    access_key                  = var.cloudflare_access_key
    secret_key                  = var.cloudflare_access_secret
    endpoints                   = { s3 = format("https://%s.r2.cloudflarestorage.com", var.account_id) }
  }
}
