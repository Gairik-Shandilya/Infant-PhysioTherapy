import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:physiotherapy/chatapp/chat_service.dart';
import 'package:physiotherapy/chatapp/chatscreen.dart';
import 'package:physiotherapy/mothers/m_chartpage.dart';
import 'package:physiotherapy/mothers/m_checklist.dart';

class DoctorDetailPage extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> doctorDetails;

  const DoctorDetailPage({Key? key, required this.doctorDetails})
      : super(key: key);
  
  @override
  
  Widget build(BuildContext context) {
    Map<String, dynamic> data = doctorDetails.data() as Map<String, dynamic>;
        User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(data['Name']),
        actions: [
          IconButton(
            icon: const Icon(Icons.textsms_outlined),
            onPressed: () async {
              if (user != null) {
                String chatId = await ChatService()
                    .initializeChat(user.uid, doctorDetails.id);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ChatScreen(chatId: chatId, name: data['Name']),
                  ),
                );
              } else {
                // Handle the case when the user is not logged in
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {
              // Handle notifications action
            },
          )
        ],
        backgroundColor: const Color.fromARGB(255, 16, 89, 149),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'Gender : ${data['Gender']}',
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Color(0xFF4A545E),
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                '-----------------------------------------------------------------------------------------'),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Degree : ${data['Degree']}',
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Color(0xFF4A545E),
                fontSize: 18,
                fontFamily: 'Pacificio',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                '-----------------------------------------------------------------------------------------'),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Institute : ${data['Institute']}',
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Color(0xFF4A545E),
                fontSize: 18,
                fontFamily: 'Pacificio',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                '-----------------------------------------------------------------------------------------'),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Speciality : ${data['Speciality']}',
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Color(0xFF4A545E),
                fontSize: 18,
                fontFamily: 'Pacificio',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                '-----------------------------------------------------------------------------------------'),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Experience : ${data['Experience']}',
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Color(0xFF4A545E),
                fontSize: 18,
                fontFamily: 'Pacificio',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                '-----------------------------------------------------------------------------------------'),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Email : ${data['EmailAddress']}',
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Color(0xFF4A545E),
                fontSize: 18,
                fontFamily: 'Pacificio',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                '-----------------------------------------------------------------------------------------'),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Mobile Number : ${data['MobileNumber']}',
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Color(0xFF4A545E),
                fontSize: 18,
                fontFamily: 'Pacificio',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MotherDetailPage extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> motherDetails;

  const MotherDetailPage({Key? key, required this.motherDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = motherDetails.data() as Map<String, dynamic>;
        User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(data['InfantName']),
        actions: [
          IconButton(
            icon: const Icon(Icons.textsms_outlined),
            onPressed: () async {
              if (user != null) {
                String chatId = await ChatService()
                    .initializeChat(user.uid, motherDetails.id);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ChatScreen(chatId: chatId, name: data['InfantName']),
                  ),
                );
              }
              else{

              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {
              // Handle notifications action
            },
          )
        ],
        backgroundColor: const Color.fromARGB(255, 16, 89, 149),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'Gender : ${data['Gender']}',
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Color(0xFF4A545E),
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                '-----------------------------------------------------------------------------------------'),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Date of Birth : ${data['DateofBirth']}',
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Color(0xFF4A545E),
                fontSize: 18,
                fontFamily: 'Pacificio',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                '-----------------------------------------------------------------------------------------'),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Mother Name : ${data['MotherName']}',
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Color(0xFF4A545E),
                fontSize: 18,
                fontFamily: 'Pacificio',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                '-----------------------------------------------------------------------------------------'),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Father Name : ${data['FatherName']}',
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Color(0xFF4A545E),
                fontSize: 18,
                fontFamily: 'Pacificio',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                '-----------------------------------------------------------------------------------------'),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Email Address : ${data['Email Address']}',
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Color(0xFF4A545E),
                fontSize: 18,
                fontFamily: 'Pacificio',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                '-----------------------------------------------------------------------------------------'),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Mobile Number : ${data['MobileNumber']}',
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Color(0xFF4A545E),
                fontSize: 18,
                fontFamily: 'Pacificio',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(300, 50),
                    backgroundColor: const Color.fromARGB(255, 16, 89, 149)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SafeArea(child: MotherChecklist())));
                },
                child: const Text('View Checklist'),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(300, 50),
                    backgroundColor: const Color.fromARGB(255, 16, 89, 149)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SafeArea(child: MotherChartPage())));
                },
                child: const Text('View Scores'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
