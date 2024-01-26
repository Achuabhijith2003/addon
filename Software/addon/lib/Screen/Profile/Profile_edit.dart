// ignore_for_file: non_constant_identifier_names

import 'package:addon/Package/methods.dart';
import 'package:addon/Screen/Profile/Profile.dart';
import 'package:flutter/material.dart';

class editprofile extends StatefulWidget {
  const editprofile({
    super.key,
  });

  @override
  State<editprofile> createState() => _editprofileState();
}

class _editprofileState extends State<editprofile> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonenocontoller = TextEditingController();
  TextEditingController namecontoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Edit_Profile"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TextField(
              keyboardType: TextInputType.name,
              controller: namecontoller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none),
                filled: true,
                hintText: "Name",
                prefixIcon: const Icon(
                  Icons.abc_outlined,
                  color: Color(0xfff28800),
                ),
              ),
            ),
          ),
          email_or_phone(),
        ],
      ),
    );
  }

  Widget email_or_phone() {
    if (loginstyle()) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
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
          ElevatedButton(
              onPressed: () {
                String name = namecontoller.text.trim();
                String phone = phonenocontoller.text.trim();
                if (name == "" || phone == "") {
                  errormessage("Fil the blanks");
                } else {
                  updateprofile(name, getauth(), phone);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const profile()));
                }
              },
              child: const Text("Change"))
        ],
      );
    } else {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
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
          ElevatedButton(
              onPressed: () {
                String name = namecontoller.text.trim();
                String email = emailcontroller.text.trim();
                if (name == "" || email == "") {
                  errormessage("Fil the blanks");
                } else {
                  updateprofile(name, email, getauth());
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const profile()));
                }
              },
              child: const Text("Change"))
        ],
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
