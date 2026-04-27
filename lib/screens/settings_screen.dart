import 'package:flutter/material.dart';
import '../services/prayer_playback_service.dart';
import '../utils/voice_formatter.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _service = PrayerPlaybackService();
  double _speechRate = 0.35;
  double _volume = 1.0;
  List<dynamic> _voices = [];
  Map<String, String>? _selectedVoice;
  bool _isLoadingVoices = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _loadVoices();
  }

  Future<void> _loadSettings() async {
    final savedRate = await _service.ttsService.getSavedSpeechRate();
    final savedVolume = await _service.ttsService.getSavedVolume();
    final savedVoice = await _service.ttsService.getSavedVoice();

    setState(() {
      _speechRate = savedRate;
      _volume = savedVolume;
      _selectedVoice = savedVoice;
    });
  }

  Future<void> _loadVoices() async {
    setState(() {
      _isLoadingVoices = true;
    });

    try {
      final voices = await _service.ttsService.getVoices();
      setState(() {
        _voices = voices;
        _isLoadingVoices = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingVoices = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Voice Settings',
                    style: TextStyle(
                      fontSize: 20,
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
                          onChanged: (value) async {
                            setState(() {
                              _speechRate = value;
                            });
                            await _service.ttsService.setSpeechRate(value);
                          },
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
                          onChanged: (value) async {
                            setState(() {
                              _volume = value;
                            });
                            await _service.ttsService.setVolume(value);
                          },
                        ),
                      ),
                      Text('${(_volume * 100).toInt()}%'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.record_voice_over, size: 20),
                      const SizedBox(width: 8),
                      const Text(
                        'Voice Selection',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (_isLoadingVoices)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else if (_voices.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('No voices available'),
                    )
                  else
                    Container(
                      constraints: const BoxConstraints(maxHeight: 400),
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
                            onTap: () async {
                              setState(() {
                                _selectedVoice = voiceMap;
                              });
                              await _service.ttsService.setVoice(voiceMap);
                            },
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Prayer Talk v1.0.0'),
                  const SizedBox(height: 4),
                  const Text(
                    'A Bible Prayer app with call-and-response text-to-speech functionality.',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
