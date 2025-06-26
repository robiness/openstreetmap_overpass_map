# 🗺️ Roadmap

This document outlines the phased development plan for the Social Exploration Game.

## 📱 Development Phases

### **Phase 0: Foundation (Current)**
- ✅ **Web Platform**: A robust map explorer for desktop and mobile browsers, built with Flutter and compiled to WebAssembly for high performance.
- ✅ **Geographic Visualization**: Initial city boundaries (e.g., Cologne) and POIs via Overpass API.
- ✅ **Local Data**: Simple visit tracking using SharedPreferences.

### **Phase 1: Social MVP on Web**
- **Primary Target**: Enhancing the existing web application (desktop & mobile) with social features.
- 🔄 **User Authentication**: Supabase Auth for user accounts.
- 🔄 **GPS Check-ins**: Using browser location services for area verification on mobile devices.
- 🔄 **Progress Tracking**: Cloud-synced completion status for the initial city's neighborhoods.
- 🔄 **Basic Achievements**: First set of exploration milestones and badges.
- 🔄 **Offline-First Storage**: Migrating data to a local SQLite database, synced with Supabase.
- **Future Goal**: Native mobile apps (Android/iOS) will be considered after the web MVP is validated, to offer enhanced features like background services and push notifications.

### **Phase 2: Advanced Social Features**
- ❌ **Friend System**: Connect with other explorers, friend requests
- ❌ **Real-time Activity**: Live friend activity feeds and notifications
- ❌ **Group Challenges**: Multi-player exploration challenges
- ❌ **Photo Sharing**: Location-based photo challenges and sharing
- ❌ **Leaderboards**: Community competition and rankings
- ❌ **Social Discovery**: Find and connect with nearby explorers

### **Phase 3: Rich Content & Gamification**
- ❌ **Multi-City Support**: Ability to switch between different cities and explore their unique neighborhoods.
- ❌ **POI Database**: Detailed information per stadtteil/neighborhood.
- ❌ **Location Stories**: Historical facts, local trivia, hidden gems
- ❌ **Advanced Achievements**: Complex unlock conditions and skill trees
- ❌ **User-Generated Content**: Reviews, custom spots, area recommendations
- ❌ **Seasonal Events**: Time-limited challenges and special rewards
- ❌ **Analytics Dashboard**: Personal exploration insights and city trends

### **Phase 4: Business Integration & AR**
- ❌ **Event Integration**: Castell Club events and local business partnerships
- ❌ **AR Features**: Augmented reality navigation and discovery
- ❌ **Local Business Network**: Promoted locations, discounts, partnerships
- ❌ **Advanced Analytics**: Business insights and community engagement metrics
- ❌ **Monetization**: Premium features, business partnerships, event promotion

## Current Status: Phase 1 Complete ✅

### ✅ **Web Application (Live)**
- **Platform**: Flutter Web with WebAssembly
- **Live URL**: https://tgmp.netlify.app
- **Target**: Desktop and mobile browsers
- **Features**: Interactive maps, boundary exploration, responsive design

## Development Environment

### 🖥️ **Primary Development**
- **Platform**: macOS (development machine)
- **IDE**: Cursor/VS Code with Flutter extensions
- **Testing**: Chrome DevTools, Firefox, Safari
- **Deployment**: Automated via Netlify CLI

### 🌐 **Web Deployment Pipeline**
```bash
# Development cycle
flutter run -d web-server --web-port 3000 --wasm  # Local testing
flutter build web --wasm --release                # Production build
netlify deploy --prod --dir=build/web             # Live deployment
```

## Upcoming Phases

### 📱 **Phase 2: Native Mobile Apps**

#### **Android App** 🤖
- **Timeline**: Q2 2024 (planned)
- **Platform**: Google Play Store
- **Enhanced Features**:
  - Native Android navigation patterns
  - GPS integration for location-based exploration
  - Offline map caching
  - Material Design 3 components
  - Android-specific gestures and interactions

#### **iOS App** 🍎
- **Timeline**: Q3 2024 (planned)  
- **Platform**: Apple App Store
- **Enhanced Features**:
  - Native iOS design patterns
  - Core Location integration
  - Offline capabilities with iCloud sync
  - iOS-specific UI components
  - Optimized for iPhone and iPad

### 🔄 **Phase 3: Advanced Features**
- **Real-time collaboration**: Share map views with others
- **Custom boundary creation**: User-defined geographic areas
- **Data export**: GPX, KML, GeoJSON export capabilities
- **Advanced analytics**: Usage patterns and popular areas
- **Multi-language support**: Internationalization

## Technical Strategy

### 🎯 **Code Reuse Philosophy**
- **Shared codebase**: 90%+ code sharing between web and mobile
- **Platform-specific**: UI adaptations and native integrations
- **Responsive design**: Single codebase, multiple form factors

### 🔧 **Development Approach**
1. **Web-first development**: Rapid iteration and testing
2. **Progressive enhancement**: Add mobile-specific features
3. **Platform optimization**: Leverage native capabilities when beneficial

### 📊 **Quality Assurance**
- **Cross-platform testing**: Web, Android, iOS
- **Performance monitoring**: WebAssembly optimization, native performance
- **User feedback integration**: Continuous improvement based on usage data

## Success Metrics

### 📈 **Phase 1 (Web) - Current**
- ✅ Successful deployment to production
- ✅ Cross-browser compatibility
- ✅ Mobile-responsive design
- ✅ WebAssembly performance optimization

### 📱 **Phase 2 (Mobile) - Targets**
- [ ] Android app store approval
- [ ] iOS app store approval  
- [ ] 90%+ code reuse from web version
- [ ] Native performance benchmarks met
- [ ] Positive user ratings (4.0+ stars)

## Development Dependencies

### **Current Tools**
- Flutter SDK (latest stable)
- Dart SDK
- Netlify CLI
- Git version control

### **Future Requirements**
- Android Studio (Android development)
- Xcode (iOS development) 
- Firebase (backend services)
- App Store developer accounts

---

**Last Updated**: Initial roadmap creation  
**Next Review**: After Phase 2 planning completion 