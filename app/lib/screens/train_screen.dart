import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:rallyloop/data/mock_data.dart';
import 'package:rallyloop/screens/session_recap_screen.dart';
import 'package:rallyloop/screens/train_compare_screen.dart';
import 'package:rallyloop/screens/train_record_screen.dart';
import 'package:rallyloop/theme/app_colors.dart';
import 'package:rallyloop/widgets/app_card.dart';
import 'package:rallyloop/widgets/neon_button.dart';
import 'package:rallyloop/widgets/pill_badge.dart';
import 'package:rallyloop/widgets/pose_frame.dart';

class TrainScreen extends StatelessWidget {
  const TrainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final step = context.watch<MockData>().trainStep;
    return switch (step) {
      0 => const TrainChooseScreen(),
      1 => const TrainRecordScreen(),
      2 => const TrainCompareScreen(),
      _ => const SessionRecapScreen(),
    };
  }
}

class TrainChooseScreen extends StatelessWidget {
  const TrainChooseScreen({super.key});

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
            'Step 1 of 3',
            style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.w800, fontSize: 12),
          ),
          const SizedBox(height: 4),
          const Text(
            'Each stroke loads a reference clip. You copy it, then the server compares both.',
            style: TextStyle(color: AppColors.textMuted),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.2,
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
          Text(
            'Reference clip · ${selected.name}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          AppCard(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 10,
                  child: PoseFrame(
                    color: AppColors.referenceBlue,
                    phase: data.phaseIndex,
                    showPlay: true,
                    topLeftLabel: 'REFERENCE',
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (var i = 0; i < selected.phases.length; i++)
                      GestureDetector(
                        onTap: () => data.selectPhase(i),
                        child: PillBadge(
                          label: selected.phases[i].label,
                          tone: i == data.phaseIndex ? PillTone.accent : PillTone.neutral,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          NeonButton(
            label: 'Record my attempt →',
            onPressed: data.openRecord,
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
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                    ),
                    if (selected) const PillBadge(label: 'SELECTED', tone: PillTone.accent),
                  ],
                ),
                const Spacer(),
                Text(subtype, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
