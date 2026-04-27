import 'package:flutter/material.dart';
import '../services/prayer_playback_service.dart';

class MiniPlayer extends StatelessWidget {
  final VoidCallback onTap;

  const MiniPlayer({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: PrayerPlaybackService(),
      builder: (context, child) {
        final service = PrayerPlaybackService();
        
        if (!service.hasActivePrayer) {
          return const SizedBox.shrink();
        }

        final prayer = service.currentPrayer!;
        
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.auto_stories,
                        color: Theme.of(context).colorScheme.primary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            prayer.title,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Icon(
                                service.isPlaying && !service.isPaused
                                    ? Icons.volume_up
                                    : Icons.pause,
                                size: 12,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                service.isPlaying && !service.isPaused
                                    ? 'Playing...'
                                    : 'Paused',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        service.isPlaying && !service.isPaused
                            ? Icons.pause_circle
                            : Icons.play_circle,
                        size: 32,
                      ),
                      onPressed: () {
                        if (service.isPlaying && !service.isPaused) {
                          service.pause();
                        } else if (service.isPaused) {
                          service.resume();
                        } else {
                          service.playPrayer(prayer);
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.stop_circle,
                        size: 32,
                      ),
                      onPressed: () {
                        service.stop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
