import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rallyloop/data/mock_data.dart';
import 'package:rallyloop/screens/main_shell.dart';
import 'package:rallyloop/theme/app_colors.dart';
import 'package:rallyloop/widgets/app_card.dart';
import 'package:rallyloop/widgets/neon_button.dart';
import 'package:rallyloop/widgets/pill_badge.dart';
import 'package:rallyloop/widgets/progress_bar.dart';
import 'package:rallyloop/widgets/score_ring.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.watch<MockData>();
    final user = data.user;
    return Scaffold(
      appBar: AppBar(title: const Text('RallyLoop')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Text('Hey ${user.name}', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 4),
          Text(
            '${user.grade} · ${user.streakDays}-day streak',
            style: const TextStyle(color: AppColors.textMuted),
          ),
          const SizedBox(height: 20),
          AppCard(
            child: Row(
              children: [
                ScoreRing(percent: user.techniqueScore / 100, label: '${user.techniqueScore}'),
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
            child: ProgressBar(
              value: data.challenge.fraction,
              label: data.challenge.title,
              trailing: '${data.challenge.progress}/${data.challenge.goal}',
            ),
          ),
          const SizedBox(height: 16),
          NeonButton(
            label: 'Start a training session',
            icon: Icons.sports_tennis,
            onPressed: () => context.read<ShellController>().select(1),
          ),
        ],
      ),
    );
  }
}
