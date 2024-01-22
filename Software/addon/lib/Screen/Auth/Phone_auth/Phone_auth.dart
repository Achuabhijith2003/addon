// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:addon/Screen/Auth/Email_auth/Email_SignIn.dart';
import 'package:addon/Screen/Auth/Phone_auth/otp_verfication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class phone_auth extends StatefulWidget {
  const phone_auth({super.key});

  @override
  State<phone_auth> createState() => _phone_authState();
}

// ignore: camel_case_types
class _phone_authState extends State<phone_auth> {
  TextEditingController phonenocontoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Phone Login"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 200),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: phonenocontoller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none),
                    filled: true,
                    hintText: "Phone.no",
                    prefixIcon: const Icon(
                      Icons.phone,
                      color: Color(0xfff28800),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: () {
                      sdotp();
                    },
                    child: const Text("Get OTP")),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const E_mail_signIn()));
                    },
                    child: const Text("SignIn using Email")),
              )
            ],
          ),
        ),
      ),
    );
  }

  void sdotp() async {
    String phone = "+91${phonenocontoller.text.trim()}";
    if (phone == "") {
      errormessage("fill the field");
    } else if (phone.length != 13) {
      errormessage("fill the field");
    } else {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (error) {},
        codeSent: (verificationId, forceResendingToken) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => opt_verfication(
                        verficationID: verificationId,
                        phoneno: phone,
                      )));
        },
        codeAutoRetrievalTimeout: (verificationId) {},
        timeout: const Duration(seconds: 30),
      );
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
}
