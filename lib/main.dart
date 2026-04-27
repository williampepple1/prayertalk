import 'package:flutter/material.dart';
import 'screens/prayer_list_screen.dart';
import 'services/prayer_playback_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrayerPlaybackService().initialize();
  runApp(const PrayerTalkApp());
}

class PrayerTalkApp extends StatelessWidget {
  const PrayerTalkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prayer Talk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      ),
      home: const PrayerListScreen(),
    );
  }
}
