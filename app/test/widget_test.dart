import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rallyloop/data/mock_data.dart';
import 'package:rallyloop/main.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  test('mock seed covers the alpha screens', () {
    final data = MockData();
    expect(data.user.name, 'Maya');
    expect(data.user.streakDays, 12);
    expect(data.user.techniqueScore, 78);
    expect(data.strokes.map((stroke) => stroke.id), ['fh', 'bh', 'serve', 'return']);
    expect(data.strokes.every((stroke) => stroke.subtype.isNotEmpty), isTrue);
    expect(data.strokeScores.map((score) => score.score), [82, 71, 64, 77]);
    expect(data.pickUp.title, contains('Backhand'));
    expect(data.swings, isNotEmpty);
    expect(data.recentSwings, hasLength(3));
    expect(data.recap.swingCount, 24);
    expect(data.recap.matchScores, isNotEmpty);
    expect(data.messages.where((message) => message.fromCoach), isNotEmpty);
    expect(data.posts.first.gradeLabel, contains('G2'));
    expect(data.leaderboard.where((entry) => entry.isYou), hasLength(1));
    expect(data.badges, isNotEmpty);
    expect(data.challenge.timeLeftLabel, isNotEmpty);
    expect(data.challenge.goal, greaterThan(data.challenge.progress));
  });

  test('scripted coach replies stay grounded in the session', () {
    final data = MockData();
    final before = data.messages.length;
    data.sendCoachMessage('Give me a drill');
    expect(data.messages.length, before + 2);
    expect(data.messages.last.text, data.recap.drill);
  });

  testWidgets('shell switches across the five tabs', (tester) async {
    await tester.pumpWidget(const RallyLoopApp());
    await tester.pump();

    expect(find.text('Hey, Maya'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Pick up where you left off'), findsOneWidget);

    await tester.tap(find.text('Train'));
    await tester.pumpAndSettle();
    expect(find.text('Choose a stroke'), findsOneWidget);
    expect(find.text('Forehand'), findsWidgets);

    await tester.tap(find.text('Coach'));
    await tester.pumpAndSettle();
    expect(find.textContaining('elbow keep collapsing'), findsOneWidget);

    await tester.tap(find.text('Community'));
    await tester.pumpAndSettle();
    expect(find.text('Jordan L.'), findsOneWidget);

    await tester.tap(find.text('Me'));
    await tester.pumpAndSettle();
    expect(find.text('42 question points'), findsOneWidget);
    expect(find.text('500 SWINGS'), findsOneWidget);
  });
}
