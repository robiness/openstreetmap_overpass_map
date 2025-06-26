# Social Exploration Game 🗺️

A social exploration game where users physically explore cities by visiting their neighborhoods, with location-based check-ins, social features, and local business integration. The app uses OpenStreetMap's Overpass API for geographic data and is built with Flutter for cross-platform support, starting with Cologne, Germany.

## 🎯 Vision & Roadmap

**Current**: Web application optimized for desktop and mobile browsers  
**Phase 1**: Basic social exploration with user profiles and GPS check-ins  
**Phase 2**: Advanced social features with real-time collaboration  
**Phase 3**: Business integration and AR-enhanced exploration

## 🌐 Live Demo

**Visit the live app**: [https://tgmp.netlify.app](https://tgmp.netlify.app)  
*Works on desktop browsers and mobile devices*

## ✨ Features

- **Interactive Map** with OpenStreetMap tiles
- **Explore City Neighborhoods** (from city down to street level)
- **Smart Camera Controls** with smooth animations
- **Blazing-Fast Performance** (via WebAssembly)
- **Responsive Design** for desktop and mobile
- **Built-in Dev Tools** (for performance monitoring)

## 🏗️ Phased Development Roadmap
This project is evolving from a map explorer into a full-fledged social exploration game. Our development is broken into several key phases:

- **Phase 0: Foundation (Complete)** - A robust map explorer for web browsers.
- **Phase 1: Social MVP** - Introducing user accounts, GPS check-ins, and progress tracking.
- **Phase 2: Advanced Social** - Building out friend systems, group challenges, and real-time activity.
- **Phase 3: Rich Content** - Adding detailed location data, stories, and user-generated content.
- **Phase 4: Business & AR** - Integrating local businesses and augmented reality features.

📚 See the detailed [ROADMAP.md](ROADMAP.md), [ARCHITECTURE.md](ARCHITECTURE.md), and [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) for a full breakdown of our plans.

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

**Option 1: Automated Script (Recommended)**
```bash
# Deploy to preview
dart scripts/deploy.dart

# Deploy to production
dart scripts/deploy.dart --prod
```

**Option 2: Manual Commands**
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

## 🏗️ Future Data Architecture

### **Core Data Systems**
- **👤 User System**: Profiles, authentication, preferences, achievements
- **📍 Location Data**: GPS check-ins, area visit tracking, exploration verification
- **👥 Social Layer**: Friends, groups, activity feeds, real-time collaboration
- **🗺️ Geographic Data**: Overpass API boundaries, custom POIs, user-generated content
- **🎮 Game Mechanics**: Achievements, challenges, leaderboards, progression tracking
- **📸 Content & Media**: Photo challenges, reviews, user-generated spots
- **🎪 Events & Business**: Local events, business partnerships, special promotions

### **Data Technology Stack**
- **Backend**: Supabase (PostgreSQL + Real-time + Auth + Storage)
- **Local Storage**: SQLite for offline-first experience
- **Geographic Data**: Overpass API + local caching
- **Real-time**: Supabase real-time subscriptions
- **Sync Strategy**: Local-first with background sync to cloud

## 📋 Development Resources

- [**Project Issues**](https://github.com/your-username/your-repo/issues) - Bug reports and feature requests
- [Flutter Documentation](https://docs.flutter.dev/) - General Flutter resources
- [Overpass API Documentation](https://wiki.openstreetmap.org/wiki/Overpass_API) - For geographic data queries
- [Project Structure Guide](PROJECT_STRUCTURE.md) - For how to organize code and features.
