import 'package:flutter/material.dart';
import 'package:physiotherapy/mothers/m_homepage.dart';
class MotherInitialPage extends StatefulWidget {
  const MotherInitialPage({super.key});

  @override
  State<MotherInitialPage> createState() => _MotherInitialPageState();
}

class _MotherInitialPageState extends State<MotherInitialPage> {

  

  @override
  int _currentIndex = 0;

  List <Widget> tabs =  <Widget> [
    MotherHomePage()
  ];

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
                label: 'Doctors',
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
