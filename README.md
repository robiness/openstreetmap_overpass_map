# Overpass Map Explorer 🗺️

A Flutter web application for exploring geographic boundaries using OpenStreetMap's Overpass API. Navigate through hierarchical administrative areas (Cities → Bezirke → Stadtteile) with an interactive map interface.

## 🌐 Live Demo

**Visit the live app**: [https://tgmp.netlify.app](https://tgmp.netlify.app)

## ✨ Features

- **Interactive Map** with OpenStreetMap tiles
- **Geographic Boundary Explorer** using Overpass API
- **Hierarchical Area Navigation** (Cities → Districts → Neighborhoods)
- **Smart Camera Controls** with smooth animations
- **Performance Monitoring** overlay
- **WebAssembly Optimized** for fast execution
- **Responsive Design** for desktop and mobile

## 🚀 Quick Start

### Run Locally
```bash
# Install dependencies
flutter pub get

# Run in WebAssembly mode (recommended)
flutter run -d web-server --web-port 3000 --wasm
```

Visit: http://localhost:3000

### Deploy Updates
```bash
flutter build web --wasm --release && netlify deploy --prod --dir=build/web
```

📚 **See [DEPLOYMENT.md](DEPLOYMENT.md) for setup and troubleshooting**

## 🛠️ Technology Stack

- **Flutter Web** with WebAssembly compilation
- **Flutter Map** for interactive mapping
- **Overpass API** for geographic data
- **Provider** for state management
- **Netlify** for hosting and deployment

## 📋 Development Resources

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Flutter Documentation](https://docs.flutter.dev/)
- [Overpass API Documentation](https://wiki.openstreetmap.org/wiki/Overpass_API)
