import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:physiotherapy/components/mytextfield.dart';
import 'package:physiotherapy/doctors/d_initialpage.dart';

class DoctorDetailEnquiry extends StatefulWidget {
  String phone;
  DoctorDetailEnquiry({super.key, required this.phone});

  @override
  State<DoctorDetailEnquiry> createState() => _DoctorDetailEnquiryState();
}

class _DoctorDetailEnquiryState extends State<DoctorDetailEnquiry> {
  final Name = TextEditingController();
  final Gender = TextEditingController();
  final Age = TextEditingController();
  final Speciality = TextEditingController();
  final Experience = TextEditingController();
  final Degree = TextEditingController();
  final EmailAddress = TextEditingController();
  final Institute = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void dispose() {
    Name.dispose();
    Gender.dispose();
    Age.dispose();
    Speciality.dispose();
    Experience.dispose();
    Degree.dispose();
    EmailAddress.dispose();
    Institute.dispose();
    super.dispose();
  }

  Future addUserDetails(
    String name,
    String gender,
    String age,
    String speciality,
    String experience,
    String degree,
    String emailAddress,
    String institute,
    String mobilenumber,
  ) async {
    await FirebaseFirestore.instance.collection('Doctors').doc(user!.uid).set({
      'Name': name,
      'Gender': gender,
      'Age': age,
      'Speciality': speciality,
      'Experience': experience,
      'Degree': degree,
      'EmailAddress': emailAddress,
      'Institute': institute,
      'MobileNumber' : mobilenumber,
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text(
                'ENTER YOUR DETAILS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF4A545E),
                  fontSize: 25,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
              const SizedBox(height: 40),
              MyTextField(
                  controller: Name, hintText: 'Name', obscureText: false),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  controller: Gender, hintText: 'Gender', obscureText: false),
              const SizedBox(
                height: 10,
              ),
              MyTextField(controller: Age, hintText: 'Age (Years)', obscureText: false),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  controller: Speciality,
                  hintText: 'Speciality',
                  obscureText: false),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  controller: Experience,
                  hintText: 'Experience (Years)',
                  obscureText: false),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  controller: Degree, hintText: 'Degree', obscureText: false),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  controller: Institute,
                  hintText: 'Institute',
                  obscureText: false),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  controller: EmailAddress,
                  hintText: 'Email Address',
                  obscureText: false),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    addUserDetails(
                        Name.text.trim(),
                        Gender.text.trim(),
                        Age.text.trim(),
                        Speciality.text.trim(),
                        Experience.text.trim(),
                        Degree.text.trim(),
                        EmailAddress.text.trim(),
                        Institute.text.trim(),
                        widget.phone,
                        );
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DoctorInitialPage()),(route) => false
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 50),
                      backgroundColor: const Color.fromARGB(255, 16, 89, 149)),
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
