class Scorer {
  static Map<int, String> levels = {
    0: 'Level 0 | Newbie',
    10: 'Level 1 | Snowballer',
    20: 'Level 2 | Ice Champ'
  };

  static String getLevel(int score) {
    score = score + (100 - score % 100);
    return levels[score] ?? 'error';
  }
}
