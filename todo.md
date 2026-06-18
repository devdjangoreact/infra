# Infrastructure TODO

## In progress

- [ ] Enable automatic infrastructure deployment on push to `main` (terraform apply + sync `compose/` to EC2 + Traefik reload)

## Completed

- [x] Wildcard DNS (`*.domain`) and Traefik subdomain routing for all 6 projects

## Backlog

- [ ] Multi-tenant Telegram bots in `course_hub` (subdomain → bot instance)
