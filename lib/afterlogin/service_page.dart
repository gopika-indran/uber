import 'package:flutter/material.dart';
import 'package:uberbooking_app/admin_screens/add_bike.dart';
import 'package:uberbooking_app/afterlogin/auto_available.dart';
import 'package:uberbooking_app/afterlogin/availablecar_user.dart';
import 'package:uberbooking_app/afterlogin/bike_available.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:uberbooking_app/custom/textcustom.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: textcustom(
              titletext: "Services",
              colortext: Colors.black,
              size: 45,
              fontbold: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Center(
                child: textcustom(
                  titletext: "Go anywhere, get anything",
                  colortext: Colors.black,
                  size: 15,
                  fontbold: FontWeight.bold,
                ),
              )),
          Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Center(
                child: textcustom(
                  titletext: "Choose your taxi",
                  colortext: Colors.black,
                  size: 15,
                  fontbold: FontWeight.bold,
                ),
              )),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Availablecaruserpage(),
                    )),
                child: Container(
                  height: 100,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: const DecorationImage(
                          image: CachedNetworkImageProvider(
                              "https://th.bing.com/th/id/OIP.UZOxl4tb2YXbSx11xyOO7AHaEh?rs=1&pid=ImgDetMain"))),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Autoavailable(),
                    )),
                child: Container(
                  height: 100,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: const DecorationImage(
                          image: CachedNetworkImageProvider(
                              "https://5.imimg.com/data5/FW/FY/MY-989864/ape-auto-rickshaw-500x500.jpg"))),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 44,
          ),
          Center(
            child: GestureDetector(
              onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BikeAvailable())),
              child: Container(
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: const DecorationImage(
                        image: CachedNetworkImageProvider(
                            "https://www.visordown.com/sites/default/files/article-images/8/81352.jpg"))),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
