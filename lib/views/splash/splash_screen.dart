import 'dart:async';

import 'package:final_project/views/onboarding/onboarding_page.dart';
import 'package:final_project/views/widgets/botnavbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashscreenStart();
  }

  splashscreenStart() async {
    final pref = await SharedPreferences.getInstance();
    var duration = const Duration(seconds: 3);
    return Timer(
      duration,
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => pref.getString('token') != null
                ? const BotNavBar()
                : const OnboardingPage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",
            ),
          ],
        ),
      ),
    );
  }
}
