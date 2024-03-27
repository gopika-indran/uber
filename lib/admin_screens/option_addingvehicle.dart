import 'package:flutter/material.dart';
import 'package:uberbooking_app/admin_screens/add_bike.dart';
import 'package:uberbooking_app/admin_screens/addauto.dart';
import 'package:uberbooking_app/admin_screens/addcar.dart';
import 'package:uberbooking_app/afterlogin/availablecar_user.dart';

import 'package:uberbooking_app/custom/textcustom.dart';

class Optionaddvehicle extends StatefulWidget {
  const Optionaddvehicle({super.key});

  @override
  State<Optionaddvehicle> createState() => _OptionaddvehicleState();
}

class _OptionaddvehicleState extends State<Optionaddvehicle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 40,
                  )),
              const SizedBox(
                width: 46,
              ),
              Center(
                child: textcustom(
                  titletext: "Services",
                  colortext: Colors.black,
                  size: 45,
                  fontbold: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Center(
                child: textcustom(
                  titletext: "Add Available Taxi",
                  colortext: Colors.black,
                  size: 15,
                  fontbold: FontWeight.bold,
                ),
              )),
          const SizedBox(
            height: 70,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Showupdatepage(),
                    )),
                child: Container(
                  height: 100,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: const DecorationImage(
                          image: NetworkImage(
                              "https://th.bing.com/th/id/OIP.UZOxl4tb2YXbSx11xyOO7AHaEh?rs=1&pid=ImgDetMain"))),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Addauto(),
                    )),
                child: Container(
                  height: 100,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: const DecorationImage(
                          image: NetworkImage(
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
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddBike(),
                  )),
              child: Container(
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: const DecorationImage(
                        image: NetworkImage(
                            "https://www.visordown.com/sites/default/files/article-images/8/81352.jpg"))),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
