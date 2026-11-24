import 'package:flutter/foundation.dart';
import 'package:rallyloop/models/challenge.dart';
import 'package:rallyloop/models/coach_message.dart';
import 'package:rallyloop/models/community_post.dart';
import 'package:rallyloop/models/pick_up_session.dart';
import 'package:rallyloop/models/session_recap.dart';
import 'package:rallyloop/models/stroke.dart';
import 'package:rallyloop/models/swing.dart';
import 'package:rallyloop/models/user_profile.dart';

const _phases = [
  StrokePhase(id: 'ready', label: 'Ready'),
  StrokePhase(id: 'backswing', label: 'Backswing'),
  StrokePhase(id: 'contact', label: 'Contact'),
  StrokePhase(id: 'follow', label: 'Follow-through'),
];

/// Alpha seed. Screens read this until Firebase lands in Beta.
class MockData extends ChangeNotifier {
  final UserProfile user = const UserProfile(
    name: 'Maya',
    grade: 'Varsity',
    streakDays: 12,
    questionPoints: 42,
    techniqueScore: 78,
  );

  final List<Stroke> strokes = const [
    Stroke(
      id: 'fh',
      name: 'Forehand',
      shortLabel: 'Forehand',
      subtype: 'Topspin - open stance',
      phases: _phases,
    ),
    Stroke(
      id: 'bh',
      name: 'Backhand',
      shortLabel: 'Backhand',
      subtype: 'Two-handed',
      phases: _phases,
    ),
    Stroke(
      id: 'serve',
      name: 'Serve',
      shortLabel: 'Serve',
      subtype: 'Flat - trophy pose',
      phases: _phases,
    ),
    Stroke(
      id: 'return',
      name: 'Return',
      shortLabel: 'Return',
      subtype: 'Block - compact',
      phases: _phases,
    ),
  ];

  final List<StrokeScore> strokeScores = const [
    StrokeScore(strokeId: 'fh', shortLabel: 'Forehand', score: 82),
    StrokeScore(strokeId: 'bh', shortLabel: 'Backhand', score: 71),
    StrokeScore(strokeId: 'serve', shortLabel: 'Serve', score: 64),
    StrokeScore(strokeId: 'return', shortLabel: 'Return', score: 77),
  ];

  final PickUpSession pickUp = const PickUpSession(
    strokeId: 'bh',
    title: 'Backhand - Two-handed',
    lastFix: 'Last fix: rotate shoulders earlier.',
  );

  final List<Swing> swings = [
    Swing(
      id: 'sw-1',
      strokeId: 'fh',
      matchPercent: 91,
      recordedAt: DateTime(2026, 11, 15, 16, 40),
      largestDeviation: 'Late contact',
      largestDeviationDetail: 'elbow collapse',
      metrics: const [
        JointMetric(joint: 'Elbow extension', deltaDegrees: -24),
        JointMetric(joint: 'Hip-shoulder separation', deltaDegrees: 3),
        JointMetric(joint: 'Knee flexion at contact', deltaDegrees: 11),
        JointMetric(joint: 'Contact point (vs hip)', deltaDegrees: -2, unit: 'in'),
      ],
    ),
    Swing(
      id: 'sw-2',
      strokeId: 'bh',
      matchPercent: 78,
      recordedAt: DateTime(2026, 11, 15, 16, 28),
      largestDeviation: 'Short backswing',
      largestDeviationDetail: 'The backhand takeback stops short of the reference.',
      metrics: const [
        JointMetric(joint: 'Elbow', deltaDegrees: -14),
        JointMetric(joint: 'Wrist', deltaDegrees: 5),
        JointMetric(joint: 'Shoulder', deltaDegrees: -9),
      ],
    ),
    Swing(
      id: 'sw-3',
      strokeId: 'serve',
      matchPercent: 72,
      recordedAt: DateTime(2026, 11, 14, 18, 5),
      largestDeviation: 'Toss too far forward',
      largestDeviationDetail: 'Trophy pose is closed and the toss lands in front of the front foot.',
      metrics: const [
        JointMetric(joint: 'Shoulder', deltaDegrees: -21),
        JointMetric(joint: 'Elbow', deltaDegrees: 11),
        JointMetric(joint: 'Knee', deltaDegrees: 8),
      ],
    ),
    Swing(
      id: 'sw-4',
      strokeId: 'return',
      matchPercent: 82,
      recordedAt: DateTime(2026, 11, 14, 17, 50),
      largestDeviation: 'Split step late',
      largestDeviationDetail: 'The split step lands after the opponent’s contact.',
      metrics: const [
        JointMetric(joint: 'Knee', deltaDegrees: 9),
        JointMetric(joint: 'Hip', deltaDegrees: 7),
      ],
    ),
  ];

