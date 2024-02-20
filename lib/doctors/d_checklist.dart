import 'package:flutter/material.dart';

class DoctorChecklist extends StatefulWidget {
  const DoctorChecklist({super.key});

  @override
  State<DoctorChecklist> createState() => _DoctorChecklistState();
}

class _DoctorChecklistState extends State<DoctorChecklist> {
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
      child: Column(
        children: [
          const SizedBox(
              height: 10,
            ),
            const Text(
              'Select Month',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF4A545E),
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            
        ],
      )
      ),
    );
  }
}

