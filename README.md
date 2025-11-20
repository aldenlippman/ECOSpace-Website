# ECOSpace — PurpleAir Widget Demo

This small static site embeds a PurpleAir widget for ECOSpace.

## Files

- `index.html` — The demo page that contains the PurpleAir widget container and script.
- `styles.css` — Minimal styling for layout.

## Run locally

Open PowerShell and run the following from the project folder (serves at http://localhost:8000):

```powershell
python -m http.server 8000
```

Then open http://localhost:8000 in your browser.

## Deployment

You can deploy this as a static site (GitHub Pages, Netlify, Vercel, etc.). For GitHub Pages:

1. Push this repository to GitHub.
2. In the repository Settings > Pages, choose the `main` (or `gh-pages`) branch and `/ (root)` as source.
3. Save — your site will be published at `https://<your-username>.github.io/<repo-name>/`.

## Notes & Security

- The widget loads `https://www.purpleair.com/pa.widget.js` from PurpleAir. The embed includes a key in the query string — ensure you have permission to use it.
- If your site uses a Content Security Policy (CSP), allow `https://www.purpleair.com` for `script-src` and any resources the widget needs.
- The widget may load additional remote resources; review network activity when first loading the page.

## Next steps

- Replace the embedded key if you have your own PurpleAir widget credentials.
- Add a privacy / data policy page if you surface sensor or location data publicly.
