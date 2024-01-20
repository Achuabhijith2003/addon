// ignore_for_file: file_names

import 'package:addon/Screen/Auth/Email_auth/Email_SignIn.dart';
import 'package:addon/Screen/Drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
                  logout();
                },
                icon: const Icon(Icons.logout_rounded))
          ],
        ),
        body: Column(
          children: [
            ElevatedButton(onPressed: () {}, child: const Text("data")),
            Text(getemail())
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
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const E_mail_signIn(),
        ));
  }

  String getemail() {
    String? email = FirebaseAuth.instance.currentUser!.email;
    String? phoneno = FirebaseAuth.instance.currentUser!.phoneNumber;
    if (email == null) {
      return phoneno!;
    } else {
      return email;
    }
  }
}
