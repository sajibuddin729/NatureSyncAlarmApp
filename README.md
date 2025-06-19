# Nature Sync Alarm App 🌅

A beautiful Flutter mobile app that syncs alarms with nature's rhythm, featuring sunset-based notifications and location-aware timing.

## 📱 Features

- **Beautiful Onboarding Experience**: Three stunning onboarding screens with gradient backgrounds
- **Location-Based Alarms**: Automatically sync alarms with sunset/sunrise times based on your location
- **Smart Notifications**: Local notifications that remind you 15 minutes before sunset
- **Intuitive UI**: Dark theme with modern design matching the provided Figma mockups
- **Alarm Management**: Add, edit, toggle, and delete alarms with ease
- **Cross-Platform**: Runs on Android, iOS, and Web

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** (3.0.0 or higher)
- **Dart SDK** (included with Flutter)
- **Android Studio** or **VS Code** with Flutter extensions
- **Git**

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/sajibuddin729/nature-sync-alarm.git
   cd nature-sync-alarm
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Enable Developer Mode (Windows only)**
   ```bash
   start ms-settings:developers
   ```
   Toggle "Developer Mode" to ON in the settings window.

4. **Add image assets** (optional)
   - Create `assets/images/` directory in your project root
   - Add your onboarding images:
     - `onboarding1.jpg`
     - `onboarding2.jpg`
     - `onboarding3.jpg` 

5. **Run the app**
   ```bash
   # For mobile development
   flutter run
   
   # For web development
   flutter run -d chrome
   
   # For Windows desktop
   flutter run -d windows
   ```

## 🛠️ Tools & Packages Used

### Core Flutter Packages
- **flutter**: The main Flutter SDK
- **cupertino_icons**: iOS-style icons

### Location Services
- **geolocator** (^10.1.0): Get device location and handle permissions
- **geocoding** (^2.1.1): Convert coordinates to human-readable addresses

### Notifications
- **flutter_local_notifications** (^16.3.2): Schedule and display local notifications
- **timezone** (^0.9.2): Handle timezone calculations for notifications

### Data Storage
- **shared_preferences** (^2.2.2): Store user preferences and alarm data locally

### Utilities
- **intl** (^0.19.0): Internationalization and date formatting

### Development Tools
- **flutter_test**: Testing framework
- **flutter_lints** (^3.0.0): Dart linting rules


## 🔧 Configuration

### Android Setup

Add these permissions to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM" />
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
<uses-permission android:name="android.permission.VIBRATE" />
```

### iOS Setup

Add location permission to `ios/Runner/Info.plist`:

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs location access to sync alarms with sunset times.</string>
```

## 🎨 Design

The app follows the provided Figma design with:
- **Dark theme** with gradient backgrounds
- **Modern UI components** with rounded corners and shadows
- **Responsive design** that works on different screen sizes
- **Smooth animations** and transitions between screens

## 🚀 Building for Production

### Android APK
```bash
flutter build apk --release
```

### iOS App
```bash
flutter build ios --release
```

### Web App
```bash
flutter build web --release
```

## 🧪 Testing

Run tests with:
```bash
flutter test
```

### Getting Help

If you encounter issues:
1. Check `flutter doctor` for setup problems
2. Run `flutter clean && flutter pub get`
3. Restart your IDE/editor
4. Check the [Flutter documentation](https://flutter.dev/docs)


## 📞 Support

For support, email sajibuddin729@gmail.com or create an issue in this repository.

---

**Built with ❤️ using Flutter**
```
