import 'package:flutter/material.dart';

class textcustom extends StatelessWidget {
  textcustom(
      {super.key,
      required this.titletext,
      required this.colortext,
      required this.size,
      this.fontbold});
  String titletext;
  Color colortext;
  FontWeight? fontbold;
  double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      titletext,
      style: TextStyle(color: colortext, fontSize: size, fontWeight: fontbold),
    );
  }
}
