import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_core/firebase_core.dart';

class DataItem {
  int x; // no of items
  double y1; // data 1 yellow line
  double y2; // data 2 red line
  DataItem({
    required this.x,
    required this.y1,
    required this.y2,
  });
}

class MotherChartPage extends StatefulWidget {
  const MotherChartPage({super.key});

  @override
  State<MotherChartPage> createState() => _MotherChartPageState();
}

class _MotherChartPageState extends State<MotherChartPage> {
  List<bool> buttonStates = List.generate(12, (index) => false);
  int selectedButtonNumber = 0;
  List<DataItem> chartData = [];
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }
void fetchScores(String month) async {
  try {
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('Mothers')
        .doc(user!.uid)
        .collection('checklist')
        .doc(month)
        .get();

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      List<DataItem> tempData = [
        DataItem(x: 1, y1: (data['Gross_total'] as num?)?.toDouble() ?? 0.0, y2: cutoffs[0]),
        DataItem(x: 2, y1: (data['Communication_total'] as num?)?.toDouble() ?? 0.0, y2: cutoffs[1]),
        DataItem(x: 3, y1: (data['Fine Motor_total'] as num?)?.toDouble() ?? 0.0, y2: cutoffs[2]),
        DataItem(x: 4, y1: (data['Problem Solving_total'] as num?)?.toDouble() ?? 0.0, y2: cutoffs[3]),
        DataItem(x: 5, y1: (data['Personal Social_total'] as num?)?.toDouble() ?? 0.0, y2: cutoffs[4]),
      ];
      setState(() {
        chartData = tempData;
      });
    } else {
      print('Document does not exist for the selected month: $month');
    }
  } catch (e) {
    print('Error fetching scores: $e');
  }
}

  // Cutoffs for each category by month, example values
  final List<double> cutoffs = [50, 45, 40, 35, 30];

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
                        fetchScores(selectedButtonNumber.toString());
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
                        fetchScores(selectedButtonNumber.toString());
                      },
                      isOrange: buttonStates[i],
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (chartData.isNotEmpty)
              BargraphPage(
                chartData: chartData,
              ),
            SizedBox(height: 10,),
            Text("G - Gross Motor Total"),
            Text("C - Communication Total"),
            Text("FM - Fine Motor Total"),
            Text("PRS - Problem Solving Total"),
            Text("PNS - Personal Social Total"),
          ],
        ),
      ),
    );
  }
}

class BargraphPage extends StatelessWidget {
  final List<DataItem> chartData;

  const BargraphPage({
    super.key,
    required this.chartData,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double spaceBetween = screenWidth * 0.1;

    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        height: screenHeight * 0.5,
        width: screenWidth,
        child: BarChart(
          BarChartData(
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    List<String> titles = [
                      'G',
                      'C',
                      'FM',
                      'PRS',
                      'PNS'
                    ];
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      child: Text(titles[value.toInt() - 1]),
                    );
                  },
                  reservedSize: 32,
                ),
              ),
            ),
            borderData: FlBorderData(
              border: const Border(
                top: BorderSide.none,
                right: BorderSide.none,
                left: BorderSide(width: 1),
                bottom: BorderSide(width: 1),
              ),
            ),
            groupsSpace: spaceBetween,
            barGroups: chartData.map((dataItem) {
              return BarChartGroupData(
                x: dataItem.x,
                barRods: [
                  BarChartRodData(
                    toY: dataItem.y1,
                    width: 20,
                    color: Colors.amber,
                  ),
                  BarChartRodData(
                    toY: dataItem.y2,
                    width: 20,
                    color: Colors.red,
                  ),
                ],
              );
            }).toList(),
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
