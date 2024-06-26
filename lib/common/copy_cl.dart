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

void copyChecklistToMother(String choice, String month, String questionText,
    String doctorId, String category, String qno, int score) async {
  // Reference to the checklist collection
  CollectionReference checklistCollection = FirebaseFirestore.instance
      .collection('checklist')
      .doc(month)
      .collection(category);

  // Reference to the mother's nested checklist collection
  CollectionReference motherChecklistCollection = FirebaseFirestore.instance
      .collection('Mothers')
      .doc(motherId)
      .collection('checklist')
      .doc(month)
      .collection(category);

  try {
    // Write the question and response choice to the mother's nested checklist collection
    await motherChecklistCollection.doc(qno).set({
      'response': choice,
      'question': questionText,
      'doctorId': doctorId,
      'score': score,
    });
    _calculateAndUpdateTotalScore(month, category);
    print(
        'Checklist item copied to mother successfully under category: $category');
  } catch (e) {
    print('Error copying checklist item to mother: $e');
  }
}

Future<void> _calculateAndUpdateTotalScore(
    String month, String category) async {
  var collectionRef = FirebaseFirestore.instance
      .collection('checklist')
      .doc(month)
      .collection(category);

  var querySnapshot = await collectionRef.get();
  int totalScore = 0;

  for (var doc in querySnapshot.docs) {
    var data = doc.data();
    int? score = data['score'];
    if (score != null) {
      totalScore += score;
    }
  }

  print(totalScore);
  
    await FirebaseFirestore.instance
        .collection('Mothers').doc(user!.uid).collection('checklist')
        .doc(month)
        .set({'${category}_total': totalScore},SetOptions(merge: true));
  }

