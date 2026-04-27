class VoiceFormatter {
  static String formatVoiceName(String rawName) {
    if (rawName.isEmpty) return 'Default Voice';

    // Remove common technical prefixes/suffixes
    String name = rawName
        .replaceAll(RegExp(r'-x-[a-z]+-'), ' ')
        .replaceAll(RegExp(r'-local$'), '')
        .replaceAll(RegExp(r'-network$'), '')
        .replaceAll(RegExp(r'^en-'), '')
        .replaceAll(RegExp(r'^es-'), '')
        .replaceAll(RegExp(r'^fr-'), '')
        .replaceAll(RegExp(r'^de-'), '');

    // Convert dash-separated to title case
    List<String> parts = name.split('-');
    List<String> formatted = [];

    for (String part in parts) {
      if (part.length <= 3 && part.toUpperCase() == part) {
        // Keep country codes as uppercase
        formatted.add(part.toUpperCase());
      } else if (part == 'us' || part == 'gb' || part == 'au' || part == 'ca') {
        formatted.add(part.toUpperCase());
      } else {
        // Capitalize first letter
        formatted.add(part[0].toUpperCase() + part.substring(1));
      }
    }

    String result = formatted.join(' ');

    // Handle special patterns
    if (result.contains('tpf')) {
      result = result.replaceAll('tpf', 'Female');
    }
    if (result.contains('tpm')) {
      result = result.replaceAll('tpm', 'Male');
    }

    // Clean up extra spaces
    result = result.replaceAll(RegExp(r'\s+'), ' ').trim();

    return result.isEmpty ? rawName : result;
  }

  static String formatLocale(String locale) {
    if (locale.isEmpty) return '';

    // Common locale mappings
    final localeMap = {
      'en-US': 'English (United States)',
      'en-GB': 'English (United Kingdom)',
      'en-AU': 'English (Australia)',
      'en-CA': 'English (Canada)',
      'en-IN': 'English (India)',
      'en-ZA': 'English (South Africa)',
      'en-NZ': 'English (New Zealand)',
      'es-ES': 'Spanish (Spain)',
      'es-MX': 'Spanish (Mexico)',
      'es-US': 'Spanish (United States)',
      'fr-FR': 'French (France)',
      'fr-CA': 'French (Canada)',
      'de-DE': 'German (Germany)',
      'it-IT': 'Italian (Italy)',
      'pt-BR': 'Portuguese (Brazil)',
      'pt-PT': 'Portuguese (Portugal)',
      'zh-CN': 'Chinese (Simplified)',
      'zh-TW': 'Chinese (Traditional)',
      'ja-JP': 'Japanese (Japan)',
      'ko-KR': 'Korean (Korea)',
      'ar-SA': 'Arabic (Saudi Arabia)',
      'hi-IN': 'Hindi (India)',
      'ru-RU': 'Russian (Russia)',
      'pl-PL': 'Polish (Poland)',
      'nl-NL': 'Dutch (Netherlands)',
      'tr-TR': 'Turkish (Turkey)',
      'sv-SE': 'Swedish (Sweden)',
      'da-DK': 'Danish (Denmark)',
      'fi-FI': 'Finnish (Finland)',
      'no-NO': 'Norwegian (Norway)',
    };

    // Try direct mapping first
    if (localeMap.containsKey(locale)) {
      return localeMap[locale]!;
    }

    // Try case-insensitive match
    final upperLocale = locale.toUpperCase();
    for (var entry in localeMap.entries) {
      if (entry.key.toUpperCase() == upperLocale) {
        return entry.value;
      }
    }

    // Parse and format if not in map
    List<String> parts = locale.split('-');
    if (parts.length >= 2) {
      String language = _capitalizeFirst(parts[0]);
      String country = parts[1].toUpperCase();
      return '$language ($country)';
    } else if (parts.length == 1) {
      return _capitalizeFirst(parts[0]);
    }

    return locale;
  }

  static String _capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  static String getVoiceDisplayName(String name, String locale) {
    String formattedName = formatVoiceName(name);
    String formattedLocale = formatLocale(locale);

    // If name already contains locale info, don't duplicate
    if (formattedName.toLowerCase().contains('english') ||
        formattedName.toLowerCase().contains('spanish') ||
        formattedName.toLowerCase().contains('french')) {
      return formattedName;
    }

    // Combine name and locale
    if (formattedLocale.isNotEmpty) {
      return '$formattedName • $formattedLocale';
    }

    return formattedName;
  }
}
