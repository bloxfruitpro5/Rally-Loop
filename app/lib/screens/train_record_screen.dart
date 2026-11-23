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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: data.backTrainStep,
        ),
        title: Text('Record · ${stroke.name}'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          const Text(
            'Step 2 of 3 · Camera stays on-device until Beta.',
            style: TextStyle(color: AppColors.textMuted),
          ),
          const SizedBox(height: 16),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: AspectRatio(
                aspectRatio: 3 / 4,
                child: PoseFrame(
                  color: AppColors.accent,
                  phase: armed ? 2 : 0,
                  flipped: data.previewFlipped,
                  timer: armed ? '00:12' : '00:00',
                  banner: armed
                      ? '17 keypoints locked · right elbow tracked'
                      : 'Hold still — waiting for a pose',
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _RecordControl(
                icon: armed ? Icons.stop_circle_outlined : Icons.fiber_manual_record,
                label: armed ? 'Stop' : 'Record',
                color: AppColors.danger,
                onTap: data.toggleRecord,
              ),
              _RecordControl(
                icon: Icons.slow_motion_video,
                label: data.previewSpeedLabel,
                color: AppColors.textPrimary,
                onTap: data.cycleSpeed,
              ),
              _RecordControl(
                icon: Icons.flip,
                label: data.previewFlipped ? 'Flipped' : 'Flip',
                color: data.previewFlipped ? AppColors.accent : AppColors.textPrimary,
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
    );
  }
}

class _RecordControl extends StatelessWidget {
  const _RecordControl({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 6),
            Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}
