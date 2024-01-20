// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

// ignore: camel_case_types
class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Column(children: [
        Expanded(
          child: Column(
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(getauth())
                    .doc("Profile")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            Map<String, dynamic> userdata =
                                snapshot.data!.data() as Map<String, dynamic>;
                            return Column(
                              children: [
                                Container(
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 244, 245, 243),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(500),
                                        )),
                                    child: ListTile(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      title: Text("Name : " + userdata["Name"]),
                                    )),
                                Container(
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 244, 245, 243),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(500),
                                        )),
                                    child: ListTile(
                                      title:
                                          // ignore: prefer_interpolation_to_compose_strings
                                          Text("Email : " + userdata["Email"]),
                                    )),
                                Container(
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 244, 245, 243),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(500),
                                        )),
                                    child: ListTile(
                                      title:
                                          // ignore: prefer_interpolation_to_compose_strings
                                          Text("Phone : " + userdata["Phone"]),
                                    )),
                                ElevatedButton(
                                    onPressed: () {}, child: const Text("Edit"))
                              ],
                            );
                          },
                          itemCount: 1,
                        ),
                      );
                    } else {
                      return const Text("No data!");
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        )
      ]),
    );
  }

  String getauth() {
    String? email = FirebaseAuth.instance.currentUser!.email;
    String? phoneno = FirebaseAuth.instance.currentUser!.phoneNumber;
    if (email == null) {
      return phoneno!;
    } else {
      return email;
    }
  }

  Future getCount() async => FirebaseFirestore.instance
          .collection(getauth()) //your collectionref
          .where('deleted', isEqualTo: false)
          .get()
          .then((value) {
        int count = 0;
        count = value.docs.length;

        return count;
      });
}
