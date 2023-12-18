import 'package:flutter/material.dart';

class MotherHomePage extends StatefulWidget {
  const MotherHomePage({super.key});

  @override
  State<MotherHomePage> createState() => _MotherHomePageState();
}

class _MotherHomePageState extends State<MotherHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [Text('MOTHER HOME PAGE')],
      )),
    );
  }
}
