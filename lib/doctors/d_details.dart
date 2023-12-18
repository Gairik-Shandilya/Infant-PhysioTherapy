import 'package:flutter/material.dart';
import 'package:physiotherapy/doctors/d_initialpage.dart';

class DoctorDetailEnquiry extends StatefulWidget {
  const DoctorDetailEnquiry({super.key});

  @override
  State<DoctorDetailEnquiry> createState() => _DoctorDetailEnquiryState();
}

class _DoctorDetailEnquiryState extends State<DoctorDetailEnquiry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('DOCTOR DETAILS PAGE'),
          ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DoctorInitialPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    minimumSize:const Size(100, 50),
                    backgroundColor:const Color.fromARGB(255, 16, 89, 149)),
                child: const Text(
                  "Go to Home Page",
                  style: TextStyle(fontSize: 20),
                ))
        ],
      ),
    );
  }
}