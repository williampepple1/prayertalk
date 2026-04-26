class Prayer {
  final String id;
  final String title;
  final String category;
  final List<PrayerLine> lines;

  Prayer({
    required this.id,
    required this.title,
    required this.category,
    required this.lines,
  });
}

class PrayerLine {
  final String text;
  final PrayerLineType type;
  final int pauseDurationSeconds;

  PrayerLine({
    required this.text,
    required this.type,
    this.pauseDurationSeconds = 3,
  });
}

enum PrayerLineType {
  leader,
  response,
  both,
}