  final SessionRecap recap = const SessionRecap(
    swingCount: 24,
    avgMatch: 76,
    bestMatch: 91,
    durationLabel: '34 MIN',
    priorityFix: 'Meet the ball further in front.',
    priorityDetail:
        'Your contact point sits about 6 in behind the front hip. The reference meets the ball about 8 in ahead.',
    drill: 'Shadow 10 forehands and freeze at contact with a cone in front of your front hip, then hit 20 live feeds.',
    improvementLabel: '+15% BY SWING 24',
    matchScores: [62, 65, 68, 71, 70, 74, 76, 79, 81, 78, 83, 85, 84, 88, 86, 89, 87, 90, 88, 91, 89, 90, 91, 91],
  );

  final List<CoachMessage> messages = [
    const CoachMessage(
      id: 'c-1',
      fromCoach: false,
      text: 'Why does my elbow keep collapsing on my forehand?',
    ),
    const CoachMessage(
      id: 'c-2',
      fromCoach: true,
      strokeId: 'fh',
      text:
          'It’s a timing issue. On 19 of 24 swings today you made contact behind your front hip. Elbow fold hit 92° vs the 112° reference on swings 8, 14, and 17.',
    ),
    const CoachMessage(
      id: 'c-3',
      fromCoach: false,
      text: 'What should it feel like when it’s right?',
    ),
    const CoachMessage(
      id: 'c-4',
      fromCoach: true,
      strokeId: 'fh',
      text:
          'Two cues, in order:\n1) Turn as the ball leaves the strings.\n2) Feel contact ahead of the front hip.',
    ),
  ];

  final List<String> suggestionChips = const [
    'Compare to last week',
    'Show me swing 14',
    'Give me a drill',
  ];

  final List<String> communityFilters = const ['My team', 'Following', 'All strokes'];

  final List<CommunityPost> posts = const [
    CommunityPost(
      id: 'p-1',
      author: 'Jordan L.',
      gradeLabel: 'G2 - 71',
      strokeId: 'serve',
      caption: 'Second serve toss still drifting.',
      aiSummary:
          'Teammates agree on two things: the toss drifts behind your head, and your legs are already straight before contact.',
      feedbackCount: 7,
      filterTag: 'My team',
    ),
    CommunityPost(
      id: 'p-2',
      author: 'Priya S.',
      gradeLabel: 'G1 - 84',
      strokeId: 'fh',
      caption: 'Forehand still flying long. Where am I late?',
      aiSummary: 'Replies agree the contact is late and the follow-through wraps too early.',
      feedbackCount: 4,
      filterTag: 'My team',
    ),
    CommunityPost(
      id: 'p-3',
      author: 'Luis M.',
      gradeLabel: 'G3 - 66',
      strokeId: 'bh',
      caption: 'Two-handed backhand, looking for spacing cues.',
      aiSummary: 'Feedback says the non-dominant hand is pulling off the racquet early.',
      feedbackCount: 6,
      filterTag: 'Following',
    ),
  ];

  final Challenge challenge = const Challenge(
    id: 'weekly-serve',
    title: 'Serve Consistency 100',
    description: 'Land 100 serves with a toss deviation under 8 in.',
    progress: 68,
    goal: 100,
    unit: 'serves',
    timeLeftLabel: '2d 04h left',
    topPercent: 12,
  );

  final List<LeaderboardEntry> leaderboard = const [
    LeaderboardEntry(name: 'Alex P.', points: 100, isYou: false),
    LeaderboardEntry(name: 'Sam R.', points: 94, isYou: false),
    LeaderboardEntry(name: 'You', points: 68, isYou: true),
    LeaderboardEntry(name: 'Jordan L.', points: 63, isYou: false),
  ];

  final List<MilestoneBadge> badges = const [
    MilestoneBadge(title: '500 SWINGS', unlocked: true),
    MilestoneBadge(title: '10-DAY STREAK', unlocked: true),
    MilestoneBadge(title: 'SERVE 90', unlocked: false),
  ];

