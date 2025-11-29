import 'package:flutter/material.dart';
import 'package:family_invitation/screens/boarding_pass_screen.dart';
import 'package:family_invitation/designs/theme.dart';

void main() async {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '채은 & 종우 결혼해요',
      themeMode: ThemeMode.system,
      theme: lightModeTheme,
      darkTheme: darkModeTheme,
      home: const BoardingPassScreen(),
    );
  }
}
