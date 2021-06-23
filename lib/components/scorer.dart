// TODO: define the levels further

class Scorer {
  static Map<int, String> levels = {
    0: 'Newbie',
    100: 'Snowballer',
    200: 'Ice Champ'
  };

  static String getLevel(int score) {
    score = score + (100 - score % 100);
    return levels[score] ?? 'error';
  }
}