  /// Train wizard selection. Steps: 0 choose, 1 record, 2 side-by-side, 3 recap.
  String selectedStrokeId = 'fh';
  int trainStep = 0;
  int phaseIndex = 0;
  int? focusSwingIndex;
  bool recordArmed = false;
  double previewSpeed = 1;
  bool previewFlipped = false;

  static const previewSpeeds = [1.0, 0.5, 0.25];

  int _localId = 0;

  Stroke get selectedStroke => strokeById(selectedStrokeId);

  int get totalSwings => 142;

  List<Swing> get recentSwings => swings.take(3).toList();

  Swing get comparisonSwing {
    final index = focusSwingIndex;
    if (index != null && index >= 0 && index < swings.length) return swings[index];
    return swings.firstWhere(
      (swing) => swing.strokeId == selectedStrokeId,
      orElse: () => swings.first,
    );
  }

  String get previewSpeedLabel {
    if (previewSpeed == 0.5) return '0.5x';
    if (previewSpeed == 0.25) return '0.25x';
    return '1x';
  }

  Stroke strokeById(String id) {
    return strokes.firstWhere((stroke) => stroke.id == id);
  }

  void selectStroke(String id) {
    if (selectedStrokeId == id) return;
    selectedStrokeId = id;
    phaseIndex = 0;
    notifyListeners();
  }

  void beginTrain({String? strokeId}) {
    if (strokeId != null) selectedStrokeId = strokeId;
    trainStep = 0;
    phaseIndex = 0;
    focusSwingIndex = null;
    recordArmed = false;
    previewSpeed = 1;
    previewFlipped = false;
    notifyListeners();
  }

  void openRecord() {
    trainStep = 1;
    phaseIndex = 0;
    recordArmed = false;
    notifyListeners();
  }

  void toggleRecord() {
    recordArmed = !recordArmed;
    notifyListeners();
  }

  void cycleSpeed() {
    final current = previewSpeeds.indexOf(previewSpeed);
    previewSpeed = previewSpeeds[(current + 1) % previewSpeeds.length];
    notifyListeners();
  }

  void toggleFlip() {
    previewFlipped = !previewFlipped;
    notifyListeners();
  }

  void openReview() {
    trainStep = 2;
    phaseIndex = 2;
    final index = swings.indexWhere((swing) => swing.strokeId == selectedStrokeId);
    focusSwingIndex = index < 0 ? 0 : index;
    notifyListeners();
  }

  void openComparison(String swingId) {
    final index = swings.indexWhere((swing) => swing.id == swingId);
    if (index < 0) return;
    focusSwingIndex = index;
    selectedStrokeId = swings[index].strokeId;
    trainStep = 2;
    phaseIndex = 2;
    notifyListeners();
  }

  void backTrainStep() {
    if (trainStep == 0) return;
    trainStep -= 1;
    notifyListeners();
  }

  void selectPhase(int index) {
    phaseIndex = index.clamp(0, selectedStroke.phases.length - 1);
    notifyListeners();
  }

  void nextSwing() {
    final current = focusSwingIndex ?? swings.indexWhere((swing) => swing.strokeId == selectedStrokeId);
    final next = (current + 1) % swings.length;
    focusSwingIndex = next;
    selectedStrokeId = swings[next].strokeId;
    phaseIndex = 2;
    notifyListeners();
  }

  void openRecap() {
    trainStep = 3;
    notifyListeners();
  }

  /// Scripted coach reply used until the OpenAI endpoint exists.
  void sendCoachMessage(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;
    _localId += 1;
    messages.add(CoachMessage(id: 'local-u-$_localId', fromCoach: false, text: trimmed));
    messages.add(
      CoachMessage(
        id: 'local-c-$_localId',
        fromCoach: true,
        strokeId: selectedStrokeId,
        text: _cannedReply(trimmed),
      ),
    );
    notifyListeners();
  }

  String _cannedReply(String text) {
    final lower = text.toLowerCase();
    if (lower.contains('drill')) {
      return recap.drill;
    }
    if (lower.contains('week') || lower.contains('compare')) {
      return 'Versus last week your average is up 6 points. Forehand contact is still the priority.';
    }
    if (lower.contains('14') || lower.contains('swing')) {
      return 'Swing 14: contact was 2.4 in behind the front hip and elbow extension was -24°.';
    }
    if (lower.contains('contact') || lower.contains('late') || lower.contains('elbow')) {
      return 'Contact is behind the front hip on most forehands. Meet the ball further in front and keep the elbow firm.';
    }
    return 'Start with this: ${recap.priorityFix}';
  }
}
