import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uberbooking_app/admin_screens/car_collection.dart';
import 'package:uberbooking_app/afterlogin/availablecar_user.dart';
import 'package:uberbooking_app/custom/textcustom.dart';
import 'package:uberbooking_app/custom/textformfield_cust.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class Showupdatepage extends StatefulWidget {
  const Showupdatepage({super.key});

  @override
  State<Showupdatepage> createState() => _ShowupdatepageState();
}

class _ShowupdatepageState extends State<Showupdatepage> {
  List<File> image = [];
  CollectionReference? imgref;
  Reference? ref;
  File? imagefile;
  List<String> imageurl = [];
  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imgref = FirebaseFirestore.instance.collection("imageurl");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: textcustom(
                  titletext: "Adding car", colortext: Colors.white, size: 23),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const carcollection()));
                },
                child: textcustom(
                    titletext: "SAVE", colortext: Colors.white, size: 14))
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              cust_textformfield(
                command: "enter",
                command2: "enter",
                obscuretext: false,
                controller: namecontroller,
                label: "car name",
                keyboad: TextInputType.name,
              ),
              const SizedBox(
                height: 10,
              ),
              cust_textformfield(
                  controller: pricecontroller,
                  label: "10km rate",
                  command: "enter",
                  command2: "enter",
                  keyboad: TextInputType.name),
              textcustom(
                titletext: "Add Car image",
                colortext: Colors.black,
                size: 17,
                fontbold: FontWeight.bold,
              ),
              Expanded(
                  child: GridView.builder(
                itemCount: image.length + 1,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return index == 0
                      ? Center(
                          child: IconButton(
                              onPressed: () async {
                                var img = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                imagefile = File(img!.path);

                                setState(() {
                                  image.add(imagefile!);
                                });
                                String uuid = const Uuid().v4();

                                var reference = await FirebaseStorage.instance
                                    .ref()
                                    .child("storeimage/$uuid.jpg")
                                    .putFile(imagefile!);
                                var imgurl = await reference.ref
                                    .getDownloadURL()
                                    .then((value) => imgref!.add({
                                          "url": value,
                                          "company": namecontroller.text,
                                          "price": pricecontroller.text,
                                        }));

                                print(imgurl);
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Colors.black,
                              )),
                        )
                      : Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(image[index - 1]),
                            ),
                          ),
                        );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
