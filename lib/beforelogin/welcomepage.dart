import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uberbooking_app/beforelogin/login.dart';
import 'package:uberbooking_app/beforelogin/signup.dart';
import 'package:cached_network_image/cached_network_image.dart';

class welcomepage extends StatefulWidget {
  const welcomepage({super.key});

  @override
  State<welcomepage> createState() => _welcomepageState();
}

class _welcomepageState extends State<welcomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          "https://i.iheart.com/v3/re/new_assets/5ea0b7df5270ed94262c4dd5"),
                      fit: BoxFit.cover)),
            ),
            Positioned(
                top: 40,
                left: 70,
                child: Text(
                  "WELCOME TO \n    YATHRA UBER APP",
                  style: GoogleFonts.oswald(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
            Positioned(
                bottom: 0,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const loginpage(),
                            ));
                      },
                      child: Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                        ),
                        child: const Center(
                          child: Text(
                            "Login page",
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const signuppage(),
                            ));
                      },
                      child: Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: const Center(
                          child: Text(
                            "Signin page",
                            style: TextStyle(color: Colors.black, fontSize: 24),
                          ),
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      )),
    );
  }
}
