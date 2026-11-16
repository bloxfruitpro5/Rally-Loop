class UserProfile {
  const UserProfile({
    required this.name,
    required this.grade,
    required this.streakDays,
    required this.questionPoints,
    required this.techniqueScore,
  });

  final String name;
  final String grade;
  final int streakDays;
  final int questionPoints;

  /// Overall technique score, 0–100.
  final int techniqueScore;
}
