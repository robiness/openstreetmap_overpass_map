# Overpass Map Explorer 🗺️

A cross-platform Flutter application for exploring geographic boundaries using OpenStreetMap's Overpass API. Navigate through hierarchical administrative areas (Cities → Bezirke → Stadtteile) with an interactive map interface.

## 🎯 Vision & Roadmap

**Current**: Web application optimized for desktop and mobile browsers  
**Future**: Native Android and iOS apps with enhanced mobile features

## 🌐 Live Demo

**Visit the live app**: [https://tgmp.netlify.app](https://tgmp.netlify.app)  
*Works on desktop browsers and mobile devices*

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

## 🛠️ Development Stack

- **Platform**: macOS development environment
- **Framework**: Flutter (web-first, mobile-ready)
- **Performance**: WebAssembly compilation for web
- **Mapping**: Flutter Map with OpenStreetMap tiles
- **Data**: Overpass API for geographic boundaries
- **State**: Provider for state management
- **Hosting**: Netlify with global CDN

## 📱 Platform Strategy

### Phase 1: Web (Current)
- ✅ **Desktop browsers**: Full-featured experience
- ✅ **Mobile browsers**: Touch-optimized responsive design
- ✅ **PWA capabilities**: Add to home screen, offline caching

### Phase 2: Native Apps (Planned)
- 🔄 **Android app**: Enhanced mobile navigation and gestures
- 🔄 **iOS app**: Native iOS design patterns and performance
- 🔄 **Mobile features**: GPS integration, offline maps, push notifications

## 📋 Development Resources

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Flutter Documentation](https://docs.flutter.dev/)
- [Overpass API Documentation](https://wiki.openstreetmap.org/wiki/Overpass_API)
