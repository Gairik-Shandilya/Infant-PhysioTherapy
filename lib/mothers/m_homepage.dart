import 'package:flutter/material.dart';
import 'package:physiotherapy/components/article_list.dart';
import 'package:physiotherapy/models/m_services.dart';

class MotherHomePage extends StatefulWidget {
  const MotherHomePage({super.key});

  @override
  State<MotherHomePage> createState() => _MotherHomePageState();
}

class _MotherHomePageState extends State<MotherHomePage> {
  late String motherName = '';
  final TextEditingController searchbarcontroller=TextEditingController();
  @override
  void initState() {
    super.initState();
    getMotherName();
    getMotherName().then((value) {
      setState(() {
        motherName = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text("Hello 👋",
                style: TextStyle(
                    fontFamily: 'Pacificio',
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            Text(motherName,
                style: const TextStyle(
                    fontFamily: 'Pacificio',
                    fontWeight: FontWeight.bold,
                    fontSize: 30)),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: searchbarcontroller,
              decoration: InputDecoration(
                suffixText: 'Search',
                prefixIcon:const Icon(Icons.search),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                    color: Colors.white,
                  )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  )),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  hintText: 'Search for Articles',
                  hintStyle: TextStyle(color: Colors.grey[500])
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                'Articles',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF4A545E),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),),
        
            const SizedBox(
              height: 20,
            ),
            const ArticleList(),
            
            
          ],
        ),
      ),
    );
  }
}
