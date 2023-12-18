import 'package:flutter/material.dart';
import 'package:physiotherapy/mothers/m_intitialpage.dart';

class MotherDetailEnquiry extends StatefulWidget {
  const MotherDetailEnquiry({super.key});

  @override
  State<MotherDetailEnquiry> createState() => _MotherDetailEnquiryState();
}

class _MotherDetailEnquiryState extends State<MotherDetailEnquiry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('MOTHER DETAILS PAGE'),
          ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MotherInitialPage()),
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