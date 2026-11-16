import 'package:material_ui/material_ui.dart';
import 'package:rallyloop/theme/app_colors.dart';

enum PillTone { accent, danger, warning, neutral }

class PillBadge extends StatelessWidget {
  const PillBadge({
    super.key,
    required this.label,
    this.tone = PillTone.neutral,
  });

  final String label;
  final PillTone tone;

  @override
  Widget build(BuildContext context) {
    final color = switch (tone) {
      PillTone.accent => AppColors.accent,
      PillTone.danger => AppColors.danger,
      PillTone.warning => AppColors.warning,
      PillTone.neutral => AppColors.textMuted,
    };
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.7)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            height: 1.1,
          ),
        ),
      ),
    );
  }
}

PillTone toneForScore(int score) {
  if (score >= 80) return PillTone.accent;
  if (score >= 70) return PillTone.neutral;
  return PillTone.warning;
}
