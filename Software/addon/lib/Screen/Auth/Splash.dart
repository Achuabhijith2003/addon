// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:addon/Screen/Auth/Email_auth/Email_SignIn.dart';
import 'package:addon/Screen/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterSplashScreen(
        splashScreenBody: screen(),
        backgroundColor: Colors.white,
        nextScreen: (FirebaseAuth.instance.currentUser != null)
            ? const Home()
            : const E_mail_signIn(),
        duration: const Duration(milliseconds: 3515),
        onInit: () async {
          debugPrint("onInit");
        },
        onEnd: () async {
          debugPrint("onEnd 1");
        },
      ),
    );
  }
}

Widget screen() {
  return const Scaffold(
    backgroundColor: Colors.white,
    body: Column(
      children: [
        Expanded(
            flex: 6,
            child: Center(
                child: Text(
              "Add_on",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 152, 183, 121),
              ),
            ))),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              "Developed By \n         JR",
              style: TextStyle(color: Color.fromARGB(255, 152, 183, 121)),
            ),
          ),
        )
      ],
    ),
  );
}
