import 'package:flutter/material.dart';

// ignore: must_be_immutable
class adddetiles extends StatefulWidget {
  String groupname;
  adddetiles({super.key, required this.groupname});

  @override
  State<adddetiles> createState() => adddetilesState();
}

class adddetilesState extends State<adddetiles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.groupname),
      ),
      body: Column(children: [Text("data")]),
    );
  }
}
