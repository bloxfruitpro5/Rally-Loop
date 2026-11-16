class SessionRecap {
  const SessionRecap({
    required this.swingCount,
    required this.avgMatch,
    required this.bestMatch,
    required this.priorityFix,
    required this.drill,
    required this.matchScores,
  });

  final int swingCount;
  final int avgMatch;
  final int bestMatch;
  final String priorityFix;
  final String drill;

  /// Per-swing match scores for the recap chart, oldest first.
  final List<int> matchScores;
}
