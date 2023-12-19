import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:physiotherapy/components/mytextfield.dart';
import 'package:physiotherapy/doctors/d_initialpage.dart';

class MotherDetailEnquiry extends StatefulWidget {
  String phone;
  MotherDetailEnquiry({super.key, required this.phone});

  @override
  State<MotherDetailEnquiry> createState() => _MotherDetailEnquiryState();
}

class _MotherDetailEnquiryState extends State<MotherDetailEnquiry> {
  final InfantName = TextEditingController();
  final FatherName = TextEditingController();
  final MotherName = TextEditingController();
  final DateofBirth = TextEditingController();
  final Gender = TextEditingController();
  final Address = TextEditingController();
  final AdhaarNumber = TextEditingController();
  final EmailAddress = TextEditingController();
  @override
  void dispose() {
    InfantName.dispose();
    FatherName.dispose();
    MotherName.dispose();
    Gender.dispose();
    DateofBirth.dispose();
    Address.dispose();
    AdhaarNumber.dispose();
    EmailAddress.dispose();
    super.dispose();
  }

  Future addUserDetails(
      String infantName,
      String fatherName,
      String motherName,
      String dateofBirth,
      String gender,
      String address,
      String adhaarNumber,
      String emailAddress) async {
    await FirebaseFirestore.instance
        .collection('Mothers')
        .doc(widget.phone)
        .set({
      'InfantName': infantName,
      'FatherName': fatherName,
      'MotherName': motherName,
      'DateofBirth': dateofBirth,
      'Gender': gender,
      'Address': address,
      'AdhaarNumber': adhaarNumber,
      'EmailAddress': emailAddress,
    });
  }

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
                'ENTER INFANT DETAILS',
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
                  controller: InfantName,
                  hintText: 'Infant Name',
                  obscureText: false),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  controller: FatherName,
                  hintText: 'Father Name',
                  obscureText: false),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  controller: MotherName,
                  hintText: 'Mother Name',
                  obscureText: false),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  controller: DateofBirth,
                  hintText: 'Date of Birth (DD-MM-YYYY)',
                  obscureText: false),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  controller: Gender,
                  hintText: 'Gender',
                  obscureText: false),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  controller: Address, hintText: 'Address', obscureText: false),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  controller: AdhaarNumber, hintText: 'Adhaar Number', obscureText: false),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  controller: EmailAddress,
                  hintText: 'EmailAddress',
                  obscureText: false),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    addUserDetails(
                        InfantName.text.trim(),
                        FatherName.text.trim(),
                        MotherName.text.trim(),
                        DateofBirth.text.trim(),
                        Gender.text.trim(),
                        Address.text.trim(),
                        AdhaarNumber.text.trim(),
                        EmailAddress.text.trim(),
                        );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DoctorInitialPage()),
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
