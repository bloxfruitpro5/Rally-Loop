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
    expect(data.strokes.map((stroke) => stroke.id), ['fh', 'bh', 'serve', 'return']);
    expect(data.strokeScores, hasLength(4));
    expect(data.swings, isNotEmpty);
    expect(data.recap.matchScores, isNotEmpty);
    expect(data.messages.where((message) => message.fromCoach), isNotEmpty);
    expect(data.posts, isNotEmpty);
    expect(data.leaderboard.where((entry) => entry.isYou), hasLength(1));
    expect(data.badges, isNotEmpty);
    expect(data.challenge.goal, greaterThan(data.challenge.progress));
  });

  testWidgets('shell switches across the five tabs', (tester) async {
    await tester.pumpWidget(const RallyLoopApp());
    await tester.pump();

    expect(find.text('Hey Maya'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);

    await tester.tap(find.text('Train'));
    await tester.pumpAndSettle();
    expect(find.text('Choose a stroke'), findsOneWidget);
    expect(find.text('Forehand'), findsOneWidget);

    await tester.tap(find.text('Coach'));
    await tester.pumpAndSettle();
    expect(find.textContaining('averaged 74%'), findsOneWidget);

    await tester.tap(find.text('Community'));
    await tester.pumpAndSettle();
    expect(find.text('Jordan'), findsOneWidget);

    await tester.tap(find.text('Me'));
    await tester.pumpAndSettle();
    expect(find.text('42 question points'), findsOneWidget);
  });
}
