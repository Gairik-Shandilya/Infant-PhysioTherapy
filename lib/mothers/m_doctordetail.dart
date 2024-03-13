import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DoctorDetailPage extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> doctorDetails;

  const DoctorDetailPage({Key? key, required this.doctorDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = doctorDetails.data() as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(data['Name']),
        actions: [
          IconButton(
            icon: const Icon(Icons.textsms_outlined),
            onPressed: () {
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
