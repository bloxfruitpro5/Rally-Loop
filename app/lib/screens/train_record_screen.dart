import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:rallyloop/data/mock_data.dart';
import 'package:rallyloop/theme/app_colors.dart';
import 'package:rallyloop/widgets/neon_button.dart';
import 'package:rallyloop/widgets/pose_frame.dart';

class TrainRecordScreen extends StatelessWidget {
  const TrainRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.watch<MockData>();
    final stroke = data.selectedStroke;
    final armed = data.recordArmed;
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: data.backTrainStep,
        ),
        title: const Text('Record attempt'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Step 2 of 3 · ${stroke.name}',
                  style: const TextStyle(color: AppColors.textMuted),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: PoseFrame(
                  color: AppColors.accent,
                  phase: armed ? 2 : 0,
                  flipped: data.previewFlipped,
                  timer: armed ? '0:08' : '0:00',
                  topLeftLabel: '${stroke.name.toUpperCase()} · REFERENCE LOADED',
                  banner: armed
                      ? 'Full body in frame — 33/33 keypoints'
                      : 'Stand 10–15 ft back · phone at hip height · landscape',
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _SideControl(
                    label: data.previewSpeedLabel,
                    icon: Icons.slow_motion_video,
                    active: data.previewSpeed != 1,
                    onTap: data.cycleSpeed,
                  ),
                  _RecordButton(armed: armed, onTap: data.toggleRecord),
                  _SideControl(
                    label: data.previewFlipped ? 'Flipped' : 'Flip',
                    icon: Icons.cameraswitch_outlined,
                    active: data.previewFlipped,
                    onTap: data.toggleFlip,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              NeonButton(
                label: 'Review side by side',
                onPressed: data.openReview,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecordButton extends StatelessWidget {
  const _RecordButton({required this.armed, required this.onTap});

  final bool armed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              width: 78,
              height: 78,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.danger, width: 4),
                color: armed ? AppColors.danger.withValues(alpha: 0.18) : Colors.transparent,
              ),
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  width: armed ? 28 : 54,
                  height: armed ? 28 : 54,
                  decoration: BoxDecoration(
                    color: AppColors.danger,
                    borderRadius: BorderRadius.circular(armed ? 6 : 99),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              armed ? 'Stop' : 'Record',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

class _SideControl extends StatelessWidget {
  const _SideControl({
    required this.label,
    required this.icon,
    required this.active,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.accent : AppColors.textPrimary;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 6),
            Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}
