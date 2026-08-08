# 🗺️ Google Maps Clone App

🇧🇷 Leia isto em [Português](README.md)

A mobile app built with Flutter that replicates the core interface and features of Google Maps with a customized map and real-time location.

## 📝 About the Project

The **Google Maps Clone App** is a mobile application developed in Flutter that aims to recreate the user experience and visual interface of Google Maps.

The project features real-time map integration, accurate location detection via GPS, complete handling of location states and permissions, and bottom navigation (Bottom Navigation Bar) following Material Design 3 guidelines.

> 🎨 **Custom Map Style:** The app features a custom Dark Theme exclusively designed for the map, configured via a style file located at `assets/map/style.json`.

## 🖼️ Screen (Preview)

<img src="assets/images/clone-maps.gif" alt="App Demonstration" width="300"/>

## ✨ Features

- 📍 **Real-Time Location:** User's current position identification with map centering.
- 🎨 **Custom Map Styling:** Applied personalized visual look (*Dark Mode*) using `assets/map/style.json`.
- ⚙️ **Smart Handling of Permissions and Services:**
  - Disabled GPS service detection with direct redirect to device location settings screen.
  - Location permission requests with redirection to app settings if permanently denied.
- 🔄 **App Lifecycle Synchronization:** Automatic re-evaluation of location and permissions when the application returns from the background.
- 🧭 **Bottom Navigation Bar (Material 3):** Smooth navigation between *Explore*, *Saved*, and *Contribute* tabs.

## 🛠️ Built With

- **[Flutter](https://flutter.dev/)** - Cross-platform mobile development framework.
- **[Dart](https://dart.dev/)** - Programming language.
- **[google_maps_flutter](https://pub.dev/packages/google_maps_flutter)** - Plugin for rendering and manipulating Google Maps.
- **[geolocator](https://pub.dev/packages/geolocator)** - Plugin for accessing geolocation services and managing GPS permissions.
- **JSON (Assets)** - Vector style configuration and map custom theme (`assets/map/style.json`).

## 🚀 Getting Started

To run this project on your local machine, you will need to have Flutter installed. Then, follow the steps below:

1.  **Clone the repository** (if using git):
    ```bash
    git clone https://github.com/ludson96/7-clone-app-google-maps.git

    cd 7-clone-app-google-maps
    ```

2.  **Install dependencies** using Flutter:
    ```bash
    flutter pub get
    ```

3.  **Run the application**:
    ```bash
    flutter run
    ```
