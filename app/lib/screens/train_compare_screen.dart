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
    final swingNumber = (data.focusSwingIndex ?? 0) + 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: data.backTrainStep,
        ),
        title: const Text('Side-by-side'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: PillBadge(label: data.previewSpeedLabel, tone: PillTone.neutral),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Text(
            'Swing $swingNumber · ${stroke.name}',
            style: const TextStyle(color: AppColors.textMuted),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 260,
            child: Row(
              children: [
                Expanded(
                  child: _ComparePanel(
                    title: 'REFERENCE',
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
                    highlightElbow: data.phaseIndex == 2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              for (var i = 0; i < phases.length; i++) ...[
                if (i > 0) Expanded(child: Container(height: 2, color: AppColors.border)),
                GestureDetector(
                  onTap: () => data.selectPhase(i),
                  child: Column(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: i == data.phaseIndex ? AppColors.warning : AppColors.border,
                          border: Border.all(
                            color: i == data.phaseIndex ? AppColors.warning : AppColors.textMuted,
                            width: 2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        phases[i].label.split('-').first,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: i == data.phaseIndex ? AppColors.warning : AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
          _MetricRow(
            label: 'Joint match vs reference',
            value: '${swing.matchPercent}%',
            tone: PillTone.neutral,
          ),
          for (final metric in swing.metrics) _MetricRow.fromMetric(metric),
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
                  Text(
                    '${swing.largestDeviation} → ${swing.largestDeviationDetail}',
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                  ),
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
          const SizedBox(height: 8),
          TextButton(
            onPressed: data.openRecap,
            child: const Text(
              'Finish session → Today’s recap',
              style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.w700),
            ),
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
    this.highlightElbow = false,
  });

  final String title;
  final Color color;
  final int phase;
  final int? matchPercent;
  final bool highlightElbow;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 12)),
            if (matchPercent != null) ...[
              const Spacer(),
              Text('$matchPercent%', style: const TextStyle(fontWeight: FontWeight.w800)),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: PoseFrame(
            color: color,
            phase: phase,
            highlightElbow: highlightElbow,
          ),
        ),
      ],
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({
    required this.label,
    required this.value,
    required this.tone,
  });

  factory _MetricRow.fromMetric(JointMetric metric) {
    final alert = metric.deltaDegrees.abs() >= 10;
    return _MetricRow(
      label: metric.joint,
      value: metric.displayValue,
      tone: alert ? PillTone.danger : PillTone.accent,
    );
  }

  final String label;
  final String value;
  final PillTone tone;

  @override
  Widget build(BuildContext context) {
    final color = switch (tone) {
      PillTone.danger => AppColors.danger,
      PillTone.accent => AppColors.accent,
      PillTone.warning => AppColors.warning,
      PillTone.neutral => AppColors.textPrimary,
    };
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(value, style: TextStyle(color: color, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}
