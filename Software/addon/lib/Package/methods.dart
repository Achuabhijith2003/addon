import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class Authithication {
  // get login email or phone
  String getauth() {
    String? email = FirebaseAuth.instance.currentUser!.email;
    String? phoneno = FirebaseAuth.instance.currentUser!.phoneNumber;
    if (email == null) {
      return phoneno!;
    } else {
      return email;
    }
  }

// to find the user login with email or phone
  loginstyle() {
    if (getauth().contains("@")) {
      return true;
    } else {
      return false;
    }
  }
}

class Profile {
  Authithication auth = Authithication();

  // Profile updating methods
  bool updateprofile(String name, String emailid, String phone) {
    Map<String, dynamic> updatenewuserdata = {
      "Name": name,
      "Email": emailid,
      "Phone": phone
    };
    try {
      FirebaseFirestore.instance
          .collection(auth.getauth())
          .doc("Profile")
          .update(updatenewuserdata);
      return true;
    } on FirebaseFirestore catch (e) {
      print(e);
      return false;
    }
  }
}

// Widget  errormessage(String errorMessage) {
//     showDialog(
//       context: ,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Error!'),
//           content: Text(errorMessage),
//           actions: [
//             TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text('Okay'))
//           ],
//         );
//       },
//     );
//   }

class Groups {
  Authithication auth = Authithication();
// update group
  bool groupupdate(
    String groupname,
    name,
    age,
  ) {
    Map<String, dynamic> groupdata = {
      "Group Name": groupname,
      "Name": name,
      "Age": age
    };
    try {
      FirebaseFirestore.instance
          .collection(auth.getauth())
          .doc("Groups")
          .update({
        groupname: [groupdata]
      });
      return true;
    } catch (e) {
      //print(e);
      return false;
    }
  }

//Create Group
  Future<bool> groupcreate(String groupname, File? grouppic) async {
    TaskSnapshot uploadTask = await FirebaseStorage.instance
        .ref()
        .child("Groupic")
        .child(const Uuid().v1())
        .putFile(grouppic!);

    //  TaskSnapshot takesnapshot = uploadTask;

    String downloadurl = await uploadTask.ref.getDownloadURL();
    Map<String, dynamic> groupdata = {
      "Group Name": groupname,
      "Groupic": downloadurl,
    };
    try {
      FirebaseFirestore.instance
          .collection(auth.getauth())
          .doc("Groups")
          .update({
        groupname: [groupdata]
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
