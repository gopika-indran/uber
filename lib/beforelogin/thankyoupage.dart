import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:uberbooking_app/beforelogin/login.dart';

class thankyoupage extends StatefulWidget {
  const thankyoupage({super.key});

  @override
  State<thankyoupage> createState() => _thankyoupageState();
}

class _thankyoupageState extends State<thankyoupage> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2)).whenComplete(
      () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const loginpage(),
          )),
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
            Image.asset(
              "assets/thanku.png",
              alignment: Alignment.center,
              width: 200,
              height: 200,
            )
          ],
        ),
      ),
    );
  }
}
