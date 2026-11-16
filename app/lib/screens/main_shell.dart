import 'package:material_ui/material_ui.dart';
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

  static const _destinations = [
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
  ];

  @override
  Widget build(BuildContext context) {
    final shell = context.watch<ShellController>();
    return Scaffold(
      body: IndexedStack(
        index: shell.index,
        children: const [
          HomeScreen(),
          TrainScreen(),
          CoachScreen(),
          CommunityScreen(),
          MeScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.index,
        onDestinationSelected: shell.select,
        destinations: _destinations,
      ),
    );
  }
}
