import 'package:flutter/material.dart';
import 'package:physiotherapy/mothers/m_checklist.dart';
import 'package:physiotherapy/mothers/m_doctorlist.dart';
import 'package:physiotherapy/mothers/m_chartpage.dart';
import 'package:physiotherapy/mothers/m_homepage.dart';
import 'package:physiotherapy/mothers/m_profile.dart';
class MotherInitialPage extends StatefulWidget {
  const MotherInitialPage({super.key});

  @override
  State<MotherInitialPage> createState() => _MotherInitialPageState();
}

class _MotherInitialPageState extends State<MotherInitialPage> {

  

  int _currentIndex = 0;

  List <Widget> tabs =  <Widget> [
    const MotherHomePage(),
    const Doctorlist(),
    const MotherChecklist(),
    const MotherChartPage(),
    const MotherProfile()
  ];

  @override
  Widget build(BuildContext context) {

    return 
    SafeArea(
      child: Scaffold(
        
      
        body: SafeArea(child: tabs[_currentIndex]),
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
                label: 'Doctors',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Icon(Icons.message_rounded),
                label: 'Checklist',
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
