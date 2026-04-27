import 'package:flutter/material.dart';
import '../models/prayer.dart';
import '../services/prayer_playback_service.dart';
import '../utils/voice_formatter.dart';

class PrayerPlayerScreen extends StatefulWidget {
  final Prayer prayer;

  const PrayerPlayerScreen({
    super.key,
    required this.prayer,
  });

  @override
  State<PrayerPlayerScreen> createState() => _PrayerPlayerScreenState();
}

class _PrayerPlayerScreenState extends State<PrayerPlayerScreen> {
  final _playbackService = PrayerPlaybackService();
  double _speechRate = 0.35;
  double _volume = 1.0;
  bool _showSettings = false;
  List<dynamic> _voices = [];
  Map<String, String>? _selectedVoice;
  bool _isLoadingVoices = false;

  @override
  void initState() {
    super.initState();
    _playbackService.initialize();
    _loadSavedSettings();
    _loadVoices();
    _playbackService.addListener(_onPlaybackChanged);
  }

  void _onPlaybackChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _loadSavedSettings() async {
    // Load saved settings
    final savedSpeechRate = await _playbackService.ttsService.getSavedSpeechRate();
    final savedVolume = await _playbackService.ttsService.getSavedVolume();
    final savedVoice = await _playbackService.ttsService.getSavedVoice();

    setState(() {
      _speechRate = savedSpeechRate;
      _volume = savedVolume;
      _selectedVoice = savedVoice;
    });
  }

  Future<void> _loadVoices() async {
    setState(() {
      _isLoadingVoices = true;
    });
    
    try {
      final voices = await _playbackService.ttsService.getVoices();
      final savedVoice = await _playbackService.ttsService.getSavedVoice();
      
      setState(() {
        _voices = voices;
        _selectedVoice = savedVoice;
        _isLoadingVoices = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingVoices = false;
      });
    }
  }

  Future<void> _changeVoice(Map<String, String> voice) async {
    setState(() {
      _selectedVoice = voice;
    });
    await _playbackService.ttsService.setVoice(voice);
  }

  @override
  void dispose() {
    _playbackService.removeListener(_onPlaybackChanged);
    super.dispose();
  }

  void _playPrayer() {
    _playbackService.playPrayer(widget.prayer);
  }

  void _pausePrayer() {
    _playbackService.pause();
  }

  void _resumePrayer() {
    _playbackService.resume();
  }

  void _stopPrayer() {
    _playbackService.stop();
  }

  void _updateSpeechRate(double rate) {
    setState(() {
      _speechRate = rate;
    });
    _playbackService.ttsService.setSpeechRate(rate);
  }

  void _updateVolume(double volume) {
    setState(() {
      _volume = volume;
    });
    _playbackService.ttsService.setVolume(volume);
  }

  Color _getLineColor(PrayerLineType type) {
    switch (type) {
      case PrayerLineType.leader:
        return Colors.blue[100]!;
      case PrayerLineType.response:
        return Colors.green[100]!;
      case PrayerLineType.both:
        return Colors.purple[100]!;
    }
  }

  IconData _getLineIcon(PrayerLineType type) {
    switch (type) {
      case PrayerLineType.leader:
        return Icons.mic;
      case PrayerLineType.response:
        return Icons.record_voice_over;
      case PrayerLineType.both:
        return Icons.groups;
    }
  }

