class SessionRecap {
  const SessionRecap({
    required this.swingCount,
    required this.avgMatch,
    required this.bestMatch,
    required this.durationLabel,
    required this.priorityFix,
    required this.priorityDetail,
    required this.drill,
    required this.improvementLabel,
    required this.matchScores,
  });

  final int swingCount;
  final int avgMatch;
  final int bestMatch;

  /// e.g. "34 MIN"
  final String durationLabel;
  final String priorityFix;
  final String priorityDetail;
  final String drill;

  /// Chart callout, e.g. "+15% BY SWING 24"
  final String improvementLabel;

  /// Per-swing match scores for the recap chart, oldest first.
  final List<int> matchScores;
}
