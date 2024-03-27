import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uberbooking_app/admin_screens/admin_home.dart';
import 'package:uberbooking_app/admin_screens/curveditems_admin.dart';
import 'package:uberbooking_app/afterlogin/home.dart';
import 'package:uberbooking_app/afterlogin/curved_navigation_bar.dart';
import 'package:uberbooking_app/beforelogin/adminid_class.dart';
import 'package:uberbooking_app/beforelogin/forgetpage.dart';
import 'package:uberbooking_app/beforelogin/signup.dart';
import 'package:uberbooking_app/custom/textformfield_cust.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isvisible = true;
  void storelogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("login", true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
            key: formkey,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2.3,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(color: Colors.white),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2.3,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(95)),
                        color: Colors.blueAccent),
                    child: Image.asset(
                      "assets/taxiimg.png",
                      scale: 0.8,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.8,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(color: Colors.blue),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.80,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(65)),
                          color: Colors.white),
                      child: Column(
                        children: [
                          Text(
                            "Login Page",
                            style: GoogleFonts.oswald(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 1, left: 10, right: 10),
                            child: cust_textformfield(
                              keyboad: TextInputType.emailAddress,
                              command: "enter email id",
                              command2: "enter proper way of email",
                              controller: emailcontroller,
                              label: "email",
                              preicon: const Icon(Icons.email),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 1, left: 10, right: 10),
                            child: cust_textformfield(
                              keyboad: TextInputType.name,
                              command: "enter password",
                              command2: "enter strong password",
                              controller: passcontroller,
                              label: "password",
                              obscuretext: isvisible,
                              preicon: const Icon(Icons.lock),
                              suffics: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isvisible = !isvisible;
                                    });
                                  },
                                  icon: Icon(isvisible
                                      ? Icons.visibility_off
                                      : Icons.visibility)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 180),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const forgetpage(),
                                      ));
                                },
                                child: const Text("FORGET PASSWORD?")),
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black)),
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  loginauth(
                                      email: emailcontroller.text,
                                      password: passcontroller.text,
                                      context: context);
                                }
                                storelogin();
                              },
                              child: const Text("LOGIN")),
                          Row(
                            children: [
                              const Text("Do not have an account?"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const signuppage(),
                                        ));
                                  },
                                  child: const Text("Register Here")),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  Future loginauth(
      {required email, required password, required context}) async {
    try {
      final ref = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = ref.user;

      if (user!.uid == Myconstants().adminid) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Curveditems()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const motiontabbar()));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "unkown user", backgroundColor: Colors.red);
    }
  }
}
