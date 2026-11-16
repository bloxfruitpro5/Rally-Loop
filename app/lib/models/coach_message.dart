class CoachMessage {
  const CoachMessage({
    required this.id,
    required this.fromCoach,
    required this.text,
    this.strokeId,
  });

  final String id;
  final bool fromCoach;
  final String text;
  final String? strokeId;
}
