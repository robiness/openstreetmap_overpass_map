# 🚀 Deployment Guide

## Deploy New Version

```bash
# Build and deploy to Netlify
flutter build web --wasm --release
netlify deploy --prod --dir=build/web
```

## Setup (One-time only)
```bash
npm install -g netlify-cli
netlify login
```

## Live URLs
- **App**: https://tgmp.netlify.app
- **Dashboard**: https://app.netlify.com/projects/tgmp

## Troubleshooting
- Build issues: `flutter clean && flutter pub get`
- Auth issues: `netlify logout && netlify login` 