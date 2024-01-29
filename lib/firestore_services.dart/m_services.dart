import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

String motherUserName = '';
String doctorUserName = '';
Future<String> getMotherName() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Mothers')
          .doc(user.uid)
          .get();
      motherUserName = userSnapshot['MotherName'].toString();
    } else {
      if (kDebugMode) {
        print('No current user');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error fetching data: $e');
    }
  }
  return motherUserName;
}

Future<String> getDoctorName() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Doctors')
          .doc(user.uid)
          .get();
      doctorUserName = userSnapshot['Name'].toString();
    } else {
      if (kDebugMode) {
        print('No current user');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error fetching data: $e');
    }
  }
  return doctorUserName;
}



