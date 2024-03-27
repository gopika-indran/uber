import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uberbooking_app/custom/textcustom.dart';

class AutoPage extends StatefulWidget {
  const AutoPage({super.key});

  @override
  State<AutoPage> createState() => _AutoPageState();
}

class _AutoPageState extends State<AutoPage> {
  List<String> imageauto = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("imageauto").snapshots(),
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
                          backgroundColor: Colors.white,
                          radius: 35,
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
                              .collection("imageauto")
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
