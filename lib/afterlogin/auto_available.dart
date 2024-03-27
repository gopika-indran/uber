import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uberbooking_app/afterlogin/search_autolocation.dart';
import 'package:uberbooking_app/afterlogin/search_screen_car.dart';
import 'package:uberbooking_app/custom/textcustom.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Autoavailable extends StatefulWidget {
  const Autoavailable({super.key});

  @override
  State<Autoavailable> createState() => _AutoavailableState();
}

class _AutoavailableState extends State<Autoavailable> {
  double rating = 0;
  Future loadrating() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      rating = sharedPreferences.getDouble("rating") ?? 0;
    });
  }

  Future saverating(double rating) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setDouble("rating", rating);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadrating();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: textcustom(
          titletext: "AVAILABLE AUTOS ARE SHOWN BELLOW",
          colortext: Colors.white,
          size: 13,
          fontbold: FontWeight.bold,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("imageauto").snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.amberAccent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const CircularProgressIndicator(),
                  ),
                );
              },
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    width: 350,
                    height: 150,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 6,
                            offset: Offset(-3, 3))
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 25),
                          child: Column(
                            children: [
                              textcustom(
                                  titletext:
                                      snapshot.data!.docs[index].get("company"),
                                  colortext: Colors.black,
                                  size: 15),
                              textcustom(
                                  titletext:
                                      snapshot.data!.docs[index].get("price"),
                                  colortext: Colors.black,
                                  size: 15),
                              RatingBar.builder(
                                itemSize: 20,
                                initialRating: rating,
                                updateOnDrag: true,
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (value) {
                                  setState(() {
                                    rating = value;
                                    saverating(rating);
                                  });
                                },
                              ),
                              textcustom(
                                titletext: "Rating: $rating",
                                colortext: Colors.black,
                                size: 10,
                                fontbold: FontWeight.bold,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SearchAutoloc(
                                                              docid: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .id
                                                                  .toString(),
                                                            )));
                                              },
                                              child: textcustom(
                                                  titletext: "Yes",
                                                  colortext: Colors.black,
                                                  size: 16)),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: textcustom(
                                                  titletext: "Cancel",
                                                  colortext: Colors.black,
                                                  size: 16))
                                        ],
                                        title: const Text("Booking car"),
                                        contentPadding:
                                            const EdgeInsets.all(18),
                                        content: const Text(
                                            "Are you sure you want to book this auto for your travel?"),
                                      ),
                                    );
                                  },
                                  child: textcustom(
                                      titletext: "Book Now",
                                      colortext: Colors.black,
                                      size: 15))
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              width: 80,
                              height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        snapshot.data!.docs[index].get("url"))),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: const Icon(Icons.error),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
