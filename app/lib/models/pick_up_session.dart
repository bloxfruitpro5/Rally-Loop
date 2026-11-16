/// Home "Pick up where you left off" card seed.
class PickUpSession {
  const PickUpSession({
    required this.strokeId,
    required this.title,
    required this.lastFix,
  });

  final String strokeId;
  final String title;
  final String lastFix;
}
