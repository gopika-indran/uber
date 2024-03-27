import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uberbooking_app/custom/textcustom.dart';

class Usercollection extends StatefulWidget {
  const Usercollection({super.key});

  @override
  State<Usercollection> createState() => _UsercollectionState();
}

class _UsercollectionState extends State<Usercollection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            textcustom(titletext: "USERS", colortext: Colors.white, size: 18),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Mydatabase").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var userData = snapshot.data!.docs[index];
                var imageUrl = userData['url'];
                return ListTile(
                  title: Row(
                    children: [
                      imageUrl != null
                          ? CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(imageUrl),
                            )
                          : const CircleAvatar(
                              radius: 35,
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(snapshot.data!.docs[index].get("email")),
                          Text(snapshot.data!.docs[index].get("name")),
                          Text(snapshot.data!.docs[index].get("number")),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            return const Icon(
              Icons.error,
              color: Colors.red,
            );
          }
        },
      ),
    );
  }
}
