import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:uberbooking_app/afterlogin/curved_navigation_bar.dart';
import 'package:uberbooking_app/beforelogin/login.dart';

class confirmorder extends StatefulWidget {
  const confirmorder({super.key});

  @override
  State<confirmorder> createState() => _confirmorderState();
}

class _confirmorderState extends State<confirmorder> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2)).whenComplete(
      () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const motiontabbar())),
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: LottieBuilder.asset(
                "assets/tick.json",
                height: 170,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
