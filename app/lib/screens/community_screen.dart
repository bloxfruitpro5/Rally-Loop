import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rallyloop/data/mock_data.dart';
import 'package:rallyloop/theme/app_colors.dart';
import 'package:rallyloop/widgets/app_card.dart';
import 'package:rallyloop/widgets/pill_badge.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.watch<MockData>();
    return Scaffold(
      appBar: AppBar(title: const Text('Community')),
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
                  tone: filter == 'All' ? PillTone.accent : PillTone.neutral,
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
                      PillBadge(label: post.filterTag),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(post.caption),
                  const SizedBox(height: 8),
                  Text(post.aiSummary, style: const TextStyle(color: AppColors.textMuted)),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}
