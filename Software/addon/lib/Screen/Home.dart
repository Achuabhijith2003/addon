// ignore_for_file: file_names

import 'package:addon/Screen/Auth/Email_auth/Email_SignIn.dart';
import 'package:addon/Screen/Drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Package/methods.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Drawers(),
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Home"),
          actions: [
            IconButton(
                onPressed: () {
                  logout(); //logout
                },
                icon: const Icon(Icons.logout_rounded))
          ],
        ),
        body: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection(getauth()).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          Map<String, dynamic> userdata =
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;
                          return ListTile(
                              title: Text(snapshot.data!.docs[index].id),
                              //subtitle: Text(userdata["Phone"]),
                              trailing: IconButton(
                                onPressed: () {
                                  try {
                                    print(snapshot.data!.docs[index].id);
                                    FirebaseFirestore.instance
                                        .collection(getauth())
                                        .doc(snapshot.data!.docs[index].id)
                                        .delete();
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                icon: const Icon(Icons.delete),
                              ));
                        },
                        itemCount: snapshot.data!.docs.length,
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
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.add,
            color: Colors.green,
          ),
        ));
  }

  void logout() async {
    //logout method
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const E_mail_signIn(),
        ));
  }

  // String getauth() {
  //   String? email = FirebaseAuth.instance.currentUser!.email;
  //   String? phoneno = FirebaseAuth.instance.currentUser!.phoneNumber;
  //   if (email == null) {
  //     return phoneno!;
  //   } else {
  //     return email;
  //   }
  // }
}
