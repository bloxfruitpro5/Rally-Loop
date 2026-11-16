import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:rallyloop/data/mock_data.dart';
import 'package:rallyloop/screens/main_shell.dart';
import 'package:rallyloop/theme/app_colors.dart';
import 'package:rallyloop/widgets/app_card.dart';
import 'package:rallyloop/widgets/neon_button.dart';
import 'package:rallyloop/widgets/pill_badge.dart';
import 'package:rallyloop/widgets/progress_bar.dart';
import 'package:rallyloop/widgets/score_ring.dart';

/// Foundation stub for Home. Full dashboard layout lands in Alpha 1.2.
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
          PillBadge(label: '${user.streakDays}', tone: PillTone.warning),
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
            child: Row(
              children: [
                ScoreRing(
                  percent: user.techniqueScore / 100,
                  label: '${user.techniqueScore}',
                  caption: '/100',
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Technique', style: TextStyle(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final score in data.strokeScores)
                            PillBadge(
                              label: '${score.shortLabel} ${score.score}',
                              tone: toneForScore(score.score),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppCard(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.accessibility_new, color: AppColors.accent),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Pick up where you left off', style: TextStyle(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 4),
                      Text(data.pickUp.title),
                      Text(data.pickUp.lastFix, style: const TextStyle(color: AppColors.textMuted)),
                    ],
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
                        'Week 12 Challenge: ${data.challenge.title}',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    PillBadge(label: data.challenge.timeLeftLabel, tone: PillTone.warning),
                  ],
                ),
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
            icon: Icons.videocam,
            onPressed: () => context.read<ShellController>().select(1),
          ),
          const SizedBox(height: 20),
          Text('Recent swings', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          SizedBox(
            height: 88,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: data.recentSwings.length,
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final swing = data.recentSwings[index];
                return AppCard(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: SizedBox(
                    width: 96,
                    child: Column(
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
                        Text(data.strokeById(swing.strokeId).shortLabel),
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
