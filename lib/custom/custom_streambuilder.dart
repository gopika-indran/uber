import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uberbooking_app/custom/textcustom.dart';

class CustomStreambuilder extends StatelessWidget {
  const CustomStreambuilder({super.key, required this.collection});
  final String collection;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection(collection).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.connectionState == ConnectionState) {
          return ListView.builder(
            itemCount: 6,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child: Container(
                  height: 150,
                  width: 120,
                  decoration: const BoxDecoration(color: Colors.blue),
                  child: const CircularProgressIndicator(),
                ),
              );
            },
          );
        }
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Container(
                  height: 150,
                  width: 130,
                  decoration: const BoxDecoration(color: Colors.blue),
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    snapshot.data!.docs[index].get("url")))),
                      ),
                      textcustom(
                          titletext: snapshot.data!.docs[index].get("company"),
                          colortext: Colors.black,
                          size: 14),
                      textcustom(
                          titletext: snapshot.data!.docs[index].get("type"),
                          colortext: Colors.black,
                          size: 14)
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const Icon(Icons.error);
        }
      },
    );
  }
}
