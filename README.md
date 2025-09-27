# Don't Wait DEPLOY NOW! 

## What you'll do
- Push to GitHub → a Docker image builds → your app deploys to your unique URL.

## Quick start
1. Fork this repo.
2. Ask the instructor for your subdomain (e.g., `student17.owlhacks-deploy-now.xyz`).
3. In your fork, go to **Settings → Secrets and variables → Actions** and add:
   - `STUDENT_HOST` = your assigned subdomain.
4. Push any change (e.g., edit `resources/views/welcome.blade.php`).
5. Watch **Actions** → `Build & Deploy` → when it’s green, open `https://YOUR_STUDENT_HOST`.

## Local run (optional)
```bash
docker compose -f compose.local.yml up --build
# open http://localhost:8080
