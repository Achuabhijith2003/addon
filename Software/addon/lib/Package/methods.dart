import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

// Profile updating methods
bool updateprofile(String name, String emailid, String phone) {
  Map<String, dynamic> updatenewuserdata = {
    "Name": name,
    "Email": emailid,
    "Phone": phone
  };
  try {
    FirebaseFirestore.instance
        .collection(getauth())
        .doc("Profile")
        .update(updatenewuserdata);
    return true;
  } on FirebaseFirestore catch (e) {
    print(e);
    return false;
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

//create and update group
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
    FirebaseFirestore.instance.collection(getauth()).doc("Groups").update({
      groupname: [groupdata]
    });
    return true;
  } catch (e) {
    //print(e);
    return false;
  }
}

bool groupcreate(
   String  groupname,
) {
  Map<String, dynamic> groupdata = {
    "Group Name": groupname,
  };
  try {
    FirebaseFirestore.instance.collection(getauth()).doc("Groups").set({
      groupname: [groupdata]
    });
    return true;
  } catch (e) {
    return false;
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
