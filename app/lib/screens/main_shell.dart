import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rallyloop/screens/coach_screen.dart';
import 'package:rallyloop/screens/community_screen.dart';
import 'package:rallyloop/screens/home_screen.dart';
import 'package:rallyloop/screens/me_screen.dart';
import 'package:rallyloop/screens/train_screen.dart';

class ShellController extends ChangeNotifier {
  int index = 0;

  void select(int value) {
    if (value == index) return;
    index = value;
    notifyListeners();
  }
}

class MainShell extends StatelessWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context) {
    final shell = context.watch<ShellController>();
    return Scaffold(
      body: switch (shell.index) {
        0 => const HomeScreen(),
        1 => const TrainScreen(),
        2 => const CoachScreen(),
        3 => const CommunityScreen(),
        _ => const MeScreen(),
      },
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.index,
        onDestinationSelected: shell.select,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(
            icon: Icon(Icons.sports_tennis_outlined),
            selectedIcon: Icon(Icons.sports_tennis),
            label: 'Train',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: 'Coach',
          ),
          NavigationDestination(
            icon: Icon(Icons.groups_outlined),
            selectedIcon: Icon(Icons.groups),
            label: 'Community',
          ),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Me'),
        ],
      ),
    );
  }
}
