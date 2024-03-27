import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uberbooking_app/afterlogin/curved_navigation_bar.dart';
import 'package:uberbooking_app/beforelogin/welcomepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  bool? userloged;
  void checklogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userloged = sharedPreferences.getBool("login");
    if (userloged == false || userloged == null) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const welcomepage()));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const motiontabbar()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4)).whenComplete(() => checklogin());
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: LottieBuilder.asset(
              "assets/ubar.json",
              height: 280,
            ),
          ),
          AnimatedTextKit(animatedTexts: [
            TypewriterAnimatedText("Yathra Uber App",
                textStyle:
                    GoogleFonts.pacifico(color: Colors.brown, fontSize: 30))
          ])
        ],
      )),
    );
  }
}
