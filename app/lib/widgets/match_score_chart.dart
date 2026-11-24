import 'package:material_ui/material_ui.dart';
import 'package:rallyloop/theme/app_colors.dart';

/// Simple match-score line chart for Session Recap (avoids legacy fl_chart Material).
class MatchScoreChart extends StatelessWidget {
  const MatchScoreChart({
    super.key,
    required this.scores,
    this.height = 160,
  });

  final List<int> scores;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: _MatchScoreChartPainter(scores: scores),
      ),
    );
  }
}

class _MatchScoreChartPainter extends CustomPainter {
  _MatchScoreChartPainter({required this.scores});

  final List<int> scores;

  @override
  void paint(Canvas canvas, Size size) {
    if (scores.isEmpty) return;

    const minY = 50.0;
    const maxY = 100.0;
    const left = 28.0;
    final right = size.width - 8;
    const top = 12.0;
    final bottom = size.height - 22;
    final chartWidth = right - left;
    final chartHeight = bottom - top;

    final grid = Paint()
      ..color = AppColors.border
      ..strokeWidth = 1;
    for (final tick in [60, 70, 80, 90, 100]) {
      final y = bottom - ((tick - minY) / (maxY - minY)) * chartHeight;
      canvas.drawLine(Offset(left, y), Offset(right, y), grid);
      final tp = TextPainter(
        text: TextSpan(
          text: '$tick',
          style: const TextStyle(color: AppColors.textMuted, fontSize: 10, fontWeight: FontWeight.w600),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(0, y - tp.height / 2));
    }

    Offset pointFor(int index, int score) {
      final x = left + (scores.length == 1 ? 0 : index / (scores.length - 1)) * chartWidth;
      final clamped = score.toDouble().clamp(minY, maxY);
      final y = bottom - ((clamped - minY) / (maxY - minY)) * chartHeight;
      return Offset(x, y);
    }

    final path = Path();
    for (var i = 0; i < scores.length; i++) {
      final p = pointFor(i, scores[i]);
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }

    final fillPath = Path.from(path)
      ..lineTo(right, bottom)
      ..lineTo(left, bottom)
      ..close();
    canvas.drawPath(
      fillPath,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.accent.withValues(alpha: 0.28),
            AppColors.accent.withValues(alpha: 0.02),
          ],
        ).createShader(Rect.fromLTRB(left, top, right, bottom)),
    );

    canvas.drawPath(
      path,
      Paint()
        ..color = AppColors.accent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    final last = pointFor(scores.length - 1, scores.last);
    canvas.drawCircle(last, 5, Paint()..color = AppColors.accent);
    canvas.drawCircle(last, 2.5, Paint()..color = AppColors.onAccent);

    final startLabel = TextPainter(
      text: const TextSpan(
        text: '1',
        style: TextStyle(color: AppColors.textMuted, fontSize: 10, fontWeight: FontWeight.w600),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    startLabel.paint(canvas, Offset(left, bottom + 4));

    final endLabel = TextPainter(
      text: TextSpan(
        text: '${scores.length}',
        style: const TextStyle(color: AppColors.textMuted, fontSize: 10, fontWeight: FontWeight.w600),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    endLabel.paint(canvas, Offset(right - endLabel.width, bottom + 4));
  }

  @override
  bool shouldRepaint(covariant _MatchScoreChartPainter oldDelegate) {
    if (identical(oldDelegate.scores, scores)) return false;
    if (oldDelegate.scores.length != scores.length) return true;
    for (var i = 0; i < scores.length; i++) {
      if (oldDelegate.scores[i] != scores[i]) return true;
    }
    return false;
  }
}
