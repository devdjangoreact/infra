# Site A-records ONLY. This file MUST NOT manage MX, TXT (SPF/DKIM/DMARC), mail CNAME/SRV,
# or any other pre-existing record. Mail and non-site records stay under manual control in
# Cloudflare. Never import a whole zone or use a zone-wide ownership resource here.
resource "cloudflare_dns_record" "site" {
  for_each = local.services

  zone_id = data.cloudflare_zone.site[each.key].zone_id
  name    = each.key
  type    = "A"
  content = aws_eip.web.public_ip
  proxied = false
  ttl     = 60
  comment = "Managed by Terraform (${local.project}) - site A-record only"
}

# Wildcard A-record so each project can use one-level subdomains (e.g. bot1.ddnsteltonicka.pp.ua).
# Traefik routes subdomains to the same container as the apex domain; Let's Encrypt issues
# per-subdomain certs on first HTTPS request via HTTP-01.
resource "cloudflare_dns_record" "site_wildcard" {
  for_each = local.services

  zone_id = data.cloudflare_zone.site[each.key].zone_id
  name    = "*"
  type    = "A"
  content = aws_eip.web.public_ip
  proxied = false
  ttl     = 60
  comment = "Managed by Terraform (${local.project}) - wildcard A-record for project subdomains"
}
