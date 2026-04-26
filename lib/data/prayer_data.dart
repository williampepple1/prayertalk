import '../models/prayer.dart';

class PrayerData {
  static List<Prayer> getPrayers() {
    return [
      Prayer(
        id: 'lords_prayer',
        title: 'The Lord\'s Prayer',
        category: 'Traditional',
        lines: [
          PrayerLine(
            text: 'Our Father, who art in heaven,',
            type: PrayerLineType.leader,
            pauseDurationSeconds: 2,
          ),
          PrayerLine(
            text: 'Hallowed be thy name.',
            type: PrayerLineType.response,
            pauseDurationSeconds: 3,
          ),
          PrayerLine(
            text: 'Thy kingdom come,',
            type: PrayerLineType.leader,
            pauseDurationSeconds: 2,
          ),
          PrayerLine(
            text: 'Thy will be done on earth as it is in heaven.',
            type: PrayerLineType.response,
            pauseDurationSeconds: 3,
          ),
          PrayerLine(
            text: 'Give us this day our daily bread,',
            type: PrayerLineType.leader,
            pauseDurationSeconds: 2,
          ),
          PrayerLine(
            text: 'And forgive us our trespasses,',
            type: PrayerLineType.response,
            pauseDurationSeconds: 3,
          ),
          PrayerLine(
            text: 'As we forgive those who trespass against us.',
            type: PrayerLineType.leader,
            pauseDurationSeconds: 2,
          ),
          PrayerLine(
            text: 'And lead us not into temptation,',
            type: PrayerLineType.response,
            pauseDurationSeconds: 3,
          ),
          PrayerLine(
            text: 'But deliver us from evil.',
            type: PrayerLineType.leader,
            pauseDurationSeconds: 2,
          ),
          PrayerLine(
            text: 'For thine is the kingdom, and the power, and the glory, forever and ever. Amen.',
            type: PrayerLineType.both,
            pauseDurationSeconds: 4,
          ),
        ],
      ),
      Prayer(
        id: 'psalm_23',
        title: 'Psalm 23 - The Lord is My Shepherd',
        category: 'Psalms',
        lines: [
          PrayerLine(
            text: 'The Lord is my shepherd;',
            type: PrayerLineType.leader,
            pauseDurationSeconds: 2,
          ),
          PrayerLine(
            text: 'I shall not want.',
            type: PrayerLineType.response,
            pauseDurationSeconds: 3,
          ),
          PrayerLine(
            text: 'He makes me lie down in green pastures.',
            type: PrayerLineType.leader,
            pauseDurationSeconds: 2,
          ),
          PrayerLine(
            text: 'He leads me beside still waters.',
            type: PrayerLineType.response,
            pauseDurationSeconds: 3,
          ),
          PrayerLine(
            text: 'He restores my soul.',
            type: PrayerLineType.leader,
            pauseDurationSeconds: 2,
          ),
          PrayerLine(
            text: 'He leads me in paths of righteousness for his name\'s sake.',
            type: PrayerLineType.response,
            pauseDurationSeconds: 3,
          ),
          PrayerLine(
            text: 'Even though I walk through the valley of the shadow of death,',
            type: PrayerLineType.leader,
            pauseDurationSeconds: 2,
          ),
          PrayerLine(
            text: 'I will fear no evil, for you are with me.',
            type: PrayerLineType.response,
            pauseDurationSeconds: 3,
          ),
          PrayerLine(
            text: 'Your rod and your staff, they comfort me.',
            type: PrayerLineType.leader,
            pauseDurationSeconds: 2,
          ),
          PrayerLine(
            text: 'You prepare a table before me in the presence of my enemies.',
            type: PrayerLineType.response,
            pauseDurationSeconds: 3,
          ),
          PrayerLine(
            text: 'You anoint my head with oil;',
            type: PrayerLineType.leader,
            pauseDurationSeconds: 2,
          ),
          PrayerLine(
            text: 'My cup overflows.',
            type: PrayerLineType.response,
            pauseDurationSeconds: 3,
          ),
          PrayerLine(
            text: 'Surely goodness and mercy shall follow me all the days of my life,',
            type: PrayerLineType.leader,
            pauseDurationSeconds: 2,
          ),
          PrayerLine(
            text: 'And I shall dwell in the house of the Lord forever.',
            type: PrayerLineType.both,
            pauseDurationSeconds: 4,
          ),
        ],
      ),
      Prayer(
        id: 'morning_prayer',
        title: 'Morning Prayer',
        category: 'Daily Prayers',
        lines: [
          PrayerLine(
            text: 'Lord, I thank You for this new day.',
            type: PrayerLineType.leader,
            pauseDurationSeconds: 3,
          ),
          PrayerLine(
            text: 'I thank You for Your mercy and grace.',
            type: PrayerLineType.response,
            pauseDurationSeconds: 3,
          ),
          PrayerLine(
            text: 'Guide my steps today.',
            type: PrayerLineType.leader,
            pauseDurationSeconds: 3,
          ),
          PrayerLine(
            text: 'Let Your will be done in my life.',
            type: PrayerLineType.response,
            pauseDurationSeconds: 3,
          ),
          PrayerLine(
            text: 'Give me strength to face every challenge.',
            type: PrayerLineType.leader,
            pauseDurationSeconds: 3,
          ),
          PrayerLine(
            text: 'And wisdom to make right decisions.',
            type: PrayerLineType.response,
            pauseDurationSeconds: 3,
          ),
          PrayerLine(
            text: 'In Jesus\' name I pray.',
            type: PrayerLineType.both,
            pauseDurationSeconds: 2,
          ),
          PrayerLine(
            text: 'Amen.',
            type: PrayerLineType.both,
            pauseDurationSeconds: 3,
          ),
        ],
      ),
      Prayer(
        id: 'serenity_prayer',
        title: 'The Serenity Prayer',
        category: 'Traditional',
        lines: [
          PrayerLine(
            text: 'God, grant me the serenity',
            type: PrayerLineType.leader,
            pauseDurationSeconds: 2,
          ),
          PrayerLine(
            text: 'To accept the things I cannot change,',
            type: PrayerLineType.response,
            pauseDurationSeconds: 3,
          ),
          PrayerLine(
            text: 'The courage to change the things I can,',
            type: PrayerLineType.leader,
            pauseDurationSeconds: 2,
          ),
          PrayerLine(
            text: 'And the wisdom to know the difference.',
            type: PrayerLineType.response,
            pauseDurationSeconds: 4,
          ),
        ],
      ),
      Prayer(
        id: 'psalm_91',
        title: 'Psalm 91 - Protection Prayer',
        category: 'Psalms',
        lines: [
          PrayerLine(
            text: 'He who dwells in the shelter of the Most High',
            type: PrayerLineType.leader,
            pauseDurationSeconds: 2,
          ),
          PrayerLine(
            text: 'Will rest in the shadow of the Almighty.',
            type: PrayerLineType.response,
            pauseDurationSeconds: 3,
          ),
          PrayerLine(
            text: 'I will say of the Lord,',
            type: PrayerLineType.leader,
            pauseDurationSeconds: 2,
          ),
          PrayerLine(
            text: 'He is my refuge and my fortress, my God, in whom I trust.',
            type: PrayerLineType.response,
            pauseDurationSeconds: 3,
          ),
          PrayerLine(
            text: 'Surely he will save you from the fowler\'s snare',
            type: PrayerLineType.leader,
            pauseDurationSeconds: 2,
          ),
          PrayerLine(
            text: 'And from the deadly pestilence.',
            type: PrayerLineType.response,
            pauseDurationSeconds: 3,
          ),
          PrayerLine(
            text: 'He will cover you with his feathers,',
            type: PrayerLineType.leader,
            pauseDurationSeconds: 2,
          ),
          PrayerLine(
            text: 'And under his wings you will find refuge.',
            type: PrayerLineType.response,
            pauseDurationSeconds: 3,
          ),
          PrayerLine(
            text: 'His faithfulness will be your shield and rampart.',
            type: PrayerLineType.both,
            pauseDurationSeconds: 4,
          ),
        ],
      ),
    ];
  }
}
