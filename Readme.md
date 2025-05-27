![Cloudflare Logo](https://cf-assets.www.cloudflare.com/slt3lc6tev37/fdh7MDcUlyADCr49kuUs2/5f780ced9677a05d52b05605be88bc6f/cf-logo-v-rgb.png?_gl=1*wbg9h0*_gcl_au*MTYwNDEzMzA3Ny4xNzQxNzA4MTI3*_ga*Yzc0MjRlNzgtM2Q5Ny00OWJhLWEyZTEtYWE4ZWUyMzE4MmE1*_ga_SQCRB0TXZW*czE3NDgzMzU2NjYkbzEyJGcwJHQxNzQ4MzM1NjY3JGo1OSRsMCRoMCRkTkhydnFqRVZfYnNjeTV6SE9TbnRwSjVmTktPSDRqQVRpdw.. "Cloudflare")

# Description

Cloudflared is a lightweight command-line tool that creates a secure, outbound-only connection from your infrastructure to Cloudflare. It's primarily used to expose local or private services to the internet via [Cloudflare Tunnel](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/).

# Installation

### Debian/Ubuntu

```bash
curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb -o cloudflared.deb
sudo dpkg -i cloudflared.deb
```

### macOS

```bash
brew install cloudflared
```

### Docker
```bash
docker pull cloudflare/cloudflared:latest
```

## Prerequisite

- [Create a Cloudflare Account](https://dash.cloudflare.com/)
- [Add Domain](https://developers.cloudflare.com/fundamentals/setup/manage-domains/add-site/)

## Authentication

To authenticate cloudflared with your Cloudflare account :

```bash
cloudflared tunnel login
```

This opens a browser to authorize the tool and associate it with your Cloudflare account.

# Create and Run a Tunnel in Cli

### 1 -  Create the tunnel

```bash
cloudflared tunnel create "${TUNNEL_NAME}"
```

This generates a tunnel ID and associated credentials.

### 2 - Configure the tunnel

Create a `config.yml`:

```yaml
# ~/.cloudflared/config.yml
tunnel: "${TUNNEL_UUID}"
credentials-file: "/root/.cloudflared/${TUNNEL_UUID}.json"

ingress:
  - hostname: app.example.com
    service: http://localhost:8080
  - service: http_status:404
```

### 3 - Route traffic

```bash
cloudflared tunnel route dns "${TUNNEL_NAME}" app.example.com
```

This sets up a CNAME in Cloudflare DNS pointing to the tunnel endpoint.

### 4 - Run the tunnel

```bash
cloudflared tunnel run "${TUNNEL_NAME}"
```

Or as a systemd service:

```bash
sudo cloudflared service install
```

# Create and Run on Kubernetes with Iac

### 1 - Create Account API Tokens

[Create Token Documentation](https://developers.cloudflare.com/fundamentals/api/get-started/account-owned-tokens/)

Minimum Rights to Apply :

#### Permission

| Type | Service | Action |
|------|---------|--------|
|Account | Workers R2 Storage | Edit|
|Account | Cloudflare Tunnel | Edit |
|Zone | DNS | Edit |

#### Zone Resources

| Action | Service | Domain |
|--------|---------|--------|
|Include | Specific Zone | `app.example.com` |

### 2 - Initialize Variables File

```bash
iac_dir="iac"

grep -oP 'variable\s+"\K[^"]+' "${iac_dir}/variables.tf" | awk '{print $1" = \"\""}' > "${iac_dir}/terraform.tfvars" && terraform fmt "${iac_dir}/terraform.tfvars"
```

### 3 - Bootstrap (First Installation)

```bash
iac_dir="iac"

mv "${iac_dir}/backend.tf" "${iac_dir}/backend.tfake" && terraform -chdir="${iac_dir}" init
terraform -chdir="${iac_dir}" apply && mv "${iac_dir}/backend.tfake" "${iac_dir}/backend.tf"
terraform -chdir="${iac_dir}" init -reconfigure
```

### 4 - Update Iac

```bash
iac_dir="iac"

terraform -chdir="${iac_dir}" apply
```

### 5 - Deploy Helm Chart

Fill the information into `charts/values.yaml` get from Terraform outputs :

- account >> account_id
- tunnelName >> tunnel_cloudflared_name
- tunnelId >> tunnel_cloudflared_id
- secret >> tunnel_cloudflared_secret

💡 You can get secret from this command :

```bash
terraform -chdir="${iac_dir}" output tunnel_cloudflared_secret
```

Apply chart into Kubernetes :

```bash
charts_dir="charts"

helm repo add cloudflare https://cloudflare.github.io/helm-charts && helm repo update
helm upgrade --install --reset-values --force --values "${charts_dir}/values.yaml" --wait --create-namespace --namespace network cloudflared cloudflare/cloudflare-tunnel
```
