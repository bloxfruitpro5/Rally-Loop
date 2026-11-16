import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:rallyloop/data/mock_data.dart';
import 'package:rallyloop/theme/app_colors.dart';
import 'package:rallyloop/widgets/app_card.dart';
import 'package:rallyloop/widgets/pill_badge.dart';

/// Foundation stub for Coach. Full chat composer lands in Alpha 1.2.
class CoachScreen extends StatelessWidget {
  const CoachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.watch<MockData>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coach'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: PillBadge(label: 'FOREHAND', tone: PillTone.accent),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          const Text(
            'Grounded in your last 3 sessions.',
            style: TextStyle(color: AppColors.textMuted),
          ),
          const SizedBox(height: 16),
          for (final message in data.messages) ...[
            Align(
              alignment: message.fromCoach ? Alignment.centerLeft : Alignment.centerRight,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 460),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: message.fromCoach ? AppColors.card : AppColors.accent.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: message.fromCoach ? AppColors.border : AppColors.accent.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Text(
                      message.text,
                      style: TextStyle(
                        color: message.fromCoach ? AppColors.textPrimary : AppColors.accent,
                        fontWeight: message.fromCoach ? FontWeight.w500 : FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final chip in data.suggestionChips)
                ActionChip(
                  label: Text(chip),
                  onPressed: () => data.sendCoachMessage(chip),
                ),
            ],
          ),
          const SizedBox(height: 16),
          AppCard(
            child: Text(
              'Composer + OpenAI grounding land later. Chips use scripted replies for now.',
              style: TextStyle(color: AppColors.textMuted),
            ),
          ),
        ],
      ),
    );
  }
}
