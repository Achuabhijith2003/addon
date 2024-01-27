import 'dart:io';

import 'package:addon/Package/methods.dart';
import 'package:addon/Screen/Add%20section/add_details.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Creategroup extends StatefulWidget {
  const Creategroup({super.key});

  @override
  State<Creategroup> createState() => _CreategroupState();
}

class _CreategroupState extends State<Creategroup> {
  TextEditingController namecontroller = TextEditingController();
  File? grouppic;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("New Group"),
      ),
      body: Column(children: [
        TextButton(
            onPressed: () async {
              XFile? selectedimage =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              try {
                if (selectedimage != null) {
                  File convertimage = File(selectedimage.path);
                  setState(() {
                    grouppic = convertimage;
                  });
                  debugPrintStack(label: "Image selected");
                } else {
                  debugPrintStack(label: "No image is selected");
                }
              } catch (e) {
                print(e);
              }
            },
            child: CircleAvatar(
              backgroundImage: (grouppic != null) ? FileImage(grouppic!) : null,
              backgroundColor: (Colors.green),
              radius: 70,
            )),
        TextField(
          controller: namecontroller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none),
            filled: true,
            hintText: "Group name",
            prefixIcon: const Icon(
              Icons.abc_outlined,
              color: Color(0xfff28800),
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              checkgroupcreate();
            },
            child: const Text("Create"))
      ]),
    );
  }

  void checkgroupcreate() {
    String groupname = namecontroller.text.trim();
    if (groupname == "") {
    } else {
      Groups groups = Groups();
      Future<bool> result = groups.groupcreate(groupname, grouppic);
      print(result);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => adddetiles(groupname: groupname),
          ));
    }
  }
}
