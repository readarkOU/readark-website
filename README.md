# readark — corporate website

Static site for **readark** (readark.eu), the trade name of Karaokur OÜ. Plain HTML + CSS + a few lines of JS. No build step, no framework. Deploys to any static host (GitHub Pages, Cloudflare Pages, Netlify, S3).

```
index.html                  Home: who we are, what we work on, principles, products, team, contact
products/annealx.html       Product summary → links to the AnnealX product site
products/battery-sentinel.html
products/juckbox.html
privacy.html
signature/index.html         Gmail signatures for both founders, with a Copy button (unlisted, noindex)
assets/style.css            All styling. Palette is black + white only.
assets/site.js              Nav state, mobile menu, scroll reveal
assets/img/                 Wordmarks (readark-white/black.png), logo mark (mark-white.png), favicon set (favicon-16/32, icon-192/512, apple-touch-icon), OG image (og.png, 1200×630 for LinkedIn), founder portraits, mail-logo.png (240×40 wordmark used by the mail signature)
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

- Repo: https://github.com/readarkOU/readark-website
- Every push to `main` deploys via GitHub Actions (`.github/workflows/pages.yml`) to GitHub Pages.
- Current URL: https://readarkou.github.io/readark-website/
- To move to **readark.eu**: once the AnnealX site has moved off the apex domain, add a `CNAME` file containing `readark.eu` at the repo root, point the domain's DNS at GitHub Pages (A records 185.199.108–111.153, or ALIAS/ANAME to `readarkou.github.io`), then set the custom domain under Settings → Pages and enable "Enforce HTTPS".

## Preview locally

```bash
python3 -m http.server 8080
```

Then open http://localhost:8080.
