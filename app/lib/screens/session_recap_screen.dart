import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:rallyloop/data/mock_data.dart';
import 'package:rallyloop/screens/main_shell.dart';
import 'package:rallyloop/theme/app_colors.dart';
import 'package:rallyloop/widgets/app_card.dart';
import 'package:rallyloop/widgets/match_score_chart.dart';
import 'package:rallyloop/widgets/neon_button.dart';
import 'package:rallyloop/widgets/pill_badge.dart';

class SessionRecapScreen extends StatelessWidget {
  const SessionRecapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.watch<MockData>();
    final recap = data.recap;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: data.backTrainStep,
        ),
        title: const Text("Today's recap"),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Row(
            children: [
              const PillBadge(label: 'SESSION COMPLETE', tone: PillTone.accent),
              const SizedBox(width: 8),
              Text(
                '• ${recap.durationLabel}',
                style: const TextStyle(color: AppColors.textMuted, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _StatCard(label: 'SWINGS', value: '${recap.swingCount}')),
              const SizedBox(width: 10),
              Expanded(child: _StatCard(label: 'AVG MATCH', value: '${recap.avgMatch}%')),
              const SizedBox(width: 10),
              Expanded(child: _StatCard(label: 'BEST', value: '${recap.bestMatch}%')),
            ],
          ),
          const SizedBox(height: 16),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Fix this next practice',
                        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                      ),
                    ),
                    PillBadge(label: 'PRIORITY 1', tone: PillTone.danger),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  recap.priorityFix,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                Text(recap.priorityDetail, style: const TextStyle(color: AppColors.textMuted, height: 1.4)),
                const SizedBox(height: 14),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.bg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.fitness_center, color: AppColors.accent, size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Drill', style: TextStyle(fontWeight: FontWeight.w800)),
                              const SizedBox(height: 4),
                              Text(recap.drill, style: const TextStyle(color: AppColors.textMuted, height: 1.35)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'MATCH SCORE ACROSS SWINGS',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.4,
                            ),
                      ),
                    ),
                    PillBadge(label: recap.improvementLabel, tone: PillTone.accent),
                  ],
                ),
                const SizedBox(height: 12),
                MatchScoreChart(scores: recap.matchScores),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Clip sharing lands in Golden.')),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textPrimary,
                    side: const BorderSide(color: AppColors.border),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('Share clip', style: TextStyle(fontWeight: FontWeight.w700)),
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

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textMuted,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 22)),
        ],
      ),
    );
  }
}
