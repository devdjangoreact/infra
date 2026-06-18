# Infrastructure TODO

## In progress

- [ ] Enable automatic infrastructure deployment on push to `main` (terraform apply + sync `compose/` to EC2 + `docker compose up -d`)
- [ ] Subdomain HTTPS: Traefik wildcard TLS via Cloudflare DNS-01 (`HostRegexp` does not trigger HTTP-01 per-host certs)

## Completed

- [x] Wildcard DNS (`*.domain`) A-records in Cloudflare (terraform apply 2026-06-18)
- [x] Traefik subdomain routing (`Host` + `HostRegexp`) — `bot1.ddnsteltonicka.pp.ua` reaches `ddnsteltonicka` container
- [x] Full stack redeploy on EC2 (`ship` + `up`) after infra changes

## Backlog

- [ ] Multi-tenant Telegram bots in `course_hub` (subdomain → bot instance)
- [ ] `git push origin main` for commit `04a17dd` (local only; needs GitHub auth or `deploy_all.py --phase github`)

## Verification notes (2026-06-18)

| Check | Result |
|-------|--------|
| `bot1.ddnsteltonicka.pp.ua` DNS → EC2 IP | OK |
| Apex HTTPS (`ddnsteltonicka.pp.ua`) | OK (Let's Encrypt) |
| Subdomain routing (`/health` with `-k`) | OK `200 {"status":"ok"}` |
| Subdomain trusted HTTPS | Pending (Traefik default cert until DNS-01 wildcard) |
| All 6 apex domains (`validate`) | OK |

**Note:** `terraform apply` recreated the EC2 instance (new host key). Elastic IP unchanged (`63.185.31.246`).
