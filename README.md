# readark — corporate website

Static site for **readark** (readark.eu), the trade name of Karaokur OÜ. Plain HTML + CSS + a few lines of JS. No build step, no framework. Deploys to any static host (GitHub Pages, Cloudflare Pages, Netlify, S3).

```
index.html                  Home: who we are, what we work on, principles, products, team, contact
products/annealx.html       Product summary → links to the AnnealX product site
products/battery-sentinel.html
products/juckbox.html
privacy.html
signature/index.html         Gmail signatures for both founders, with a Copy button (unlisted, noindex)
logo/readark-logo.png       Hosted logo for anything that wants a logo URL (invoices, directories): white wordmark on a black rounded tile, 2160×576
logo/readark-logo-transparent-white.png  Same canvas and placement, white wordmark on a transparent background
logo/readark-logo-transparent-black.png  Same canvas and placement, black wordmark on a transparent background (for white pages such as invoices)
assets/style.css            All styling. Palette is black + white only.
assets/site.js              Nav state, mobile menu, scroll reveal
assets/img/                 Wordmarks (readark-white/black.png), logo mark (mark-white.png), favicon set (favicon-16/32, icon-192/512, apple-touch-icon), OG image (og.png, 1200×630 for LinkedIn), founder portraits, profile-1024.png (mail profile photo), mail-logo-tile.png (wordmark on a white rounded tile, used by the mail signature so it stays visible in dark mode)
```

## Placeholders to fill before launch

Company details (legal name Karaokur OÜ, registry code, address, LinkedIn links) and founder photos are in. Remaining items are marked with `PLACEHOLDER` comments in the HTML.

| Item | Where | Replace with |
|---|---|---|
| `https://annealx.readark.eu` | index.html contact, products/annealx.html | Final AnnealX product URL once readark.eu is switched to this site |
| Battery Sentinel / JuckBox CTAs | product pages | Point at their product sites when they exist |


## Editing content

- Product one-liners live in `index.html` under `#products`; longer summaries in each `products/*.html`.
- Section copy is plain HTML; the left column heading and the right column body are independent.
- Keep to black and white. Greys are `rgba(255,255,255,α)` tokens at the top of `style.css`.

## Deploy

**readark.eu** is served from the Contabo VPS (144.91.115.219), the same machine as JuckBox, in its own compartment:

- `/opt/readark` on the server: `docker-compose.yml` + `nginx.conf` (copies of `deploy/`), and `www/site/` with the files. Own compose project `readark`, container `readark-site`, own network `readark_default`, no published ports.
- JuckBox's Caddy container (owner of ports 80/443) is joined to `readark_default` and has a `readark.eu` block in `/opt/juckbox/Caddyfile`, plus the network in `/opt/juckbox/docker-compose.deploy.yml`. That is the only shared touch point; TLS comes from Caddy automatically.
- Ship a new version with `bash scripts/deploy.sh` (ships HEAD; pass a ref to ship something else). It uses `git archive`, so `.gitattributes` decides what goes: the signature page, its assets, README and deploy files stay out.
- DNS: `readark.eu` and `www.readark.eu` A records point at the VPS (Hostinger DNS, which also holds the Google Workspace MX records).

**GitHub Pages** (https://readarkou.github.io/readark-website/) still deploys on every push to `main` via `.github/workflows/pages.yml`. It hosts the full repo including `signature/`, which the mail signatures and the profile photo link to.

## Preview locally

```bash
python3 -m http.server 8080
```

Then open http://localhost:8080.
