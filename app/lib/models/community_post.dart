class CommunityPost {
  const CommunityPost({
    required this.id,
    required this.author,
    required this.gradeLabel,
    required this.strokeId,
    required this.caption,
    required this.aiSummary,
    required this.feedbackCount,
    required this.filterTag,
  });

  final String id;
  final String author;

  /// Rank / score chip next to the author, e.g. "G2 - 71".
  final String gradeLabel;
  final String strokeId;
  final String caption;
  final String aiSummary;
  final int feedbackCount;
  final String filterTag;
}
