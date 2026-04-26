# Prayer Talk

A Bible Prayer app with call-and-response text-to-speech functionality. Pray while doing other things!

## Features

- **Call-and-Response Prayer Mode**: Automatically speaks prayers in a leader-response format
- **Text-to-Speech**: High-quality voice synthesis for hands-free prayer
- **Multiple Prayers**: Includes traditional prayers, Psalms, and daily prayers
- **Customizable Settings**: 
  - Adjustable speech rate (speed)
  - Volume control
  - Pause between responses
- **Beautiful UI**: Modern Material Design 3 interface
- **Category Filtering**: Browse prayers by category
- **Playback Controls**: Play, pause, stop, and restart prayers
- **Visual Progress**: See which line is currently being spoken

## Prayers Included

1. **The Lord's Prayer** (Traditional)
2. **Psalm 23** - The Lord is My Shepherd
3. **Morning Prayer** (Daily Prayers)
4. **The Serenity Prayer** (Traditional)
5. **Psalm 91** - Protection Prayer

## How It Works

1. **Browse Prayers**: View all available prayers on the main screen
2. **Filter by Category**: Use category chips to filter prayers by type
3. **Select a Prayer**: Tap on any prayer to open the player screen
4. **Adjust Settings**: Tap the settings icon to adjust speech rate and volume
5. **Start Prayer**: Press the play button to begin the call-and-response prayer
6. **Follow Along**: The app will speak each line with appropriate pauses for response
7. **Control Playback**: Pause, resume, or stop at any time

## Call-and-Response Format

The app uses three types of prayer lines:

- **Leader** (Blue): The leader's part - spoken first
- **Response** (Green): The congregation's response - with pause for you to speak
- **All** (Purple): Everyone speaks together

Each line is automatically spoken with appropriate pauses, allowing you to participate while doing other activities.

## Installation

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / Xcode (for mobile development)

### Setup

1. Clone this repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to launch the app

```bash
git clone <repository-url>
cd prayertalk
flutter pub get
flutter run
```

## Dependencies

- **flutter_tts**: ^4.2.5 - Text-to-speech functionality
- **shared_preferences**: ^2.5.5 - Local data persistence

## Supported Platforms

- ✅ Android
- ✅ iOS
- ✅ Web

## Usage Tips

1. **Multitasking**: Use this app while cooking, exercising, or doing chores
2. **Meditation**: Focus on the words while the app guides you through the prayer
3. **Learning**: Great for memorizing traditional prayers
4. **Accessibility**: Helpful for those with vision impairments or reading difficulties

## Future Enhancements

- Add more prayers and Bible passages
- Custom prayer creation
- Audio recording of user responses
- Multiple language support
- Offline mode with downloaded voices
- Prayer history and favorites
- Community-contributed prayers

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the MIT License.

## Credits

Built with Flutter and love for prayer and meditation.

---

**Note**: Text-to-speech quality depends on the voices installed on your device. For the best experience, ensure your device has high-quality TTS voices installed.
