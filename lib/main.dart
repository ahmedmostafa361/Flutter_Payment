import 'package:flutter/material.dart';
import 'package:food_discovery_flutter/UI/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.homeScreenRoute,
      routes: {
        HomeScreen.homeScreenRoute : (context) => HomeScreen()
      },
    );
  }
}