import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:rallyloop/data/mock_data.dart';
import 'package:rallyloop/theme/app_colors.dart';
import 'package:rallyloop/widgets/pill_badge.dart';

class CoachScreen extends StatefulWidget {
  const CoachScreen({super.key});

  @override
  State<CoachScreen> createState() => _CoachScreenState();
}

class _CoachScreenState extends State<CoachScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _send(MockData data, [String? preset]) async {
    final text = (preset ?? _controller.text).trim();
    if (text.isEmpty) return;
    data.sendCoachMessage(text);
    _controller.clear();
    await Future<void>.delayed(const Duration(milliseconds: 50));
    if (!_scrollController.hasClients) return;
    await _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<MockData>();
    final stroke = data.selectedStroke;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coach'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: PillBadge(label: stroke.name.toUpperCase(), tone: PillTone.accent),
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Grounded in your last 3 sessions.',
                style: TextStyle(color: AppColors.textMuted),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              itemCount: data.messages.length,
              itemBuilder: (context, index) {
                final message = data.messages[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Align(
                    alignment: message.fromCoach ? Alignment.centerLeft : Alignment.centerRight,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 460),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: message.fromCoach ? AppColors.card : AppColors.accent.withValues(alpha: 0.16),
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(16),
                            topRight: const Radius.circular(16),
                            bottomLeft: Radius.circular(message.fromCoach ? 4 : 16),
                            bottomRight: Radius.circular(message.fromCoach ? 16 : 4),
                          ),
                          border: Border.all(
                            color: message.fromCoach
                                ? AppColors.border
                                : AppColors.accent.withValues(alpha: 0.5),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Text(
                            message.text,
                            style: TextStyle(
                              color: message.fromCoach ? AppColors.textPrimary : AppColors.accent,
                              fontWeight: message.fromCoach ? FontWeight.w500 : FontWeight.w700,
                              height: 1.35,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final chip in data.suggestionChips) ...[
                    ActionChip(
                      label: Text(chip),
                      onPressed: () => _send(data, chip),
                    ),
                    const SizedBox(width: 8),
                  ],
                ],
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      minLines: 1,
                      maxLines: 3,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _send(data),
                      decoration: InputDecoration(
                        hintText: 'Ask about your technique...',
                        filled: true,
                        fillColor: AppColors.card,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: AppColors.accent),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Material(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(14),
                    child: InkWell(
                      onTap: () => _send(data),
                      borderRadius: BorderRadius.circular(14),
                      child: const SizedBox(
                        width: 48,
                        height: 48,
                        child: Icon(Icons.send_rounded, color: AppColors.onAccent),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
