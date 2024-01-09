import 'package:flutter/material.dart';
import 'package:physiotherapy/firestore_services.dart/m_services.dart';
import 'package:physiotherapy/pages/m_articles.dart';

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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) {
                      return const ArticlePage();
                    })));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:15.0),
                    child: Card(
                      shadowColor: Colors.amberAccent,
                      surfaceTintColor: Colors.blueGrey,
                      color: const Color.fromARGB(255, 218, 209, 239),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(color: Colors.black, width: 1.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:  [
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Special exercises and stretching movements',
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    'Dr. Tania Malhotra',
                                    style: TextStyle(
                                        fontSize: 16,),
                                  ),
                                ],
                              ),
                            ),
                            const Expanded(
                              flex: 1,
                              child: CircleAvatar(radius: 50,backgroundImage: AssetImage(
                                'assets/patient2.jpg',
                              ),),
                            )
                            
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) {
                      return const ArticlePage();
                    })));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:15.0),
                    child: Card(
                      shadowColor: Colors.amberAccent,
                      surfaceTintColor: Colors.blueGrey,
                      color: const Color.fromARGB(255, 218, 209, 239),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(color: Colors.black, width: 1.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:  [
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Special exercises and stretching movements',
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    'Dr. Tania Malhotra',
                                    style: TextStyle(
                                        fontSize: 16,),
                                  ),
                                ],
                              ),
                            ),
                            const Expanded(
                              flex: 1,
                              child: CircleAvatar(radius: 50,backgroundImage: AssetImage(
                                'assets/patient2.jpg',
                              ),),
                            )
                            
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) {
                      return  const ArticlePage();
                    })));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:15.0),
                    child: Card(
                      shadowColor: Colors.amberAccent,
                      surfaceTintColor: Colors.blueGrey,
                      color:const Color.fromARGB(255, 218, 209, 239),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side:const BorderSide(color: Colors.black, width: 1.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:  [
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Special exercises and stretching movements',
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    'Dr. Tania Malhotra',
                                    style: TextStyle(
                                        fontSize: 16,),
                                  ),
                                ],
                              ),
                            ),
                            const Expanded(
                              flex: 1,
                              child: CircleAvatar(radius: 50,backgroundImage: AssetImage(
                                'assets/patient2.jpg',
                              ),),
                            )
                            
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return const ArticlePage();
                  })));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:15.0),
                  child: Card(
                    shadowColor: Colors.amberAccent,
                    surfaceTintColor: Colors.blueGrey,
                    color:const Color.fromARGB(255, 218, 209, 239),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side:const BorderSide(color: Colors.black, width: 1.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:  [
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Special exercises and stretching movements',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  'Dr. Tania Malhotra',
                                  style: TextStyle(
                                      fontSize: 16,),
                                ),
                              ],
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: CircleAvatar(radius: 50,backgroundImage: AssetImage(
                              'assets/patient2.jpg',
                            ),),
                          )
                          
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
            
          ],
        ),
      ),
    );
  }
}
