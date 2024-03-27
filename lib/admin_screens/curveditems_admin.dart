import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:uberbooking_app/admin_screens/admin_home.dart';
import 'package:uberbooking_app/admin_screens/profile_admin.dart';
import 'package:uberbooking_app/admin_screens/user_collection.dart';

class Curveditems extends StatefulWidget {
  const Curveditems({super.key});

  @override
  State<Curveditems> createState() => _CurveditemsState();
}

class _CurveditemsState extends State<Curveditems> {
  int curveitems = 0;
  List curvescreens = [
    const AdminHome(),
    const Usercollection(),
    const AdminProfile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          height: 50,
          onTap: (Index) {
            setState(() {
              curveitems = Index;
            });
          },
          backgroundColor: Colors.blue,
          color: Colors.white,
          items: const [
            Icon(Icons.home),
            Icon(Icons.people_alt),
            Icon(Icons.person)
          ]),
      body: curvescreens.elementAt(curveitems),
    );
  }
}
