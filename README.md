# ECOSpace — PurpleAir Widget Demo

This small static site embeds a PurpleAir widget for ECOSpace.

## Files

- `index.html` — The demo page that contains the PurpleAir widget container and script.
- `styles.css` — Minimal styling for layout.
- `serve.ps1` — For running locally. 

## Run locally

Open PowerShell and `cd` into the project workspace folder, then run the following:

```powershell
python -m http.server 8000
```
or
```
powershell -NoProfile -ExecutionPolicy Bypass -File .\serve.ps1 -Port 8000
```

Then open http://localhost:8000 in your browser.

## Deployment

For testing, website is deployed at `https://aldenlippman.github.io/ECOSpace-Website/`.

## Next steps

- Replace the embedded key if you have your own PurpleAir widget credentials.
- Add a privacy / data policy page if you surface sensor or location data publicly.


