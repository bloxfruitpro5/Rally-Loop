class StrokePhase {
  const StrokePhase({required this.id, required this.label});

  final String id;
  final String label;
}

class Stroke {
  const Stroke({
    required this.id,
    required this.name,
    required this.shortLabel,
    required this.phases,
  });

  final String id;
  final String name;
  final String shortLabel;
  final List<StrokePhase> phases;
}

class StrokeScore {
  const StrokeScore({
    required this.strokeId,
    required this.shortLabel,
    required this.score,
  });

  final String strokeId;
  final String shortLabel;

  /// Match score for this stroke, 0–100.
  final int score;
}
