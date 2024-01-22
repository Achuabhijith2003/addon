// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'dart:developer';

import 'package:addon/Screen/Auth/Email_auth/Email_SignUp.dart';
import 'package:addon/Screen/Auth/Phone_auth/Phone_auth.dart';
import 'package:addon/Screen/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class E_mail_signIn extends StatefulWidget {
  const E_mail_signIn({super.key});

  @override
  State<E_mail_signIn> createState() => _E_mail_signInState();
}

// ignore: camel_case_types
class _E_mail_signInState extends State<E_mail_signIn> {
  bool _isObscure = true;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Login")),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 200),
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
                padding: const EdgeInsets.all(0),
                child: Column(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          login();
                        },
                        child: const Text("Log In")),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Email_signUp(),
                              ));
                        },
                        child: const Text("Create a Account")),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const phone_auth()));
                          },
                          child: const Text("SignIn using Phone no")),
                    )
                  ],
                ))
          ],
        ),
      )),
    );
  }

  void login() async {
    String email = emailcontroller.text.trim();
    String password = passwordcontroller.text.trim();
    if (email == "" || password == "") {
      errormessage("Both fields are required.");
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          // Access user through the instance
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Home(),
              ));
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        log(e.code.toString());
        switch (e.code) {
          case 'invalid-email':
            errorMessage = 'Your email address is invalid.';
            break;
          case 'wrong-password':
            errorMessage = 'Your password is wrong.';
            break;
          default:
            errorMessage = 'An undefined Error occurred.';
        }
        errormessage(errorMessage);
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
}
