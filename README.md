# Andante Hair Studio — website

A gift site for Andante Hair Studio, 3451 N Central Ave #1, Chicago IL 60634.
Static HTML/CSS, no build step, no JavaScript. Third-party requests are the
Google Maps embed and Google Fonts (Cormorant Garamond, Jost, Parisienne).

## Design

Built on the salon's own branding rather than an invented one. The awning at
3451 N Central is a white brush script over wide-tracked caps on near-black, so
the wordmark is that lockup (Parisienne over Jost) and the palette is black,
white and a single brass accent.

**Booking is by appointment — Andante is not a walk-in shop.** Every page says
so. Do not reintroduce walk-in language.

## Pages

| URL | File | Targets |
|---|---|---|
| `/` | `index.html` | "hair salon chicago", "chicago hair salons", "haircut chicago il" + Portage Park |
| `/services` | `services.html` | "women's haircut chicago", "men's haircut chicago", "kids haircuts chicago", "color" |
| `/about` | `about.html` | brand / trust page, "hair salon portage park" |
| `/contact` | `contact.html` | "andante hair studio hours", NAP + map, local pack support |

`_redirects` maps the `.html` forms to the extensionless URLs (301) and catches
common guesses (`/hours`, `/prices`, `/haircuts`). Same pretty-URL convention as
tvserviceschicago.com.

## Local preview

Cloudflare Pages serves `/services` from `services.html` automatically. A plain
`python -m http.server` does not, so nav links 404 locally. Use a server that
falls back to `.html` — there is one in the scratchpad, or deploy to a Pages
preview branch.

## SEO notes (SEMrush, US database, Aug 2026)

**Neighborhood terms are dead.** `barber portage park` and its variants return
no keyword data at all. No location pages were built and none should be — same
finding as johnsmasonryandroofing.com. Portage Park appears in titles and body
copy for the local pack, not as its own page.

**Where the volume is:**

| Keyword | Volume | KD |
|---|---|---|
| hair salon chicago | 2,400 | 50 |
| chicago hair | 2,400 | 45 |
| chicago hair salons | 1,600 | 40 |
| haircut chicago il | 1,000 | 47 |
| chicago hairdressers | 1,000 | 47 |
| haircut chicago | 880 | 50 |
| hair salons chicago | 720 | 40 |
| chicago hair salons near me | 90 | 31 |

Head salon terms sit at KD 40–51 — a new domain will not rank for them soon.
The realistic win is the **local pack plus long-tail service terms**, which is
why `/services` splits women's / men's / kids' / color into separately
addressable sections, and why the NAP, hours and `HairSalon` JSON-LD are exact
and consistent across every page. Getting the Google Business Profile to point
at this domain will do more than any on-page change.

Barber-shop terms are much easier (`chicago barbershop` 1,600 at KD 32, vs KD 50
for the salon equivalent) — but Andante is a salon that also cuts men's hair,
not a barber shop, so that framing was deliberately removed rather than kept for
the ranking. Men's haircuts are covered honestly on `/services` instead.

## Facts used, and where they came from

- Address, phone, Tue–Sat 10am–6pm, closed Sun/Mon, 5.0 across 36 reviews —
  Google Business Profile, read Aug 15 2026.
- "90% recommend (15 reviews)", the salon description — the Facebook page.
- Payment: cash and cards — from the owner's side. Yelp says "does not take
  credit cards"; that listing is wrong and worth correcting at the source.

## Needs confirmation from the owner

1. **The service list.** Only "a full range of hair care services" was ever
   published. The six cards on `/services` are the ordinary categories for a
   full-service salon, written without any invented specifics. Confirm or cut.
2. ~~Cash only~~ — resolved. She accepts cards. Yelp still says otherwise;
   someone should fix that listing.
3. ~~Walk-ins~~ — resolved. Appointment-only, confirmed by the owner's side.
   Stated on every page.
4. **Photos.** See `photos/README.md` for the five slots and
   `photos/install.sh` to add one. Slots render as designed panels while empty,
   so the site is not broken without them — but real photos are still the
   single biggest remaining improvement.
5. **The review counts** on `/` and `/about` will go stale. Either keep them
   updated or soften to "5.0 on Google".
6. **Staffing.** Copy is written to work for either a solo stylist or a small
   team. If it is one person, `/about` could say so directly and would be
   stronger for it.

## Deploy

Live at **https://andante-hair-studio.pages.dev** (Cloudflare Pages project
`andante-hair-studio`, production branch `main`).

```bash
npx wrangler pages deploy . --project-name andante-hair-studio
```

### Auto-deploy

`.github/workflows/deploy.yml` deploys on every push to `main`. It needs two
repo secrets:

```bash
gh secret set CLOUDFLARE_ACCOUNT_ID --body cb2afb6cac995209211e8e3e57b44d35
gh secret set CLOUDFLARE_API_TOKEN            # paste a token with Pages:Edit
```

Mint the token at Cloudflare → My Profile → API Tokens → Edit Cloudflare
Workers, or a custom token with Account → Cloudflare Pages → Edit. Until both
secrets exist the workflow will fail and deploys stay manual.

### When a real domain shows up

`andantehairstudio.com` is registered but parked at GoDaddy — it is not the
shop's, and it would have to be bought or transferred. Until then, canonicals,
`og:url`, the JSON-LD `url`/`@id`, `sitemap.xml` and `robots.txt` all point at
the pages.dev address so the site is self-consistent and indexable as-is.

Switching domains is one find-and-replace of `https://andante-hair-studio.pages.dev`
across `*.html`, `sitemap.xml` and `robots.txt`, then attaching the domain to
the Pages project.

Website credit: [risendust.com](https://risendust.com).
