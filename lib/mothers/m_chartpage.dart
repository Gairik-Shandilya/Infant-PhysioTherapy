import 'package:flutter/material.dart';
import 'package:physiotherapy/common/checklist.dart'; // Assuming you have this model.

class MotherChartPage extends StatefulWidget {
  const MotherChartPage({super.key});

  @override
  State<MotherChartPage> createState() => _MotherChartPageState();
}

class _MotherChartPageState extends State<MotherChartPage> {
  List<bool> buttonStates = List.generate(12, (index) => false);
  int selectedButtonNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Select Month',
              style: TextStyle(
                color: Color(0xFF4A545E),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
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

            //CHART TO BE ADDED
          ],
        ),
      ),
    );
  }
}

class NumberedButton extends StatelessWidget {
  final int number;
  final VoidCallback onPressed;
  final bool isOrange;

  const NumberedButton({
    super.key,
    required this.number,
    required this.onPressed,
    required this.isOrange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              isOrange ? Colors.orange : const Color.fromRGBO(38, 47, 151, 1)),
          fixedSize: MaterialStateProperty.all(const Size(40, 40)),
        ),
        child: Text(
          '$number',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
