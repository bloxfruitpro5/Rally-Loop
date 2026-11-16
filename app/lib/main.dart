import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:rallyloop/data/mock_data.dart';
import 'package:rallyloop/screens/main_shell.dart';
import 'package:rallyloop/theme/app_theme.dart';

void main() {
  runApp(const RallyLoopApp());
}

class RallyLoopApp extends StatelessWidget {
  const RallyLoopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ShellController()),
        ChangeNotifierProvider(create: (_) => MockData()),
      ],
      child: MaterialApp(
        title: 'RallyLoop',
        debugShowCheckedModeBanner: false,
        theme: buildAppTheme(),
        home: const MainShell(),
      ),
    );
  }
}
