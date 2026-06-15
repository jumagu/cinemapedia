# Cinemapedia

A Flutter application for browsing and discovering movies, powered by [The Movie DB (TMDB)](https://www.themoviedb.org/) API. This educational project follows a Clean Architecture approach and showcases state management with Riverpod, local persistence with Drift, declarative routing, and production-ready configuration (custom icons and splash screen).

## Demo

- [Link to YouTube video](https://youtu.be/64eSKLRDGyo)

## Features

- **Movie Browsing**: Featured slideshow plus horizontal lists for _now playing_, _popular_, _upcoming_, and _top rated_ movies, with infinite scroll
- **Movie Details**: Synopsis, rating, genres, and full cast pulled from TMDB credits
- **Search**: Look up movies by title with a custom search delegate
- **Favorites**: Mark movies as favorites, persisted locally so they survive app restarts, displayed in a masonry grid
- **Clean Architecture**: Domain, infrastructure, and presentation layers with clear separation of concerns
- **Custom Branding**: Generated launcher icons and a native splash screen for iOS and Android

## Installation

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.9.2 or higher)
- Dart SDK (included with Flutter)
- Android Studio / Xcode / VS Code with Flutter extensions
- A [TMDB API key](https://www.themoviedb.org/settings/api)

### Steps

1. Clone the repository:

```bash
git clone https://github.com/jumagu/cinemapedia.git
cd cinemapedia
```

2. Set up environment variables. Rename the file `.env.template` to `.env` and add your TMDB API key:

```bash
THE_MOVIE_DB_API_KEY=your_api_key
```

3. Install dependencies:

```bash
flutter pub get
```

4. Run the app:

```bash
flutter run
```

### Available Commands

- `flutter run` - Run the app in debug mode
- `flutter build apk` - Build Android APK
- `flutter build appbundle` - Build Android App Bundle
- `flutter build ios` - Build iOS app (requires macOS)
- `flutter build windows` - Build Windows desktop app
- `flutter test` - Run tests
- `flutter clean` - Clean build artifacts

## Dependencies

- `flutter` - Flutter SDK
- `flutter_riverpod` (2.6.1) - State management solution
- `go_router` (16.2.0) - Declarative routing package
- `dio` (5.9.0) - HTTP client for TMDB API calls
- `drift` / `drift_flutter` (2.29.0 / 0.2.7) - Reactive SQLite persistence for favorites
- `flutter_dotenv` (6.0.0) - Loads environment variables from `.env`
- `card_swiper` (3.0.1) - Featured movie slideshow
- `flutter_staggered_grid_view` (0.7.0) - Masonry grid layout
- `animate_do` (4.2.0) - Animation utilities
- `intl` (0.20.2) - Number and date formatting
- `path_provider` (2.1.5) - Resolves the local database file path

## Production

To change the Application ID everywhere, on iOS and Android, it's as easy as running the command:

```bash
dart run change_app_package_name:main <package_name>
```

[Flutter Launcher Icons](https://pub.dev/packages/flutter_launcher_icons) can prepare the icons for all available platforms in Flutter. You just need to declare the desired configuration in the `pubspec.yaml` under the `flutter_launcher_icons` section, and then run:

```bash
dart run flutter_launcher_icons
```

To change the Splash Screen, [Flutter Native Splash](https://pub.dev/packages/flutter_native_splash) was used. The configuration is declared in the `pubspec.yaml` under the `flutter_native_splash` section. After setting the desired configuration, run:

```powershell
dart run flutter_native_splash:create
```

In most cases, we'll want to install this library as a development dependency (as it is now), because most likely we'll only need to configure the Splash Screen. However, if we want to preserve/remove the Splash Screen programmatically, it will be necessary to install it as a regular (production) dependency. See the library's [official documentation](https://pub.dev/packages/flutter_native_splash#3-set-up-app-initialization-optional) for more information.

## License

This project is part of a Flutter course.
