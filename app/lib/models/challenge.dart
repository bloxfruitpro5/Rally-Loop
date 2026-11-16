class Challenge {
  const Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.progress,
    required this.goal,
    required this.unit,
  });

  final String id;
  final String title;
  final String description;
  final int progress;
  final int goal;
  final String unit;

  double get fraction => goal == 0 ? 0 : progress / goal;
}

class LeaderboardEntry {
  const LeaderboardEntry({
    required this.name,
    required this.points,
    required this.isYou,
  });

  final String name;
  final int points;
  final bool isYou;
}

class MilestoneBadge {
  const MilestoneBadge({required this.title, required this.unlocked});

  final String title;
  final bool unlocked;
}
