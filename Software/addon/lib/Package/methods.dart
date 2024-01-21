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
  } catch (e) {
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
