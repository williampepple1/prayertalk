# Prayer Talk - Development Guide

## Project Structure

```
prayertalk/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── models/
│   │   └── prayer.dart              # Prayer data models
│   ├── data/
│   │   └── prayer_data.dart         # Prayer content/database
│   ├── services/
│   │   └── tts_service.dart         # Text-to-speech service
│   └── screens/
│       ├── prayer_list_screen.dart  # Main list screen
│       └── prayer_player_screen.dart # Prayer player screen
├── android/                          # Android-specific code
├── ios/                              # iOS-specific code
├── web/                              # Web-specific code
├── windows/                          # Windows-specific code
├── pubspec.yaml                      # Dependencies
└── README.md                         # Documentation
```

## Architecture Overview

### Models Layer
**File**: `lib/models/prayer.dart`

Defines the data structures:
- `Prayer`: Represents a complete prayer
- `PrayerLine`: Individual line within a prayer
- `PrayerLineType`: Enum for line types (leader, response, both)

### Data Layer
**File**: `lib/data/prayer_data.dart`

Contains:
- Static method `getPrayers()` returning list of all prayers
- All prayer content
- Easy to extend with more prayers

### Service Layer
**File**: `lib/services/tts_service.dart`

Handles all TTS functionality:
- TTS initialization and configuration
- Speech synthesis
- Playback control (play, pause, stop)
- Call-and-response logic
- Settings management

### Presentation Layer
**Files**: `lib/screens/*.dart`

- `prayer_list_screen.dart`: Displays all prayers with filtering
- `prayer_player_screen.dart`: Interactive prayer player with controls

## Adding New Prayers

### Step 1: Create Prayer Object

Add to `lib/data/prayer_data.dart` in the `getPrayers()` method:

```dart
Prayer(
  id: 'unique_prayer_id',
  title: 'Prayer Title',
  category: 'Category Name',
  lines: [
    PrayerLine(
      text: 'Prayer text here',
      type: PrayerLineType.leader,
      pauseDurationSeconds: 2,
    ),
    PrayerLine(
      text: 'Response text here',
      type: PrayerLineType.response,
      pauseDurationSeconds: 3,
    ),
    // Add more lines...
  ],
),
```

### Step 2: Choose Line Types

- `PrayerLineType.leader`: Spoken by the app, user listens
- `PrayerLineType.response`: User speaks, longer pause
- `PrayerLineType.both`: Everyone speaks together

### Step 3: Set Pause Durations

- Leader lines: 1-2 seconds (short pause)
- Response lines: 3-5 seconds (time for user to respond)
- Both lines: 2-4 seconds (time to speak together)

## Customizing the TTS Service

### Changing Default Settings

In `lib/services/tts_service.dart`, modify the `initialize()` method:

```dart
await _flutterTts.setLanguage('en-US');  // Change language
await _flutterTts.setSpeechRate(0.5);    // Change default speed
await _flutterTts.setVolume(1.0);        // Change default volume
await _flutterTts.setPitch(1.0);         // Change voice pitch
```

### Adding Voice Selection

```dart
// Get available voices
List<dynamic> voices = await _ttsService.getVoices();

// Set specific voice
await _ttsService.setVoice({
  "name": "Karen",
  "locale": "en-AU"
});
```

## Modifying the UI

### Changing Colors

In `lib/main.dart`, modify the theme:

```dart
theme: ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,  // Change primary color
    brightness: Brightness.light,
  ),
  useMaterial3: true,
),
```

### Adding Dark Mode

```dart
darkTheme: ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
),
themeMode: ThemeMode.system,  // Follow system theme
```

### Customizing Line Colors

In `lib/screens/prayer_player_screen.dart`, modify `_getLineColor()`:

```dart
Color _getLineColor(PrayerLineType type) {
  switch (type) {
    case PrayerLineType.leader:
      return Colors.blue[100]!;      // Change leader color
    case PrayerLineType.response:
      return Colors.green[100]!;     // Change response color
    case PrayerLineType.both:
      return Colors.purple[100]!;    // Change both color
  }
}
```

## Development Workflow

### Setting Up Development Environment

1. **Install Flutter**
   ```bash
   # Follow official guide: https://flutter.dev/docs/get-started/install
   ```

2. **Clone Repository**
   ```bash
   git clone <repository-url>
   cd prayertalk
   ```

3. **Get Dependencies**
   ```bash
   flutter pub get
   ```

4. **Run Analysis**
   ```bash
   flutter analyze
   ```

