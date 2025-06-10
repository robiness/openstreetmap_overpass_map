# Deployment Scripts

This directory contains automation scripts for the Overpass Map Explorer project.

## deploy.dart

Automated deployment script that builds the Flutter web app and deploys it to Netlify.

### Usage

```bash
# Deploy to preview (default)
dart scripts/deploy.dart

# Deploy to production
dart scripts/deploy.dart --prod
```

### What it does

1. **Cleans** previous build artifacts
2. **Gets** Flutter dependencies 
3. **Builds** the web app with release optimizations
4. **Deploys** to Netlify (preview or production)

### Requirements

- Flutter SDK installed
- Netlify CLI installed and authenticated (`npm install -g netlify-cli`)
- Netlify site already configured (should be done via `netlify init`)

### Features

- ✅ Real-time output streaming
- ✅ Error handling with clear messages
- ✅ Production vs preview deployment options
- ✅ Automated build optimization for web
- ✅ Uses CanvasKit renderer for better performance

### Examples

```bash
# Quick preview deployment
dart scripts/deploy.dart

# Production deployment 
dart scripts/deploy.dart --production

# Also works with short flag
dart scripts/deploy.dart --prod
```

The script will output the deployment URL when completed successfully. 