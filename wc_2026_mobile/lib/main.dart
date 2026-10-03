import 'package:material_ui/material_ui.dart';
import 'package:wc_2026_mobile/ui/splash/splash_screen.dart';
import 'package:wc_2026_mobile/ui/welcome/welcome_screen.dart';

import 'ui/core/theme/app_theme.dart';

void main() {
  runApp(MainApp());
}

class const MainApp({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      title: 'World Cup 2026',
      home: WelcomeScreen(),
    );
  }
}
