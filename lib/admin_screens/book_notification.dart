import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uberbooking_app/custom/textcustom.dart';

class BookNotification extends StatefulWidget {
  const BookNotification({super.key});

  @override
  State<BookNotification> createState() => _BookNotificationState();
}

class _BookNotificationState extends State<BookNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: textcustom(
            titletext: "NOTIFICATIONS", colortext: Colors.white, size: 20),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("bookdetails").snapshots(),
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
                return Column(
                  children: [
                    Container(
                      height: 77,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 185, 214, 239)),
                      child: ListTile(
                        title: Row(
                          children: [
                            textcustom(
                                titletext: "EMAIL : ",
                                colortext: Colors.black,
                                size: 14),
                            Text(snapshot.data!.docs[index].get("email")),
                          ],
                        ),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                textcustom(
                                    titletext: "NAME : ",
                                    colortext: Colors.black,
                                    size: 14),
                                Text(
                                    snapshot.data!.docs[index].get("username")),
                              ],
                            ),
                            Row(
                              children: [
                                textcustom(
                                    titletext: "TAXI : ",
                                    colortext: Colors.black,
                                    size: 14),
                                Text(snapshot.data!.docs[index].get("company")),
                                const SizedBox(
                                  width: 50,
                                ),
                                textcustom(
                                    titletext: "PRICE : ",
                                    colortext: Colors.black,
                                    size: 14),
                                Text(snapshot.data!.docs[index].get("price")),
                              ],
                            ),
                            Row(
                              children: [
                                textcustom(
                                    titletext: "PICKUP LOCATION : ",
                                    colortext: Colors.black,
                                    size: 12),
                                Text(snapshot.data!.docs[index]
                                    .get("pickup location")),
                                const SizedBox(
                                  width: 20,
                                ),
                                textcustom(
                                    titletext: "DESTINATION : ",
                                    colortext: Colors.black,
                                    size: 12),
                                Text(snapshot.data!.docs[index]
                                    .get("destination")),
                              ],
                            ),
                          ],
                        ),
                        // trailing:
                        //     Text(snapshot.data!.docs[index].get("pickup time")),
                      ),
                    ),
                    const Divider()
                  ],
                );
              },
            );
          } else {
            return const Text("no data");
          }
        },
      ),
    );
  }
}
