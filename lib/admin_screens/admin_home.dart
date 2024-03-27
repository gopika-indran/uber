import 'package:flutter/material.dart';
import 'package:uberbooking_app/admin_screens/auto_edit_del.dart';
import 'package:uberbooking_app/admin_screens/bike_edit_del.dart';
import 'package:uberbooking_app/admin_screens/book_notification.dart';
import 'package:uberbooking_app/admin_screens/car_edit_del.dart';
import 'package:uberbooking_app/admin_screens/option_addingvehicle.dart';
import 'package:uberbooking_app/admin_screens/addcar.dart';
import 'package:uberbooking_app/admin_screens/profile_admin.dart';
import 'package:uberbooking_app/admin_screens/user_collection.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int selecteditems = 0;

  List screens = [const Carviewadminpage(), const AutoPage(), const Bikepage()];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                  onTap: (int intex) {
                    setState(() {
                      selecteditems = intex;
                    });
                  },
                  tabs: const [
                    Tab(
                      text: "Cars",
                    ),
                    Tab(
                      text: "Autos",
                    ),
                    Tab(
                      text: "Bikes",
                    ),
                  ]),
              leading: const CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(
                  "https://img.freepik.com/free-vector/taxi-logotype-design_1057-4891.jpg?size=338&ext=jpg&ga=GA1.1.2082370165.1710460800&semt=ais",
                ),
              ),
              title: const Text(
                "AVAILABLE TAXIES",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BookNotification(),
                          ));
                    },
                    icon: const Icon(Icons.notifications)),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Optionaddvehicle(),
                          ));
                    },
                    icon: const Icon(Icons.add)),
              ],
            ),
            body: screens.elementAt(selecteditems)));
  }
}
