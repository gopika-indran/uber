import 'package:flutter/material.dart';

class forgetpage extends StatefulWidget {
  const forgetpage({super.key});

  @override
  State<forgetpage> createState() => _forgetpageState();
}

class _forgetpageState extends State<forgetpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/lock1.png",
              alignment: Alignment.center,
              width: 200,
              height: 200,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "FORGOT PASSWORD",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      )),
    );
  }
}
