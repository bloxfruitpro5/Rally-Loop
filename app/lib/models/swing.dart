class JointMetric {
  const JointMetric({
    required this.joint,
    required this.deltaDegrees,
    this.unit = '°',
  });

  final String joint;

  /// Signed delta versus the reference swing. Positive is late/open/high.
  final int deltaDegrees;

  /// Display unit, usually degrees or inches.
  final String unit;

  String get displayValue {
    final sign = deltaDegrees > 0 ? '+' : '';
    return '$sign$deltaDegrees$unit';
  }

  bool get isPositive => deltaDegrees >= 0;
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
