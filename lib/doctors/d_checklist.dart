import 'package:flutter/material.dart';
import 'package:physiotherapy/common/checklist.dart';

class DoctorChecklist extends StatefulWidget {
  const DoctorChecklist({super.key});

  @override
  State<DoctorChecklist> createState() => _DoctorChecklistState();
}

class _DoctorChecklistState extends State<DoctorChecklist> {
  List<bool> buttonStates = List.generate(12, (index) => false);
 int selectedButtonNumber = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
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
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int i = 0; i < 6; i++)
                      NumberedButton(
                        number: i + 1,
                        onPressed: () {
                          setState(() {
                            for (int j = 0; j < buttonStates.length; j++) {
                              if (j == i) {
                                buttonStates[j] = !buttonStates[j];
                              } else {
                                buttonStates[j] = false;
                              }
                            }
                            selectedButtonNumber = i + 1; 
                          });
                        },
                        isOrange: buttonStates[i],
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int i = 6; i < 12; i++)
                      NumberedButton(
                        number: i + 1,
                        onPressed: () {
                          setState(() {
                            for (int j = 0; j < buttonStates.length; j++) {
                              if (j == i) {
                                buttonStates[j] = !buttonStates[j];
                              } else {
                                buttonStates[j] = false;
                              }
                            }
                            selectedButtonNumber = i + 1;
                          });
                        },
                        isOrange: buttonStates[i],
                      ),
                  ],
                ),
              ),
              
              
              const SizedBox(height: 10,),
              Text('Gross'),
              SizedBox(height: 100,child: DoctorChecklistPage(category: 'Gross', month: selectedButtonNumber.toString())),
              Text('Fine Motor'),
              SizedBox(height: 100,child: DoctorChecklistPage(category: 'Fine Motor', month: selectedButtonNumber.toString())),
              Text('Communication'),
              SizedBox(height: 100,child: DoctorChecklistPage(category: 'Communication', month: selectedButtonNumber.toString())),
              Text('Problem Solving'),
              SizedBox(height :100, child: DoctorChecklistPage(category: 'Problem Solving', month: selectedButtonNumber.toString())),
              Text('Personal Social'),
              SizedBox(height: 100,child: DoctorChecklistPage(category: 'Personal Social', month: selectedButtonNumber.toString())),
            ],
          ),
        ),
      ),
    );
  }
}

class NumberedButton extends StatelessWidget {
  final int number;
  final VoidCallback onPressed;
  final bool isOrange;

  const NumberedButton({super.key, 
    required this.number,
    required this.onPressed,
    required this.isOrange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.none,
      width: 55,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: isOrange
              ? MaterialStateProperty.all<Color>(Colors.orange)
              : MaterialStateProperty.all<Color>(
                const  Color.fromRGBO(38, 47, 151, 1),
                ),
          fixedSize: MaterialStateProperty.all<Size>(const Size(40, 40)),
        ),
        child: Text(
          '$number',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
