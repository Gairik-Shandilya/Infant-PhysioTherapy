import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:physiotherapy/doctors/d_initialpage.dart';
import 'package:physiotherapy/pages/firebase_options.dart';
import 'package:physiotherapy/mothers/m_intitialpage.dart';
import 'package:physiotherapy/pages/profile_selection.dart';

void main() async {

WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String dropdownvalue = 'English';

  var items = [
    'English',
    'Tamil',
    'Hindi',
  ];

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
      'm_initial':(context)=> const MotherInitialPage(),
      'd_initial':(context)=> const DoctorInitialPage(),
    },
      home: const FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:const Color.fromARGB(255, 16, 89, 149),
        title: const Center(
          child: Text(' Preterm Infants Physiotherapy',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.asset(
                    'assets/Doctor.jpg',
                    height: 150,
                    width: 150,
                  ),
                  const SizedBox(height: 30),
                  const Text("Welcome to our app",
                      style: TextStyle(
                          fontFamily: 'Pacificio',
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                  const SizedBox(height: 30),
                  const Text("Revitalize Your Baby’s Health with Our ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Pacificio',
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                      )),
                  const Text("Physiotherapy Companion",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Pacificio',
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                      )),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const[
                 Text("Choose Language",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Pacificio',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileSelection()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    minimumSize:const Size(100, 50),
                    backgroundColor:const Color.fromARGB(255, 16, 89, 149)),
                child: const Text(
                  "Next",
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
