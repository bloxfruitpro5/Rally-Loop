import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:rallyloop/data/mock_data.dart';
import 'package:rallyloop/screens/main_shell.dart';
import 'package:rallyloop/theme/app_colors.dart';
import 'package:rallyloop/widgets/app_card.dart';
import 'package:rallyloop/widgets/neon_button.dart';
import 'package:rallyloop/widgets/pill_badge.dart';
import 'package:rallyloop/widgets/pose_frame.dart';
import 'package:rallyloop/widgets/progress_bar.dart';
import 'package:rallyloop/widgets/score_ring.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.watch<MockData>();
    final user = data.user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Hey, ${user.name}'),
        actions: [
          const Icon(Icons.local_fire_department, color: AppColors.warning, size: 20),
          const SizedBox(width: 4),
          Text(
            '${user.streakDays}',
            style: const TextStyle(color: AppColors.warning, fontWeight: FontWeight.w800),
          ),
          const SizedBox(width: 12),
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.sports_tennis, color: AppColors.accent),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ScoreRing(
                      percent: user.techniqueScore / 100,
                      label: '${user.techniqueScore}',
                      radius: 48,
                      lineWidth: 9,
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Technique Score',
                            style: TextStyle(color: AppColors.textMuted, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '${user.techniqueScore}/100',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Swings: ${data.totalSwings}',
                            style: const TextStyle(color: AppColors.textMuted),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                for (final score in data.strokeScores) ...[
                  ProgressBar(
                    value: score.score / 100,
                    label: score.shortLabel,
                    trailing: '${score.score}',
                    height: 6,
                    color: score.score >= 80
                        ? AppColors.accent
                        : score.score >= 70
                            ? AppColors.warning
                            : AppColors.danger,
                  ),
                  const SizedBox(height: 10),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppCard(
            onTap: () {
              data.beginTrain(strokeId: data.pickUp.strokeId);
              context.read<ShellController>().select(1);
            },
            child: Row(
              children: [
                SizedBox(
                  width: 72,
                  height: 96,
                  child: PoseFrame(
                    color: AppColors.accent,
                    phase: 1,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Pick up where you left off',
                        style: TextStyle(color: AppColors.textMuted, fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(data.pickUp.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(data.pickUp.lastFix, style: const TextStyle(color: AppColors.textMuted)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.textMuted),
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
                        'Week 12 Challenge',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ),
                    PillBadge(label: data.challenge.timeLeftLabel, tone: PillTone.warning),
                  ],
                ),
                const SizedBox(height: 6),
                Text(data.challenge.title, style: const TextStyle(color: AppColors.textMuted)),
                const SizedBox(height: 12),
                ProgressBar(
                  value: data.challenge.fraction,
                  trailing: '${data.challenge.progress}/${data.challenge.goal}',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          NeonButton(
            label: 'Start a training session',
            icon: Icons.sports_tennis,
            onPressed: () {
              data.beginTrain();
              context.read<ShellController>().select(1);
            },
          ),
          const SizedBox(height: 20),
          Text('Recent swings', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          SizedBox(
            height: 104,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: data.recentSwings.length,
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final swing = data.recentSwings[index];
                return SizedBox(
                  width: 120,
                  child: AppCard(
                    padding: const EdgeInsets.all(12),
                    onTap: () {
                      data.openComparison(swing.id);
                      context.read<ShellController>().select(1);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${swing.matchPercent}%',
                          style: const TextStyle(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w800,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          data.strokeById(swing.strokeId).shortLabel,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                        ),
                        Text(
                          swing.largestDeviation,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