5. **Run Tests**
   ```bash
   flutter test
   ```

### Running the App

**Development Mode:**
```bash
flutter run
```

**With Hot Reload:**
- Press `r` to hot reload
- Press `R` to hot restart
- Press `q` to quit

**On Specific Device:**
```bash
flutter devices                    # List devices
flutter run -d <device-id>         # Run on specific device
flutter run -d android             # Run on Android
flutter run -d windows             # Run on Windows
flutter run -d chrome              # Run on Chrome
```

### Building Release Versions

**Android APK:**
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

**Android App Bundle:**
```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

**iOS:**
```bash
flutter build ios --release
```

**Web:**
```bash
flutter build web --release
# Output: build/web/
```

**Windows:**
```bash
flutter build windows --release
# Output: build/windows/runner/Release/
```

## Testing

### Unit Tests

Create tests in `test/` directory:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:prayertalk/models/prayer.dart';

void main() {
  test('Prayer model should create correctly', () {
    final prayer = Prayer(
      id: 'test',
      title: 'Test Prayer',
      category: 'Test',
      lines: [],
    );
    
    expect(prayer.id, 'test');
    expect(prayer.title, 'Test Prayer');
  });
}
```

### Widget Tests

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prayertalk/screens/prayer_list_screen.dart';

void main() {
  testWidgets('Prayer list shows prayers', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: PrayerListScreen()),
    );
    
    expect(find.text('Prayer Talk'), findsOneWidget);
  });
}
```

## Code Style

### Formatting
```bash
flutter format .
```

### Linting
The project uses `flutter_lints`. Rules are in `analysis_options.yaml`.

### Best Practices
- Use `const` constructors where possible
- Follow Dart naming conventions
- Add documentation comments for public APIs
- Keep functions small and focused
- Use meaningful variable names

## Debugging

### Flutter DevTools
```bash
flutter pub global activate devtools
flutter pub global run devtools
```

### Print Debugging
Use `debugPrint()` instead of `print()`:
```dart
debugPrint('Debug message: $variable');
```

### Logging
For production, consider using a logging package:
```dart
import 'package:logger/logger.dart';

final logger = Logger();
logger.d('Debug message');
logger.i('Info message');
logger.w('Warning message');
logger.e('Error message');
```

## Performance Optimization

### Tips
1. **Use `const` widgets**: Reduces rebuilds
2. **Avoid deep widget trees**: Keep hierarchy shallow
3. **Profile performance**: Use Flutter DevTools
4. **Lazy loading**: Load data only when needed
5. **Dispose resources**: Always dispose controllers and services

### Performance Profiling
```bash
flutter run --profile
```

Then use DevTools to analyze performance.

## Common Issues & Solutions

### TTS Not Working

**Problem**: No sound when playing prayer

**Solutions**:
1. Check device volume
2. Verify TTS is initialized
3. Test on different device/platform
4. Check TTS permissions (if required)

### Build Errors

**Problem**: Build fails with dependency errors

**Solutions**:
```bash
flutter clean
flutter pub get
flutter pub upgrade
flutter build <platform>
```

### Hot Reload Not Working

**Problem**: Changes not reflecting

**Solutions**:
1. Try hot restart (`R`)
2. Stop and restart app
3. Check for syntax errors
4. Clean and rebuild

## Contributing

### Contribution Guidelines

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. **Make your changes**
4. **Test thoroughly**
5. **Commit with clear messages**
   ```bash
   git commit -m "Add amazing feature"
   ```
6. **Push to your fork**
   ```bash
   git push origin feature/amazing-feature
   ```
7. **Create Pull Request**

### Pull Request Checklist

- [ ] Code follows project style guidelines
- [ ] All tests pass
- [ ] New features include tests
- [ ] Documentation updated
- [ ] No linter warnings
- [ ] Tested on multiple platforms

## Resources

### Official Documentation
- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [Material Design](https://material.io/design)

### Packages Used
- [flutter_tts](https://pub.dev/packages/flutter_tts)
- [shared_preferences](https://pub.dev/packages/shared_preferences)

### Learning Resources
- [Flutter Cookbook](https://flutter.dev/docs/cookbook)
- [Flutter Examples](https://github.com/flutter/flutter/tree/master/examples)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)

## Version History

### v1.0.0 (Current)
- Initial release
- 5 pre-loaded prayers
- Call-and-response functionality
- TTS with adjustable settings
- Multi-platform support (Android, iOS, Web, Windows)

---

**Happy Coding! May your contributions be blessed!**
