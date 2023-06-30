import 'package:browser_app/controller/connectivity_controller.dart';
import 'package:browser_app/screen/Home_page.dart';
import 'package:browser_app/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {

  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => ConnectivityProvider(),
          ),
        ],
      builder: (context,_) {
        return MaterialApp(
            theme: ThemeData.light(useMaterial3: true),
            darkTheme: ThemeData.dark(useMaterial3: true),
            themeMode: ThemeMode.system,
            debugShowCheckedModeBanner: false,
            routes: {
              '/': (context) => const Splash_Screen(),
              'homepage': (context) => const Home_Page(),
            },
        );
      },
    ),
  );
}