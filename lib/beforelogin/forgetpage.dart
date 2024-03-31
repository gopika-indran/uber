import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uberbooking_app/custom/textcustom.dart';
import 'package:uberbooking_app/custom/textformfield_cust.dart';

class forgetpage extends StatefulWidget {
  const forgetpage({super.key});

  @override
  State<forgetpage> createState() => _forgetpageState();
}

class _forgetpageState extends State<forgetpage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  bool isvisible = true;
  @override
  void dispose() {
    emailcontroller.dispose();
    super.dispose();
  }

  Future passwordreset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailcontroller.text.trim());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text("password reset link sent! Check your email"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: textcustom(
                      titletext: "ok", colortext: Colors.blue, size: 18))
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: textcustom(
                      titletext: "ok", colortext: Colors.blue, size: 18))
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
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
              height: 10,
            ),
            const Text(
              "FORGOT PASSWORD",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            cust_textformfield(
              keyboad: TextInputType.emailAddress,
              command: "enter email id",
              command2: "enter proper way of email",
              controller: emailcontroller,
              label: "email",
              preicon: const Icon(Icons.email),
            ),
            ElevatedButton(
                onPressed: () {
                  passwordreset();
                },
                child: textcustom(
                    titletext: "Reset Password",
                    colortext: Colors.black,
                    size: 20))
          ],
        ),
      )),
    );
  }
}
