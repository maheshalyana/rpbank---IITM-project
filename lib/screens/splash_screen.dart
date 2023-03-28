import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:rpbank/utils/tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/language_provider.dart';
import 'auth/login.dart';
import 'home_screen.dart';
import 'language.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(milliseconds: 500), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? language = prefs.getString("language");
      if (prefs.getString("language") != null) {
        if (prefs.getBool("login") != null && prefs.getBool("login")!) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false);
        }
      } else {
        TextToSpeech.initTTS(language);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LanguageScreen()),
            (route) => false);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/logo.png"),
      ),
    );
  }
}
