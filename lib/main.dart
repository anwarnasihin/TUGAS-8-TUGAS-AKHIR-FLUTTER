import 'package:finalproject/about_me.dart';
import 'package:finalproject/aplikasi.dart';
import 'package:finalproject/home.dart';
import 'package:finalproject/login.dart';
import 'package:finalproject/register.dart';
import 'package:finalproject/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
