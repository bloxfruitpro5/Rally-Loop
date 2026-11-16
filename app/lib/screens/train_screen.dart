import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:rallyloop/data/mock_data.dart';
import 'package:rallyloop/theme/app_colors.dart';
import 'package:rallyloop/widgets/app_card.dart';
import 'package:rallyloop/widgets/neon_button.dart';
import 'package:rallyloop/widgets/pill_badge.dart';

/// Foundation stub for Train. Full 3-step wizard lands in Alpha 1.2.
class TrainScreen extends StatelessWidget {
  const TrainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.watch<MockData>();
    final selected = data.selectedStroke;
    return Scaffold(
      appBar: AppBar(title: const Text('Choose a stroke')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          const Text(
            'Step 1 of 3 · Each stroke loads a reference clip.',
            style: TextStyle(color: AppColors.textMuted),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.35,
            children: [
              for (final stroke in data.strokes)
                _StrokeTile(
                  name: stroke.name,
                  subtype: stroke.subtype,
                  selected: stroke.id == selected.id,
                  onTap: () => data.selectStroke(stroke.id),
                ),
            ],
          ),
          const SizedBox(height: 20),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 160,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.bg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.accessibility_new, color: AppColors.referenceBlue, size: 48),
                      SizedBox(height: 8),
                      Text('Reference clip placeholder', style: TextStyle(color: AppColors.textMuted)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final phase in selected.phases) PillBadge(label: phase.label),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          NeonButton(
            label: 'Record my attempt →',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Record step lands in Alpha 1.2.')),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StrokeTile extends StatelessWidget {
  const _StrokeTile({
    required this.name,
    required this.subtype,
    required this.selected,
    required this.onTap,
  });

  final String name;
  final String subtype;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? AppColors.accent : AppColors.border,
              width: selected ? 2 : 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                const SizedBox(height: 6),
                Text(subtype, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
