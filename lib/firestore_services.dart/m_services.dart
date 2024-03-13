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

// Assuming you have the motherId and monthId
User? user = FirebaseAuth.instance.currentUser;
String motherId = user!.uid; // Use the user's UID as the mother's ID

void copyChecklistToMother(String choice,String month) async {
  // Reference to the checklist collection
  CollectionReference checklistCollection = FirebaseFirestore.instance
      .collection('checklist')
      .doc(month)
      .collection('questions');

  // Reference to the mother's nested checklist collection
  CollectionReference motherChecklistCollection = FirebaseFirestore.instance
      .collection('Mothers')
      .doc(motherId)
      .collection('checklist')
      .doc(month)
      .collection('questions');

  try {
    // Get the questions from the checklist collection
    QuerySnapshot checklistSnapshot = await checklistCollection.get();

    // Iterate through each question and write it to the mother's nested checklist collection
    for (QueryDocumentSnapshot questionDoc in checklistSnapshot.docs ) {
      String questionText = questionDoc['text'];
      String doctorId = questionDoc['doctorId'];
      // Write the question to the mother's nested checklist collection
      await motherChecklistCollection.add({
        'choice': choice,
        'text': questionText,
        'doctorId': doctorId,
      });
    }

    print('Checklist copied to mother successfully');
  } catch (e) {
    print('Error copying checklist to mother: $e');
  }
}
