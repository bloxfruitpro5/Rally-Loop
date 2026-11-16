import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';
import 'package:rallyloop/theme/app_colors.dart';

class ScoreRing extends StatelessWidget {
  const ScoreRing({
    super.key,
    required this.percent,
    required this.label,
    this.radius = 42,
    this.lineWidth = 8,
    this.color,
    this.caption,
  });

  /// 0–1 fill amount.
  final double percent;
  final String label;
  final double radius;
  final double lineWidth;
  final Color? color;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    final fill = color ?? AppColors.accent;
    final size = radius * 2;
    final ring = SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _ScoreRingPainter(
          percent: percent.clamp(0, 1).toDouble(),
          color: fill,
          backgroundColor: AppColors.border,
          strokeWidth: lineWidth,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: radius * 0.42,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
    if (caption == null) return ring;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ring,
        const SizedBox(height: 6),
        Text(
          caption!,
          style: const TextStyle(color: AppColors.textMuted, fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _ScoreRingPainter extends CustomPainter {
  _ScoreRingPainter({
    required this.percent,
    required this.color,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  final double percent;
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (math.min(size.width, size.height) - strokeWidth) / 2;
    final track = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    final progress = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, track);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * percent,
      false,
      progress,
    );
  }

  @override
  bool shouldRepaint(covariant _ScoreRingPainter oldDelegate) {
    return oldDelegate.percent != percent ||
        oldDelegate.color != color ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
