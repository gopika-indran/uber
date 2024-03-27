import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uberbooking_app/custom/textcustom.dart';

class Bikepage extends StatefulWidget {
  const Bikepage({super.key});

  @override
  State<Bikepage> createState() => _BikepageeState();
}

class _BikepageeState extends State<Bikepage> {
  List<String> imagebike = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("imagebike").snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                              snapshot.data!.docs[index].get("url")),
                        ),
                        const SizedBox(
                          width: 27,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            textcustom(
                              titletext:
                                  snapshot.data!.docs[index].get("company"),
                              colortext: Colors.black,
                              size: 17,
                              fontbold: FontWeight.bold,
                            ),
                            textcustom(
                              titletext:
                                  snapshot.data!.docs[index].get("price"),
                              colortext: Colors.black,
                              size: 17,
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("imagebike")
                              .doc(snapshot.data!.docs[index].id)
                              .delete();
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  );
                },
              );
            } else {
              return const Text("no edit");
            }
          },
        ),
      ),
    );
  }
}
