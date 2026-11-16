import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:rallyloop/data/mock_data.dart';
import 'package:rallyloop/theme/app_colors.dart';
import 'package:rallyloop/widgets/app_card.dart';
import 'package:rallyloop/widgets/pill_badge.dart';

/// Foundation stub for Community. Full feed + challenges land in Alpha 1.2.
class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.watch<MockData>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Post clip lands in Alpha 1.2.')),
              );
            },
            child: const Text('Post clip'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final filter in data.communityFilters)
                PillBadge(
                  label: filter,
                  tone: filter == 'My team' ? PillTone.accent : PillTone.neutral,
                ),
            ],
          ),
          const SizedBox(height: 16),
          for (final post in data.posts) ...[
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(post.author, style: const TextStyle(fontWeight: FontWeight.w700)),
                      const SizedBox(width: 8),
                      PillBadge(label: post.gradeLabel),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 120,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.bg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.play_circle_outline, color: AppColors.textMuted, size: 40),
                  ),
                  const SizedBox(height: 12),
                  Text(post.caption),
                  const SizedBox(height: 8),
                  PillBadge(label: 'AI SUMMARY · ${post.feedbackCount} REPLIES', tone: PillTone.warning),
                  const SizedBox(height: 8),
                  Text(post.aiSummary, style: const TextStyle(color: AppColors.textMuted)),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        data.challenge.title,
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                    ),
                    PillBadge(label: data.challenge.timeLeftLabel, tone: PillTone.warning),
                  ],
                ),
                const SizedBox(height: 8),
                Text(data.challenge.description, style: const TextStyle(color: AppColors.textMuted)),
                const SizedBox(height: 12),
                Text('${data.challenge.progress} / ${data.challenge.goal}'),
                if (data.challenge.topPercent != null) ...[
                  const SizedBox(height: 8),
                  PillBadge(label: 'Top ${data.challenge.topPercent}%', tone: PillTone.accent),
                ],
                const SizedBox(height: 16),
                const Text('Team leaderboard', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                for (var i = 0; i < data.leaderboard.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        SizedBox(width: 24, child: Text('${i + 1}.')),
                        Expanded(
                          child: Text(
                            data.leaderboard[i].name,
                            style: TextStyle(
                              color: data.leaderboard[i].isYou ? AppColors.accent : AppColors.textPrimary,
                              fontWeight: data.leaderboard[i].isYou ? FontWeight.w800 : FontWeight.w500,
                            ),
                          ),
                        ),
                        Text('${data.leaderboard[i].points}'),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
