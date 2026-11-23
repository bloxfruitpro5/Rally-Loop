import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:rallyloop/data/mock_data.dart';
import 'package:rallyloop/models/swing.dart';
import 'package:rallyloop/screens/main_shell.dart';
import 'package:rallyloop/theme/app_colors.dart';
import 'package:rallyloop/widgets/neon_button.dart';
import 'package:rallyloop/widgets/pill_badge.dart';
import 'package:rallyloop/widgets/pose_frame.dart';

class TrainCompareScreen extends StatelessWidget {
  const TrainCompareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.watch<MockData>();
    final swing = data.comparisonSwing;
    final stroke = data.strokeById(swing.strokeId);
    final phases = stroke.phases;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: data.backTrainStep,
        ),
        title: Text('${stroke.name} · ${swing.matchPercent}%'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          const Text(
            'Step 3 of 3 · Reference versus your swing.',
            style: TextStyle(color: AppColors.textMuted),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 280,
            child: Row(
              children: [
                Expanded(
                  child: _ComparePanel(
                    title: 'REF',
                    color: AppColors.referenceBlue,
                    phase: data.phaseIndex,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ComparePanel(
                    title: 'YOU',
                    color: AppColors.accent,
                    phase: data.phaseIndex,
                    matchPercent: swing.matchPercent,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (var i = 0; i < phases.length; i++)
                GestureDetector(
                  onTap: () => data.selectPhase(i),
                  child: PillBadge(
                    label: phases[i].label,
                    tone: i == data.phaseIndex ? PillTone.accent : PillTone.neutral,
                  ),
                ),
            ],
          ),
          Slider(
            value: data.phaseIndex.toDouble(),
            min: 0,
            max: (phases.length - 1).toDouble(),
            divisions: phases.length - 1,
            activeColor: AppColors.accent,
            label: phases[data.phaseIndex].label,
            onChanged: (value) => data.selectPhase(value.round()),
          ),
          const SizedBox(height: 4),
          const Text('Joint metrics', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          for (final metric in swing.metrics) _MetricRow(metric: metric),
          const SizedBox(height: 16),
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.insightBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.danger.withValues(alpha: 0.7)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'LARGEST DEVIATION',
                    style: TextStyle(color: AppColors.danger, fontWeight: FontWeight.w800, fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  Text(swing.largestDeviation, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                  const SizedBox(height: 4),
                  Text(swing.largestDeviationDetail, style: const TextStyle(color: AppColors.textMuted)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: data.nextSwing,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textPrimary,
                    side: const BorderSide(color: AppColors.border),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('Next swing', style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: NeonButton(
                  label: 'Ask Coach',
                  onPressed: () => context.read<ShellController>().select(2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ComparePanel extends StatelessWidget {
  const _ComparePanel({
    required this.title,
    required this.color,
    required this.phase,
    this.matchPercent,
  });

  final String title;
  final Color color;
  final int phase;
  final int? matchPercent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w800)),
            if (matchPercent != null) ...[
              const Spacer(),
              Text('$matchPercent%', style: const TextStyle(fontWeight: FontWeight.w800)),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: PoseFrame(color: color, phase: phase),
        ),
      ],
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.metric});

  final JointMetric metric;

  @override
  Widget build(BuildContext context) {
    final alert = metric.deltaDegrees.abs() >= 15;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(metric.joint)),
          Text(
            metric.displayValue,
            style: TextStyle(
              color: alert ? AppColors.danger : AppColors.accent,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
