class CommunityPost {
  const CommunityPost({
    required this.id,
    required this.author,
    required this.strokeId,
    required this.caption,
    required this.aiSummary,
    required this.feedbackCount,
    required this.filterTag,
  });

  final String id;
  final String author;
  final String strokeId;
  final String caption;
  final String aiSummary;
  final int feedbackCount;
  final String filterTag;
}
