import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/splash_screen.dart';
// import 'package:flutter_application_1/page/program_latihan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // <- ini yang benar
    );
  }
}
