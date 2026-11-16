class JointMetric {
  const JointMetric({required this.joint, required this.deltaDegrees});

  final String joint;

  /// Signed degrees versus the reference swing. Positive is late or open.
  final int deltaDegrees;
}

class Swing {
  const Swing({
    required this.id,
    required this.strokeId,
    required this.matchPercent,
    required this.recordedAt,
    required this.largestDeviation,
    required this.largestDeviationDetail,
    required this.metrics,
  });

  final String id;
  final String strokeId;
  final int matchPercent;
  final DateTime recordedAt;
  final String largestDeviation;
  final String largestDeviationDetail;
  final List<JointMetric> metrics;
}
