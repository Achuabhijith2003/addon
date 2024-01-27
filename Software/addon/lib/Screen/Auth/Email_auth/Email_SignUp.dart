// ignore_for_file: file_names

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Email_SignIn.dart';

// ignore: camel_case_types
class Email_signUp extends StatefulWidget {
  const Email_signUp({super.key});

  @override
  State<Email_signUp> createState() => _Email_signUpState();
}

// ignore: camel_case_types
class _Email_signUpState extends State<Email_signUp> {
  bool _isObscure = true;
  bool _isObscure1 = true;

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController rePasswordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: TextField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none),
                    filled: true,
                    hintText: "Email Id",
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Color(0xfff28800),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextField(
                  controller: passwordcontroller,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none),
                    filled: true,
                    hintText: "Password",
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Color(0xfff28800),
                    ),
                    suffix: IconButton(
                      padding: const EdgeInsets.only(),
                      iconSize: 20.0,
                      icon: _isObscure
                          ? const Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                            )
                          : const Icon(
                              Icons.visibility,
                              color: Colors.black,
                            ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextField(
                  controller: rePasswordcontroller,
                  obscureText: _isObscure1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none),
                    filled: true,
                    hintText: "Re-Password",
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Color(0xfff28800),
                    ),
                    suffix: IconButton(
                      padding: const EdgeInsets.only(),
                      iconSize: 20.0,
                      icon: _isObscure1
                          ? const Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                            )
                          : const Icon(
                              Icons.visibility,
                              color: Colors.black,
                            ),
                      onPressed: () {
                        setState(() {
                          _isObscure1 = !_isObscure1;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(children: [
                  ElevatedButton(
                      onPressed: () {
                        accountcreate();
                      },
                      child: const Text("Create Account")),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void accountcreate() async {
    String email = emailcontroller.text.trim();
    String password = passwordcontroller.text.trim();
    String repasword = rePasswordcontroller.text.trim();
    if (email == "" || password == "" || repasword == "") {
      errormessage("Every fields are required.");
    } else {
      if (password != repasword) {
        errormessage("Password and Re-Password are not same");
      } else {
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);
          if (userCredential.user != null) {
            createdatabase();
            // ignore: use_build_context_synchronously
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const E_mail_signIn()));
          }
        } on FirebaseAuthException catch (e) {
          log(e.code.toString());
          switch (e.code) {
            case "invalid-email":
              errormessage("Invalid Email Address");
              break;
            case "weak-password":
              errormessage("Weak Password");
              break;
            case "email-already-in-use":
              errormessage(
                  "The provided email is already in use by another account.");
              break;
            default:
              errormessage("An undefined Error occured.");
          }
        }
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
    String email = emailcontroller.text.trim();
    Map<String, dynamic> newuserdata = {
      "Name": " ",
      "Email": email,
      "Phone": " "
    };
    FirebaseFirestore.instance
        .collection(email)
        .doc("Profile")
        .set(newuserdata);
  }
}
