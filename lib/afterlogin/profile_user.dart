import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uberbooking_app/beforelogin/login.dart';
import 'package:uberbooking_app/beforelogin/welcomepage.dart';
import 'package:uberbooking_app/custom/textcustom.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser({super.key});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  TextEditingController namecontroller = TextEditingController();
  File? imagefile;
  FirebaseAuth auth = FirebaseAuth.instance;
  late User? _currentuser;
  String name = "";
  String email = "";
  String number = "";
  bool isuploading = false;
  String imageurl = "";

  void getdetails() async {
    _currentuser = FirebaseAuth.instance.currentUser;
    if (_currentuser != null) {
      fetchdetails();
    }
  }

  void fetchdetails() async {
    DocumentSnapshot usersnapshort = await FirebaseFirestore.instance
        .collection("Mydatabase")
        .doc(_currentuser!.uid)
        .get();
    setState(() {
      name = usersnapshort["name"];
      email = usersnapshort["email"];
      number = usersnapshort["number"];
      imageurl = usersnapshort["url"];
    });
  }

  void store() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("login", false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdetails();
    fetchdetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 181, 220, 239),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:
            textcustom(titletext: "PROFILE", colortext: Colors.black, size: 15),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 120),
                child: Stack(
                  children: [
                    imageurl.isNotEmpty
                        ? CircleAvatar(
                            radius: 55,
                            backgroundImage: NetworkImage(imageurl),
                          )
                        : const CircleAvatar(
                            radius: 55,
                            backgroundImage: NetworkImage(
                                "https://thumbs.dreamstime.com/b/default-avatar-profile-flat-icon-social-media-user-vector-portrait-unknown-human-image-default-avatar-profile-flat-icon-184330869.jpg"),
                          ),
                    Positioned(
                      top: 55,
                      left: 70,
                      child: IconButton(
                          onPressed: () async {
                            var img = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            imagefile = File(img!.path);
                            String uuid = const Uuid().v4();
                            var reference = await FirebaseStorage.instance
                                .ref()
                                .child("storeimage/$uuid.jpg")
                                .putFile(imagefile!);
                            var imgurl = await reference.ref
                                .getDownloadURL()
                                .then((value) => FirebaseFirestore.instance
                                    .collection("Mydatabase")
                                    .doc(_currentuser!.uid)
                                    .update({"url": value}));
                          },
                          icon: const Icon(Icons.photo_camera)),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              textcustom(
                titletext: "Username",
                colortext: Colors.white,
                size: 17,
                fontbold: FontWeight.bold,
              ),
              const SizedBox(
                height: 10,
              ),
              textcustom(titletext: name, colortext: Colors.black, size: 13),
              const SizedBox(
                height: 20,
              ),
              textcustom(
                titletext: "Email",
                colortext: Colors.white,
                size: 17,
                fontbold: FontWeight.bold,
              ),
              const SizedBox(
                height: 10,
              ),
              textcustom(titletext: email, colortext: Colors.black, size: 13),
              const SizedBox(
                height: 20,
              ),
              textcustom(
                titletext: "Phone number",
                colortext: Colors.white,
                size: 17,
                fontbold: FontWeight.bold,
              ),
              const SizedBox(
                height: 10,
              ),
              textcustom(titletext: number, colortext: Colors.black, size: 13),
              const SizedBox(
                height: 15,
              ),
              TextButton(
                  onPressed: () {
                    store();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const loginpage(),
                        ));
                  },
                  child: textcustom(
                    titletext: "LOG OUT YOUR ACCOUNT",
                    colortext: const Color.fromARGB(255, 2, 83, 149),
                    size: 15,
                    fontbold: FontWeight.bold,
                  )),
              TextButton(
                  onPressed: () async {
                    try {
                      _currentuser = FirebaseAuth.instance.currentUser;
                      await _currentuser!.delete();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const welcomepage(),
                          ));
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: textcustom(
                    titletext: "Delect your account",
                    colortext: Colors.red,
                    size: 17,
                    fontbold: FontWeight.bold,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
