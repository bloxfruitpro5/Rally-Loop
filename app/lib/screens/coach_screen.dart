import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rallyloop/data/mock_data.dart';
import 'package:rallyloop/theme/app_colors.dart';
import 'package:rallyloop/widgets/app_card.dart';
import 'package:rallyloop/widgets/pill_badge.dart';

class CoachScreen extends StatelessWidget {
  const CoachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.watch<MockData>();
    return Scaffold(
      appBar: AppBar(title: const Text('Coach')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          const PillBadge(label: 'Forehand', tone: PillTone.accent),
          const SizedBox(height: 16),
          for (final message in data.messages) ...[
            Align(
              alignment: message.fromCoach ? Alignment.centerLeft : Alignment.centerRight,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 460),
                child: AppCard(
                  child: Text(
                    message.text,
                    style: TextStyle(color: message.fromCoach ? AppColors.textPrimary : AppColors.accent),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [for (final chip in data.suggestionChips) PillBadge(label: chip)],
          ),
        ],
      ),
    );
  }
}
