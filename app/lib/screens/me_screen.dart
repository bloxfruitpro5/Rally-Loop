import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:rallyloop/data/mock_data.dart';
import 'package:rallyloop/theme/app_colors.dart';
import 'package:rallyloop/widgets/app_card.dart';
import 'package:rallyloop/widgets/neon_button.dart';
import 'package:rallyloop/widgets/pill_badge.dart';
import 'package:rallyloop/widgets/score_ring.dart';

/// Foundation stub for Me / profile.
class MeScreen extends StatelessWidget {
  const MeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.watch<MockData>();
    final user = data.user;
    return Scaffold(
      appBar: AppBar(title: const Text('Me')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          AppCard(
            child: Row(
              children: [
                ScoreRing(percent: user.techniqueScore / 100, label: '${user.techniqueScore}'),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name, style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 4),
                      Text(user.grade, style: const TextStyle(color: AppColors.textMuted)),
                      const SizedBox(height: 8),
                      Text('${user.streakDays}-day streak'),
                      Text('${user.questionPoints} question points'),
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
                const Text('Milestones', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final badge in data.badges)
                      PillBadge(
                        label: badge.title,
                        tone: badge.unlocked ? PillTone.accent : PillTone.neutral,
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          NeonButton(
            label: 'Sign out',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sign-in arrives with Firebase.')),
              );
            },
          ),
        ],
      ),
    );
  }
}
