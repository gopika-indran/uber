import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uberbooking_app/afterlogin/splach_bookconfirm.dart';
import 'package:uberbooking_app/custom/textcustom.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.docid});
  final String docid;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // TimeOfDay selectedtime = TimeOfDay.now();

  FirebaseAuth auth = FirebaseAuth.instance;
  late User? _currentuser;
  String email = "";
  String name = "";

  void getdetail() async {
    _currentuser = FirebaseAuth.instance.currentUser;
    if (_currentuser != null) {
      fetdetails();
    }
  }

  void fetdetails() async {
    DocumentSnapshot usersnapshort = await FirebaseFirestore.instance
        .collection("Mydatabase")
        .doc(_currentuser!.uid)
        .get();
    setState(() {
      email = usersnapshort["email"];
      name = usersnapshort["name"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdetail();
  }

  void pickupaddress() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemark =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      setState(() {
        pickupcontroller.text =
            '${placemark.first.subAdministrativeArea}, ${placemark.first.country}';
      });
    } catch (e) {}
  }

  TextEditingController pickupcontroller = TextEditingController();
  TextEditingController togocontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SafeArea(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("imageurl")
                .doc(widget.docid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                return Container(
                  height: 290,
                  decoration:
                      const BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Colors.black,
                    )
                  ]),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back)),
                          const Center(
                            child: Text(
                              "Set Drop Off",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Image.asset(
                              "assets/images/pickicon.png",
                              height: 35,
                              width: 21,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                              child: Padding(
                            padding:
                                const EdgeInsets.only(right: 15, bottom: 5),
                            child: TextField(
                              controller: pickupcontroller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                hintText: "Pickup Location",
                              ),
                            ),
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Image.asset(
                              "assets/images/desticon.png",
                              height: 35,
                              width: 21,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                              child: Padding(
                            padding:
                                const EdgeInsets.only(right: 15, bottom: 5),
                            child: TextField(
                              controller: togocontroller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                hintText: "Where to go?",
                              ),
                            ),
                          )),
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     const SizedBox(
                      //       width: 70,
                      //     ),
                      //     ElevatedButton(
                      //         onPressed: () async {
                      //           final TimeOfDay? timeOfDay =
                      //               await showTimePicker(
                      //                   context: context,
                      //                   initialTime: selectedtime,
                      //                   initialEntryMode:
                      //                       TimePickerEntryMode.dial);
                      //           if (timeOfDay != null) {
                      //             setState(() {
                      //               selectedtime = timeOfDay;
                      //             });
                      //           }
                      //         },
                      //         child: textcustom(
                      //             titletext: "Pick Up Time",
                      //             colortext: Colors.black,
                      //             size: 18)),
                      //     const SizedBox(
                      //       width: 20,
                      //     ),
                      //     Text("${selectedtime.hour}:${selectedtime.minute}")
                      //   ],
                      // ),
                      ElevatedButton(
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                  const Size(300, 35))),
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection("bookdetails")
                                .doc(widget.docid)
                                .set({
                              "email": email,
                              "username": name,
                              "company": snapshot.data!["company"].toString(),
                              "price": snapshot.data!["price"].toString(),
                              // "pickup time": selectedtime,
                              "pickup location": pickupcontroller.text,
                              "destination": togocontroller.text
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const confirmorder(),
                                ));
                          },
                          child: textcustom(
                              titletext: "Book Taxi",
                              colortext: Colors.black,
                              size: 18))
                    ],
                  ),
                );
              } else {
                return const Text("no data");
              }
            },
          ),
        ),
      ),
    );
  }
}