  String _getLineTypeLabel(PrayerLineType type) {
    switch (type) {
      case PrayerLineType.leader:
        return 'Leader';
      case PrayerLineType.response:
        return 'Response';
      case PrayerLineType.both:
        return 'All';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.prayer.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: Icon(_showSettings ? Icons.settings : Icons.settings_outlined),
            onPressed: () {
              setState(() {
                _showSettings = !_showSettings;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (_showSettings)
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.speed, size: 20),
                      const SizedBox(width: 8),
                      const Text('Speed:'),
                      Expanded(
                        child: Slider(
                          value: _speechRate,
                          min: 0.1,
                          max: 1.0,
                          divisions: 18,
                          label: _speechRate.toStringAsFixed(2),
                          onChanged: _updateSpeechRate,
                        ),
                      ),
                      Text(_speechRate.toStringAsFixed(2)),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.volume_up, size: 20),
                      const SizedBox(width: 8),
                      const Text('Volume:'),
                      Expanded(
                        child: Slider(
                          value: _volume,
                          min: 0.0,
                          max: 1.0,
                          divisions: 10,
                          label: (_volume * 100).toInt().toString(),
                          onChanged: _updateVolume,
                        ),
                      ),
                      Text('${(_volume * 100).toInt()}%'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.record_voice_over, size: 20),
                      const SizedBox(width: 8),
                      const Text('Voice:'),
                      const SizedBox(width: 8),
                      if (_isLoadingVoices)
                        const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      else if (_voices.isEmpty)
                        const Text(
                          'No voices available',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                    ],
                  ),
                  if (_voices.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Container(
                      constraints: const BoxConstraints(maxHeight: 150),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _voices.length,
                        itemBuilder: (context, index) {
                          final voice = _voices[index] as Map<dynamic, dynamic>;
                          final voiceName = voice['name']?.toString() ?? 'Voice ${index + 1}';
                          final locale = voice['locale']?.toString() ?? '';
                          final voiceMap = {
                            'name': voiceName,
                            'locale': locale,
                          };
                          final isSelected = _selectedVoice != null &&
                              _selectedVoice!['name'] == voiceName;

                          // Format voice name and locale for display
                          final displayName = VoiceFormatter.formatVoiceName(voiceName);
                          final displayLocale = VoiceFormatter.formatLocale(locale);

                          return ListTile(
                            dense: true,
                            selected: isSelected,
                            selectedTileColor: Theme.of(context)
                                .colorScheme
                                .primaryContainer
                                .withValues(alpha: 0.3),
                            leading: Icon(
                              isSelected ? Icons.check_circle : Icons.mic,
                              size: 20,
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
                            ),
                            title: Text(
                              displayName,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            subtitle: displayLocale.isNotEmpty
                                ? Text(
                                    displayLocale,
                                    style: const TextStyle(fontSize: 11),
                                  )
                                : null,
                            onTap: () => _changeVoice(voiceMap),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildLegendItem(
                      'Leader',
                      Icons.mic,
                      Colors.blue[100]!,
                    ),
                    _buildLegendItem(
                      'Response',
                      Icons.record_voice_over,
                      Colors.green[100]!,
                    ),
                    _buildLegendItem(
                      'All',
                      Icons.groups,
                      Colors.purple[100]!,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.prayer.lines.length,
                    itemBuilder: (context, index) {
                      final line = widget.prayer.lines[index];
                      final isCurrentLine = _playbackService.currentPrayer?.id == widget.prayer.id &&
                          index == _playbackService.currentLineIndex;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Card(
                    elevation: isCurrentLine ? 8 : 2,
                    color: isCurrentLine
                        ? _getLineColor(line.type)
                        : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: _getLineColor(line.type),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              _getLineIcon(line.type),
                              size: 24,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _getLineTypeLabel(line.type),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  line.text,
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 1.5,
                                    fontWeight: isCurrentLine
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                                if (isCurrentLine)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.volume_up,
                                          size: 16,
                                          color: Colors.grey[600],
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Now playing...',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_playbackService.isPlaying && _playbackService.currentPrayer?.id == widget.prayer.id)
                      IconButton(
                        onPressed: _stopPrayer,
                        icon: const Icon(Icons.stop),
                        iconSize: 40,
                        tooltip: 'Stop',
                      ),
                    const SizedBox(width: 16),
                    FloatingActionButton.large(
                      onPressed: () {
                        final isSamePrayer = _playbackService.currentPrayer?.id == widget.prayer.id;
                        
                        if (!_playbackService.isPlaying || !isSamePrayer) {
                          _playPrayer();
                        } else if (_playbackService.isPaused) {
                          _resumePrayer();
                        } else {
                          _pausePrayer();
                        }
                      },
                      child: Icon(
                        !_playbackService.isPlaying || _playbackService.currentPrayer?.id != widget.prayer.id
                            ? Icons.play_arrow
                            : (_playbackService.isPaused ? Icons.play_arrow : Icons.pause),
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(icon, size: 16),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
