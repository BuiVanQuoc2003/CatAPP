import 'package:catapp/feature/auth/signin_page.dart';
import 'package:flutter/material.dart';

import 'config/theme.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: const SignInPage(),
    );
  }
}
