import 'dart:io';

import 'package:filmophile/shared/shared.dart';
import 'package:filmophile/ui/pages/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() async{
  enablePlatformOverrideForDesktop();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Filmophile",
      theme: MyTheme.lightTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        Splash.routeName : (context) => Splash(),
        Login.routeName : (context) => Login(),
        MainMenu.routeName : (context) => MainMenu(),
        Register.routeName : (context) => Register(),
        // DetailMovie.routeName : (context) => DetailMovie(),
        // 'menu': (context) => Menu(),
        // History.routeName: (context) => History(),
      },
    );
  }
}
