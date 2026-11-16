import 'package:material_ui/material_ui.dart';
import 'package:rallyloop/theme/app_colors.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.value,
    this.label,
    this.trailing,
    this.color,
    this.height = 8,
  });

  /// 0–1 fill amount.
  final double value;
  final String? label;
  final String? trailing;
  final Color? color;
  final double height;

  @override
  Widget build(BuildContext context) {
    final fill = (color ?? AppColors.accent);
    final fraction = value.clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null || trailing != null) ...[
          Row(
            children: [
              if (label != null)
                Expanded(
                  child: Text(label!, style: const TextStyle(fontWeight: FontWeight.w700)),
                ),
              if (trailing != null)
                Text(trailing!, style: const TextStyle(color: AppColors.textMuted, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 8),
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: SizedBox(
            height: height,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                const ColoredBox(color: AppColors.border),
                FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: fraction,
                  child: ColoredBox(color: fill),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
