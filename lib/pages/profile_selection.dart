import 'package:flutter/material.dart';
import 'package:physiotherapy/auth/register_page.dart';

void main() {
  runApp(
    const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProfileSelection(),
    );
  }
}

class ProfileSelection extends StatefulWidget 
{
  const ProfileSelection({super.key});

  @override
  State<ProfileSelection> createState() => _ProfileSelectionState();
}

class _ProfileSelectionState extends State<ProfileSelection> {
  Color borderColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'PROFILE SELECTION',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF4A545E),
                  fontSize: 25,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return const RegisterPage(isDoctor: false,);
                  })));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:15.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: borderColor, width: 2.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'MOTHER',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Image.asset(
                            'assets/mothersvg.png',
                            height: 200,
                            width: 200,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              GestureDetector(
                
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return const RegisterPage(isDoctor: true,);
                  })));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: borderColor, width: 2.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right:8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/therapistsvg.png',
                            height: 210,
                            width: 200,
                          ),
                          const Text(
                            'THERAPIST',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
