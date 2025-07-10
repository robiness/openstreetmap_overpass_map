# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Essential Development Commands

### Running the Application
- **Start web app**: `flutter run -d web-server --web-port 3000 --wasm` (always use WebAssembly on port 3000)
- **Kill existing process on port 3000**: If port is occupied, kill the process and restart

### Build and Code Generation
- **Generate data classes**: `flutter pub run build_runner build --delete-conflicting-outputs`
- **Build for production**: `flutter build web --wasm --release`
- **Get dependencies**: `flutter pub get`
- **Clean build**: `flutter clean`

### Deployment
- **Automated deploy (preview)**: `dart scripts/deploy.dart`
- **Automated deploy (production)**: `dart scripts/deploy.dart --prod`
- **Manual deploy**: `flutter build web --wasm --release && netlify deploy --prod --dir=build/web`

### Code Quality
- **Analyze code**: `flutter analyze`
- **Format code**: `dart format .`

## Architecture Overview

This is a Flutter-based social exploration game built with Clean Architecture principles:

### Core Technology Stack
- **Framework**: Flutter (web-first with mobile support)
- **State Management**: BLoC pattern with flutter_bloc
- **Local Database**: Drift (SQLite) for offline-first functionality
- **Backend**: Supabase for authentication, real-time data, and cloud storage
- **Maps**: flutter_map with OpenStreetMap tiles
- **Geographic Data**: Overpass API for city boundaries and POIs

### Feature-Based Architecture
The codebase follows a feature-based structure with Clean Architecture:

```
lib/
├── features/           # Feature modules (auth, location, map_explorer, debug)
│   └── [feature]/
│       ├── data/       # Repositories, data sources, models
│       ├── domain/     # Entities, repositories interfaces, use cases
│       └── presentation/ # BLoC, screens, widgets
├── data/              # Shared data layer (database, repositories)
├── services/          # Core services (API clients, sync)
└── app/               # App-level configuration (theme, core widgets)
```

### Key Components
- **Authentication**: Supabase auth with Google/Apple sign-in
- **Location Services**: GPS tracking with geolocator
- **Map Explorer**: Interactive map with area exploration and check-ins
- **Offline Support**: Local SQLite database with background sync
- **Real-time Features**: Supabase real-time subscriptions

## Development Guidelines

### Widget Creation
- **Never use build methods** - create new dedicated Widget classes instead
- Follow existing component patterns in features/*/presentation/widgets/

### Code Generation
- Use freezed for data classes and BLoC events/states
- Use json_annotation for serialization
- Always run build_runner with `--delete-conflicting-outputs` flag

### Database
- Use Drift for local database operations
- Follow the repository pattern for data access
- Implement offline-first with background sync to Supabase

### BLoC Pattern
- Use flutter_bloc for state management
- Follow the established event/state pattern with freezed
- Keep business logic in the domain layer

### Testing
- Tests are located in the `test/` directory
- Database tests use helpers from `test/helpers/database_helper.dart`
- Run tests with standard Flutter test commands

## Project Context

This is a social exploration game where users physically explore cities by visiting neighborhoods. The app uses location-based check-ins, social features, and integrates with local businesses. Currently focused on Cologne, Germany as the initial city.

The project is in active development, evolving from a map explorer into a full social gaming experience with phases for user accounts, social features, and business integration.