import 'package:flutter/foundation.dart';
import '../models/prayer.dart';
import 'tts_service.dart';

class PrayerPlaybackService extends ChangeNotifier {
  static final PrayerPlaybackService _instance = PrayerPlaybackService._internal();
  factory PrayerPlaybackService() => _instance;
  PrayerPlaybackService._internal();

  final TtsService _ttsService = TtsService();
  Prayer? _currentPrayer;
  bool _isPlaying = false;
  bool _isPaused = false;
  int _currentLineIndex = -1;

  Prayer? get currentPrayer => _currentPrayer;
  bool get isPlaying => _isPlaying;
  bool get isPaused => _isPaused;
  int get currentLineIndex => _currentLineIndex;
  bool get hasActivePrayer => _currentPrayer != null;

  Future<void> initialize() async {
    await _ttsService.initialize();
  }

  TtsService get ttsService => _ttsService;

  Future<void> playPrayer(Prayer prayer) async {
    if (_currentPrayer?.id == prayer.id && _isPlaying && !_isPaused) {
      return; // Already playing this prayer
    }

    // Stop current prayer if playing a different one
    if (_currentPrayer != null && _currentPrayer!.id != prayer.id) {
      await stop();
    }

    _currentPrayer = prayer;
    _isPlaying = true;
    _isPaused = false;
    _currentLineIndex = 0;
    notifyListeners();

    await _ttsService.playPrayerWithCallAndResponse(
      prayer: prayer,
      onLineStart: (index, line) {
        _currentLineIndex = index;
        notifyListeners();
      },
      onComplete: () {
        _isPlaying = false;
        _currentLineIndex = -1;
        notifyListeners();
      },
      shouldContinue: () => _isPlaying,
    );
  }

  Future<void> pause() async {
    if (!_isPlaying || _isPaused) return;
    _isPaused = true;
    await _ttsService.pause();
    notifyListeners();
  }

  Future<void> resume() async {
    if (!_isPlaying || !_isPaused) return;
    _isPaused = false;
    await _ttsService.resume();
    notifyListeners();
    
    // Continue from current position
    if (_currentPrayer != null) {
      await playPrayer(_currentPrayer!);
    }
  }

  Future<void> stop() async {
    if (!_isPlaying) return;
    _isPlaying = false;
    _isPaused = false;
    _currentLineIndex = -1;
    await _ttsService.stop();
    notifyListeners();
  }

  void clearCurrentPrayer() {
    _currentPrayer = null;
    _isPlaying = false;
    _isPaused = false;
    _currentLineIndex = -1;
    notifyListeners();
  }
}
