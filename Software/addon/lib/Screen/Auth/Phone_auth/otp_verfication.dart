import 'package:addon/Screen/Auth/Phone_auth/Phone_auth.dart';
import 'package:addon/Screen/Home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class opt_verfication extends StatefulWidget {
  final String verficationID;
  final String phoneno;
  const opt_verfication(
      {super.key, required this.verficationID, required this.phoneno});

  @override
  State<opt_verfication> createState() => opt_verficationState();
}

// ignore: camel_case_types
class opt_verficationState extends State<opt_verfication> {
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("OTP verfication")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 200),
                child: TextField(
                  controller: otpController,
                  maxLength: 6,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none),
                    filled: true,
                    hintText: "OTP",
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Color(0xfff28800),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          verfication();
                        },
                        child: const Text("Verify")),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const phone_auth(),
                              ));
                        },
                        child: const Text("Edit phone number"))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void verfication() async {
    String otpVerfication = otpController.text.trim();
    if (otpVerfication == "") {
      errormessage("Fill the field");
    } else {
      // ignore: non_constant_identifier_names
      PhoneAuthCredential Credential = PhoneAuthProvider.credential(
          verificationId: widget.verficationID, smsCode: otpVerfication);
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(Credential);
        if (userCredential.user != null) {
          // Access user through the instance
          createdatabase();
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Home(),
              ));
        }
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }
  }

  void errormessage(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error!'),
          content: Text(errorMessage),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Okay'))
          ],
        );
      },
    );
  }

  void createdatabase() async {
    Map<String, dynamic> newuserdata = {
      "Phone": widget.phoneno,
    };
    FirebaseFirestore.instance
        .collection(widget.phoneno)
        .doc("Profile")
        .set(newuserdata);
  }
}
