import 'package:flutter_tts/flutter_tts.dart';
import '../models/prayer.dart';

class TtsService {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isInitialized = false;
  bool _isPaused = false;
  bool _isStopped = false;

  Future<void> initialize() async {
    if (_isInitialized) return;

    await _flutterTts.setLanguage('en-US');
    await _flutterTts.setSpeechRate(0.35);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);

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
  }

  Future<void> setVolume(double volume) async {
    await _flutterTts.setVolume(volume);
  }

  Future<void> setPitch(double pitch) async {
    await _flutterTts.setPitch(pitch);
  }

  Future<List<dynamic>> getVoices() async {
    return await _flutterTts.getVoices;
  }

  Future<void> setVoice(Map<String, String> voice) async {
    await _flutterTts.setVoice(voice);
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

      await Future.delayed(Duration(seconds: 1));

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
