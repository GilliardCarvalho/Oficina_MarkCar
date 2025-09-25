import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'screens/login.dart';
import 'screens/home.dart';
import 'theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // iOS-style status bar (dark icons on light bg)
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Color(0x00000000),
  ));
  runApp(const AutoTechApp());
}

class AutoTechApp extends StatelessWidget {
  const AutoTechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'AutoTech',
      theme: appCupertinoTheme,
      home: const LoginScreen(),
      routes: {
        '/home': (_) => const HomeScreen(),
      },
    );
  }
}