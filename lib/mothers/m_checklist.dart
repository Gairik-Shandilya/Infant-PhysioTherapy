import 'package:flutter/material.dart';
import 'package:physiotherapy/models/checklist.dart';

class MotherChecklist extends StatefulWidget {
  const MotherChecklist({super.key});

  @override
  State<MotherChecklist> createState() => _MotherChecklistState();
}

class _MotherChecklistState extends State<MotherChecklist> {
  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        SizedBox(height: 20,),
        Text(
                  'Mother Checklist',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF4A545E),
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
        SizedBox(height: 20,),
        Expanded(child: MotherChecklistPage()),
      ],
    );
  }
}
