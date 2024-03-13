import 'package:flutter/material.dart';
import 'package:physiotherapy/doctors/d_checklist.dart';
import 'package:physiotherapy/doctors/d_homepage.dart';
import 'package:physiotherapy/doctors/d_motherlist.dart';
import 'package:physiotherapy/doctors/d_profile.dart';
import 'package:physiotherapy/mothers/m_checklist.dart';

class DoctorInitialPage extends StatefulWidget {
  const DoctorInitialPage({super.key});

  @override
  State<DoctorInitialPage> createState() => _DoctorInitialPageState();
}

class _DoctorInitialPageState extends State<DoctorInitialPage> {
  int _currentIndex = 0;

  List <Widget> tabs =  <Widget> [
    DoctorArticleScreen(),
    const Motherlist(),
    const DoctorChecklist(),
    const MotherChecklist(),
    const DoctorProfile()

  ];

  @override
  Widget build(BuildContext context) {

    return 
    SafeArea(
      child: Scaffold(
        
    
        body: tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Icon(Icons.local_hospital),
                label: 'Patients',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Icon(Icons.message_rounded),
                label: 'Consultation',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Icon(Icons.history_edu_sharp),
                label: 'History',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: 'Profile',
                backgroundColor: Colors.black),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
