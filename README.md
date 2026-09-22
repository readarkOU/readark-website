# readark — corporate website

Static site for **readark OÜ** (readark.eu). Plain HTML + CSS + a few lines of JS. No build step, no framework. Deploys to any static host (GitHub Pages, Cloudflare Pages, Netlify, S3).

```
index.html                  Home: who we are, what we work on, principles, products, team, contact
products/annealx.html       Product summary → links to the AnnealX product site
products/battery-sentinel.html
products/juckbox.html
privacy.html
assets/style.css            All styling. Palette is black + white only.
assets/site.js              Nav state, mobile menu, scroll reveal
assets/img/                 Wordmarks (readark-white/black.png), logo mark (mark-white.png), favicon, OG image (og.png, 1200×630 for LinkedIn), (future) portraits
```

## Placeholders to fill before launch

Every visible placeholder is wrapped in `<span class="ph">…</span>` (dashed underline). Search the repo for `class="ph"` and `PLACEHOLDER`.

| Item | Where | Replace with |
|---|---|---|
| `[REGISTRY CODE]` | all pages (contact block + footer) | Estonian registry code of readark OÜ |
| `[EE VAT NUMBER]` | index.html contact | VAT number, or remove the line if not VAT-registered |
| `[Street address]`, `[Postal code]` | index.html contact | Registered office address |
| `[DATE]` | privacy.html | Date the notice was published |
| `linkedin.com/in/PLACEHOLDER` | index.html team | Each founder's LinkedIn profile URL |
| `linkedin.com/company/readark` | index.html contact + JSON-LD | Confirm the company page slug |
| Team photos | index.html team | Replace each `.placeholder` div with `<img src="assets/img/<name>.jpg" alt="…">`. Any photo works; CSS renders it in greyscale. Recommended 4:5 portrait, at least 1200 px wide. |
| `https://annealx.readark.eu` | index.html contact, products/annealx.html | Final AnnealX product URL once readark.eu is switched to this site |
| Battery Sentinel / JuckBox CTAs | product pages | Point at their product sites when they exist |

After you register the company, also drop the `.ph` class so the dashed underline disappears.

## Editing content

- Product one-liners live in `index.html` under `#products`; longer summaries in each `products/*.html`.
- Section copy is plain HTML; the left column heading and the right column body are independent.
- Keep to black and white. Greys are `rgba(255,255,255,α)` tokens at the top of `style.css`.

## Preview locally

```bash
python3 -m http.server 8080
```

Then open http://localhost:8080.
