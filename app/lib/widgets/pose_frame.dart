import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';
import 'package:rallyloop/theme/app_colors.dart';

/// Camera-frame placeholder with a mock pose skeleton.
class PoseFrame extends StatelessWidget {
  const PoseFrame({
    super.key,
    required this.color,
    required this.phase,
    this.flipped = false,
    this.timer,
    this.banner,
  });

  final Color color;
  final int phase;
  final bool flipped;
  final String? timer;
  final String? banner;

  @override
  Widget build(BuildContext context) {
    Widget figure = CustomPaint(
      painter: _SkeletonPainter(color: color, phase: phase),
      child: const SizedBox.expand(),
    );
    if (flipped) figure = Transform.flip(flipX: true, child: figure);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.bg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            figure,
            if (timer != null)
              Positioned(
                top: 12,
                left: 12,
                child: PillTimer(label: timer!),
              ),
            if (banner != null)
              Positioned(
                left: 12,
                right: 12,
                bottom: 12,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.card.withValues(alpha: 0.94),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(banner!, style: const TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class PillTimer extends StatelessWidget {
  const PillTimer({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.danger.withValues(alpha: 0.8)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Text(
          label,
          style: const TextStyle(color: AppColors.danger, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}

class _SkeletonPainter extends CustomPainter {
  _SkeletonPainter({required this.color, required this.phase});

  final Color color;
  final int phase;

  @override
  void paint(Canvas canvas, Size size) {
    final line = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final joint = Paint()..color = color;

    Offset p(double x, double y) => Offset(x * size.width, y * size.height);

    final head = p(0.50, 0.16);
    final neck = p(0.50, 0.24);
    final shoulderL = p(0.38, 0.28);
    final shoulderR = p(0.62, 0.28);
    final hipL = p(0.43, 0.52);
    final hipR = p(0.57, 0.52);
    final pelvis = p(0.50, 0.52);
    final kneeL = p(0.40, 0.70);
    final kneeR = p(0.60, 0.70);
    final footL = p(0.36, 0.88);
    final footR = p(0.66, 0.88);
    final handL = p(0.30, 0.40);

    final (elbowR, handR) = switch (phase) {
      1 => (p(0.74, 0.34), p(0.82, 0.46)),
      2 => (p(0.40, 0.32), p(0.24, 0.36)),
      3 => (p(0.46, 0.20), p(0.34, 0.12)),
      _ => (p(0.70, 0.36), p(0.74, 0.48)),
    };

    final court = Paint()
      ..color = AppColors.border
      ..strokeWidth = 1.5;
    canvas.drawLine(p(0.08, 0.90), p(0.92, 0.90), court);

    final bones = <(Offset, Offset)>[
      (neck, pelvis),
      (shoulderL, shoulderR),
      (shoulderL, handL),
      (shoulderR, elbowR),
      (elbowR, handR),
      (hipL, hipR),
      (hipL, kneeL),
      (hipR, kneeR),
      (kneeL, footL),
      (kneeR, footR),
    ];
    for (final bone in bones) {
      canvas.drawLine(bone.$1, bone.$2, line);
    }

    canvas.drawCircle(head, math.min(size.width, size.height) * 0.055, joint);
    for (final point in [shoulderL, shoulderR, elbowR, handR, hipL, hipR, kneeL, kneeR]) {
      canvas.drawCircle(point, 4, joint);
    }
  }

  @override
  bool shouldRepaint(covariant _SkeletonPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.phase != phase;
  }
}
