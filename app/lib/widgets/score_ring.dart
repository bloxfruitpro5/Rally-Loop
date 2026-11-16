import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
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
    final ring = CircularPercentIndicator(
      radius: radius,
      lineWidth: lineWidth,
      percent: percent.clamp(0, 1).toDouble(),
      animation: false,
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: AppColors.border,
      progressColor: fill,
      center: Text(
        label,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: radius * 0.42,
          fontWeight: FontWeight.w800,
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
