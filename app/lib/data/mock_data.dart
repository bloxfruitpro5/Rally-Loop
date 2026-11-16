import 'package:flutter/foundation.dart';
import 'package:rallyloop/models/challenge.dart';
import 'package:rallyloop/models/coach_message.dart';
import 'package:rallyloop/models/community_post.dart';
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
    streakDays: 6,
    questionPoints: 42,
    techniqueScore: 78,
  );

  final List<Stroke> strokes = const [
    Stroke(id: 'fh', name: 'Forehand', shortLabel: 'FH', phases: _phases),
    Stroke(id: 'bh', name: 'Backhand', shortLabel: 'BH', phases: _phases),
    Stroke(id: 'serve', name: 'Serve', shortLabel: 'Serve', phases: _phases),
    Stroke(id: 'return', name: 'Return', shortLabel: 'Return', phases: _phases),
  ];

  final List<StrokeScore> strokeScores = const [
    StrokeScore(strokeId: 'fh', shortLabel: 'FH', score: 84),
    StrokeScore(strokeId: 'bh', shortLabel: 'BH', score: 71),
    StrokeScore(strokeId: 'serve', shortLabel: 'Serve', score: 66),
    StrokeScore(strokeId: 'return', shortLabel: 'Return', score: 79),
  ];

  final List<Swing> swings = [
    Swing(
      id: 'sw-1',
      strokeId: 'fh',
      matchPercent: 91,
      recordedAt: DateTime(2026, 11, 15, 16, 40),
      largestDeviation: 'Late contact',
      largestDeviationDetail: 'Contact is 18° late versus the reference forehand.',
      metrics: const [
        JointMetric(joint: 'Elbow', deltaDegrees: 12),
        JointMetric(joint: 'Wrist', deltaDegrees: 18),
        JointMetric(joint: 'Shoulder', deltaDegrees: 6),
        JointMetric(joint: 'Hip', deltaDegrees: -4),
      ],
    ),
    Swing(
      id: 'sw-2',
      strokeId: 'bh',
      matchPercent: 74,
      recordedAt: DateTime(2026, 11, 15, 16, 28),
      largestDeviation: 'Short backswing',
      largestDeviationDetail: 'The backhand takeback stops 14° short of the reference.',
      metrics: const [
        JointMetric(joint: 'Elbow', deltaDegrees: -14),
        JointMetric(joint: 'Wrist', deltaDegrees: 5),
        JointMetric(joint: 'Shoulder', deltaDegrees: -9),
      ],
    ),
    Swing(
      id: 'sw-3',
      strokeId: 'serve',
      matchPercent: 66,
      recordedAt: DateTime(2026, 11, 14, 18, 5),
      largestDeviation: 'Toss too far forward',
      largestDeviationDetail: 'Trophy pose is 21° closed and the toss lands in front of the front foot.',
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
    swingCount: 8,
    avgMatch: 74,
    bestMatch: 91,
    priorityFix: 'Late contact on the forehand — the racquet face opens through the ball.',
    drill: 'Shadow 10 forehands and freeze at contact, then hit 20 live feeds out in front.',
    matchScores: [62, 68, 71, 74, 70, 81, 88, 91],
  );

  final List<CoachMessage> messages = [
    const CoachMessage(
      id: 'c-1',
      fromCoach: true,
      strokeId: 'fh',
      text: 'Your last session averaged 74%. The biggest leak is late contact on the forehand.',
    ),
    const CoachMessage(
      id: 'c-2',
      fromCoach: false,
      text: 'What should I fix first?',
    ),
    const CoachMessage(
      id: 'c-3',
      fromCoach: true,
      strokeId: 'fh',
      text: 'Meet the ball out in front and keep the racquet face square through contact.',
    ),
  ];

  final List<String> suggestionChips = const [
    'Why is my contact late?',
    'Give me a drill',
    'Compare to last week',
  ];

  final List<String> communityFilters = const ['All', 'Forehand', 'Backhand', 'Serve', 'Return'];

  final List<CommunityPost> posts = const [
    CommunityPost(
      id: 'p-1',
      author: 'Jordan',
      strokeId: 'fh',
      caption: 'Forehand still flying long. Where am I late?',
      aiSummary: 'Replies agree the contact is late and the follow-through wraps too early.',
      feedbackCount: 4,
      filterTag: 'Forehand',
    ),
    CommunityPost(
      id: 'p-2',
      author: 'Priya',
      strokeId: 'serve',
      caption: 'Trophy pose feels cramped on second serves.',
      aiSummary: 'Teammates flagged a low elbow and a toss that drifts forward.',
      feedbackCount: 2,
      filterTag: 'Serve',
    ),
    CommunityPost(
      id: 'p-3',
      author: 'Luis',
      strokeId: 'bh',
      caption: 'Two-handed backhand, looking for spacing cues.',
      aiSummary: 'Feedback says the non-dominant hand is pulling off the racquet early.',
      feedbackCount: 6,
      filterTag: 'Backhand',
    ),
  ];

  final Challenge challenge = const Challenge(
    id: 'weekly-serve',
    title: 'Weekly serve challenge',
    description: 'Land 20 serves at 70% match or better.',
    progress: 12,
    goal: 20,
    unit: 'serves',
  );

  final List<LeaderboardEntry> leaderboard = const [
    LeaderboardEntry(name: 'Priya', points: 61, isYou: false),
    LeaderboardEntry(name: 'Maya', points: 42, isYou: true),
    LeaderboardEntry(name: 'Jordan', points: 37, isYou: false),
    LeaderboardEntry(name: 'Luis', points: 29, isYou: false),
  ];

  final List<MilestoneBadge> badges = const [
    MilestoneBadge(title: 'First session', unlocked: true),
    MilestoneBadge(title: '5-day streak', unlocked: true),
    MilestoneBadge(title: '80% serve', unlocked: false),
  ];

  int _localId = 0;

  Stroke strokeById(String id) {
    return strokes.firstWhere((stroke) => stroke.id == id);
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
        strokeId: 'fh',
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
    if (lower.contains('contact') || lower.contains('late')) {
      return 'Contact is about 18° late. Pause at the hit and meet the ball in front of your front hip.';
    }
    return 'Start with this: ${recap.priorityFix}';
  }
}
