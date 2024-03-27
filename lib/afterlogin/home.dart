import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uberbooking_app/afterlogin/profile_user.dart';
import 'package:uberbooking_app/afterlogin/search_screen_car.dart';
import 'package:uberbooking_app/afterlogin/service_page.dart';
import 'package:uberbooking_app/custom/textcustom.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;
  LatLng? _currentPosition;
  String name = "";
  String email = "";
  FirebaseAuth auth = FirebaseAuth.instance;
  late User? _username;

  void getdetails() async {
    _username = FirebaseAuth.instance.currentUser;
    if (_username != null) {
      fetchdetails();
    }
  }

  void fetchdetails() async {
    DocumentSnapshot usersnapshort = await FirebaseFirestore.instance
        .collection("Mydatabase")
        .doc(_username!.uid)
        .get();
    setState(() {
      name = usersnapshort["name"];
      email = usersnapshort["email"];
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    getdetails();
    fetchdetails();
  }

  void _getCurrentLocation() async {
    bool serviceenable = await Geolocator.isLocationServiceEnabled();
    if (serviceenable) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever ||
            permission == LocationPermission.denied) {
          return;
        }
      }
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        setState(() {
          _currentPosition = LatLng(position.altitude, position.longitude);
        });
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("please enable location services to continue"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"))
            ],
          );
        },
      );
    }
  }

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  double bottompaddingofmap = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 127, 206, 243),
          title: const Text("Yathra Uber app"),
        ),
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 127, 206, 243),
          child: ListView(
            children: [
              SizedBox(
                height: 130,
                child: DrawerHeader(
                  child: Row(
                    children: [
                      Image.asset("assets/images/user_icon.png"),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          textcustom(
                              titletext: email,
                              colortext: Colors.black,
                              size: 15)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const ListTile(
                leading: Icon(Icons.history),
                title: Text("HISTORY"),
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  const Icon(Icons.person),
                  const SizedBox(
                    width: 27,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileUser(),
                            ));
                      },
                      child: textcustom(
                          titletext: "Visit Profile",
                          colortext: Colors.black,
                          size: 16)),
                ],
              ),
              const ListTile(
                leading: Icon(Icons.info),
                title: Text("INFORMATIONS"),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _getCurrentLocation();
          },
          child: const Icon(Icons.my_location),
        ),
        body: SafeArea(
            child: Stack(
          children: [
            GoogleMap(
              padding: EdgeInsets.only(bottom: bottompaddingofmap),
              mapType: MapType.normal,
              markers: {
                if (_currentPosition != null)
                  Marker(
                      markerId: const MarkerId("current_location"),
                      position: _currentPosition!,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueRed))
              },
              myLocationButtonEnabled: false,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              myLocationEnabled: true,
              initialCameraPosition: kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controllerGoogleMap.complete(controller);
                newGoogleMapController = controller;
                setState(() {
                  bottompaddingofmap = 300;
                });
                // _getCurrentLocation();
              },
            ),
            Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                    height: 300,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 10,
                          )
                        ]),
                    child: Column(children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "WHERE TO GO?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: GestureDetector(
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: const Text(
                                  "You have to choose your vehicle first"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ServicePage(),
                                          ));
                                    },
                                    child: textcustom(
                                        titletext: "ok",
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
                            ),
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 4,
                                  )
                                ]),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.search),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Search your destination",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.home),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Add home",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("Your living home address")
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(17.0),
                        child: Divider(
                          height: 1,
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.work),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Add work",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text("Your office address")
                              ],
                            ),
                          ],
                        ),
                      ),
                    ])))
          ],
        )));
  }
}
