import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uberbooking_app/beforelogin/login.dart';
import 'package:uberbooking_app/beforelogin/thankyoupage.dart';
import 'package:uberbooking_app/custom/textformfield_cust.dart';

class signuppage extends StatefulWidget {
  const signuppage({super.key});

  @override
  State<signuppage> createState() => _signuppageState();
}

class _signuppageState extends State<signuppage> {
  final String urllink =
      "https://th.bing.com/th/id/OIP.eDfds46iXzl6qTA5yVkRJAHaHG?rs=1&pid=ImgDetMain";
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController numbercontroller = TextEditingController();
  bool isvisible = true;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Future authsigup(
      {required email,
      required password,
      required name,
      required number,
      required String urllink,
      required BuildContext context}) async {
    try {
      var ref = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      var docid = ref.user!.uid.toString();
      var data = {
        "email": email,
        "password": password,
        "name": name,
        "number": number,
        "url": urllink
      };
      var dbref = await FirebaseFirestore.instance
          .collection("Mydatabase")
          .doc(docid)
          .set(data);
      Fluttertoast.showToast(msg: "success");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const thankyoupage(),
          ));
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.code);
    } catch (e) {
      Fluttertoast.showToast(msg: "error");
    }
  }

  Future databasestore(email, password, name, number, docid) async {
    var data = {
      "email": email,
      "password": password,
      "name": name,
      "number": number,
      "url": urllink
    };
    var dbref = await FirebaseFirestore.instance
        .collection("Mydatabase")
        .doc(docid)
        .set(data);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: formkey,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://cdn.neowin.com/news/images/uploaded/2016/10/1475325726_uber-logo.jpg"),
                          fit: BoxFit.cover)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 1.8,
                        width: MediaQuery.of(context).size.height / 1.9,
                        decoration: BoxDecoration(
                            color: Colors.lightBlue.withOpacity(0.5),
                            boxShadow: const [BoxShadow(blurRadius: 10)],
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Text(
                              "Sign Up Page",
                              style: GoogleFonts.oswald(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            cust_textformfield(
                                keyboad: TextInputType.name,
                                command: "enter your name",
                                command2: "enter your full name",
                                controller: namecontroller,
                                label: "Enter your name",
                                preicon: const Icon(Icons.person)),
                            cust_textformfield(
                                keyboad: TextInputType.emailAddress,
                                command: "enter your email",
                                command2: "enter proper email id",
                                controller: emailcontroller,
                                label: "Enter your email",
                                preicon: const Icon(Icons.email)),
                            cust_textformfield(
                                keyboad: TextInputType.phone,
                                command: "enter your phone number",
                                command2: "enter valid number",
                                controller: numbercontroller,
                                label: "Enter your number",
                                preicon: const Icon(Icons.phone)),
                            cust_textformfield(
                                keyboad: TextInputType.name,
                                command: "emter your password",
                                command2: "enter a strong password",
                                // suffics: IconButton(
                                //     onPressed: () {
                                //       setState(() {
                                //         isvisible = !isvisible;
                                //       });
                                //     },
                                //     icon: Icon(isvisible
                                //         ? Icons.visibility_off
                                //         : Icons.visibility)),
                                controller: passcontroller,
                                label: "Enter your password",
                                preicon: const Icon(Icons.lock)),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.black)),
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    authsigup(
                                        urllink: urllink,
                                        email: emailcontroller.text,
                                        password: passcontroller.text,
                                        name: namecontroller.text,
                                        number: numbercontroller.text,
                                        context: context);
                                  } else {
                                    "something went wrong";
                                  }
                                },
                                child: const Text("signup")),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "ALREADY HAVE AN ACCOUNT?",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const loginpage(),
                                          ));
                                    },
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
