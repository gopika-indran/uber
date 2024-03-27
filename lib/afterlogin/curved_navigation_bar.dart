import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:uberbooking_app/afterlogin/home.dart';

import 'package:uberbooking_app/afterlogin/profile_user.dart';
import 'package:uberbooking_app/afterlogin/service_page.dart';

class motiontabbar extends StatefulWidget {
  const motiontabbar({super.key});

  @override
  State<motiontabbar> createState() => _motiontabbarState();
}

class _motiontabbarState extends State<motiontabbar> {
  int selecteditems = 0;

  List screens = [const homepage(), const ServicePage(), const ProfileUser()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          height: 50,
          onTap: (Index) {
            setState(() {
              selecteditems = Index;
            });
          },
          backgroundColor: Colors.blue,
          color: Colors.white,
          items: const [
            Icon(Icons.home),
            Icon(Icons.apps),
            Icon(Icons.person)
          ]),
      body: screens.elementAt(selecteditems),
    );
  }
}
