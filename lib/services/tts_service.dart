import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/prayer.dart';

class TtsService {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isInitialized = false;
  bool _isPaused = false;
  bool _isStopped = false;

  // Keys for SharedPreferences
  static const String _keyVoiceName = 'tts_voice_name';
  static const String _keyVoiceLocale = 'tts_voice_locale';
  static const String _keySpeechRate = 'tts_speech_rate';
  static const String _keyVolume = 'tts_volume';

  Future<void> initialize() async {
    if (_isInitialized) return;

    // Load saved settings
    final prefs = await SharedPreferences.getInstance();
    final speechRate = prefs.getDouble(_keySpeechRate) ?? 0.35;
    final volume = prefs.getDouble(_keyVolume) ?? 1.0;

    await _flutterTts.setLanguage('en-US');
    await _flutterTts.setSpeechRate(speechRate);
    await _flutterTts.setVolume(volume);
    await _flutterTts.setPitch(1.0);
    await _flutterTts.awaitSpeakCompletion(true);

    // Load saved voice if available
    final voiceName = prefs.getString(_keyVoiceName);
    final voiceLocale = prefs.getString(_keyVoiceLocale);
    if (voiceName != null && voiceLocale != null) {
      try {
        await _flutterTts.setVoice({'name': voiceName, 'locale': voiceLocale});
      } catch (e) {
        // Voice not available, use default
      }
    }

    _flutterTts.setStartHandler(() {});

    _flutterTts.setCompletionHandler(() {});

    _flutterTts.setErrorHandler((msg) {});

    _isInitialized = true;
  }

  Future<void> speak(String text) async {
    if (!_isInitialized) await initialize();
    await _flutterTts.speak(text);
  }

  Future<void> stop() async {
    _isStopped = true;
    await _flutterTts.stop();
  }

  Future<void> pause() async {
    _isPaused = true;
    await _flutterTts.pause();
  }

  Future<void> resume() async {
    _isPaused = false;
  }

  Future<void> setSpeechRate(double rate) async {
    await _flutterTts.setSpeechRate(rate);
    // Save to preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_keySpeechRate, rate);
  }

  Future<void> setVolume(double volume) async {
    await _flutterTts.setVolume(volume);
    // Save to preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_keyVolume, volume);
  }

  Future<void> setPitch(double pitch) async {
    await _flutterTts.setPitch(pitch);
  }

  Future<List<dynamic>> getVoices() async {
    return await _flutterTts.getVoices;
  }

  Future<void> setVoice(Map<String, String> voice) async {
    await _flutterTts.setVoice(voice);
    // Save to preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyVoiceName, voice['name'] ?? '');
    await prefs.setString(_keyVoiceLocale, voice['locale'] ?? '');
  }

  Future<Map<String, String>?> getSavedVoice() async {
    final prefs = await SharedPreferences.getInstance();
    final voiceName = prefs.getString(_keyVoiceName);
    final voiceLocale = prefs.getString(_keyVoiceLocale);
    
    if (voiceName != null && voiceLocale != null) {
      return {'name': voiceName, 'locale': voiceLocale};
    }
    return null;
  }

  Future<double> getSavedSpeechRate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_keySpeechRate) ?? 0.35;
  }

  Future<double> getSavedVolume() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_keyVolume) ?? 1.0;
  }

  Future<void> playPrayerWithCallAndResponse({
    required Prayer prayer,
    required Function(int lineIndex, PrayerLine line) onLineStart,
    required Function() onComplete,
    required Function() shouldContinue,
  }) async {
    if (!_isInitialized) await initialize();
    
    _isStopped = false;
    _isPaused = false;

    for (int i = 0; i < prayer.lines.length; i++) {
      if (_isStopped || !shouldContinue()) {
        break;
      }

      while (_isPaused && !_isStopped) {
        await Future.delayed(const Duration(milliseconds: 100));
        if (!shouldContinue()) {
          _isStopped = true;
          break;
        }
      }

      if (_isStopped) break;

      final line = prayer.lines[i];
      onLineStart(i, line);

      await _flutterTts.speak(line.text);

      int pauseSeconds = line.pauseDurationSeconds;
      for (int j = 0; j < pauseSeconds; j++) {
        if (_isStopped || !shouldContinue()) {
          break;
        }
        while (_isPaused && !_isStopped) {
          await Future.delayed(const Duration(milliseconds: 100));
          if (!shouldContinue()) {
            _isStopped = true;
            break;
          }
        }
        await Future.delayed(const Duration(seconds: 1));
      }
    }

    if (!_isStopped && shouldContinue()) {
      onComplete();
    }
  }

  void dispose() {
    _flutterTts.stop();
  }
}
