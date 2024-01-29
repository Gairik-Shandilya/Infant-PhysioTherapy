import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:physiotherapy/mothers/m_doctordetail.dart';

class Motherlist extends StatefulWidget {
  const Motherlist({super.key});

  @override
  State<Motherlist> createState() => _MotherlistState();
}

class _MotherlistState extends State<Motherlist> {
  User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController searchbarcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Patients',
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
            TextField(
              controller: searchbarcontroller,
              decoration: InputDecoration(
                  suffixText: 'Search',
                  prefixIcon: const Icon(Icons.search),
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
                  hintText: 'Search for Infants',
                  hintStyle: TextStyle(color: Colors.grey[500])),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Mothers')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CupertinoActivityIndicator();
                    }
                    if (snapshot.data!.docs.isEmpty) {
                      return const Text('No data found');
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical:10.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: ListTile(
                                    title:
                                        Text(snapshot.data!.docs[index]['MotherName']),
                                    subtitle: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Text('InfantName : '),
                                                Text(snapshot.data!.docs[index]
                                                    ['InfantName']),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text('Gender : '),
                                                Text(snapshot.data!.docs[index]
                                                    ['Gender']),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text('DateofBirth : '),
                                                Text(snapshot.data!.docs[index]
                                                    ['DateofBirth']),
                                              ],
                                            ),
                                          ],
                                        ),
                                         Padding(
                                          padding:  EdgeInsets.only(bottom:5.0),
                                          child:  CircleAvatar(
                                            radius: 40,
                                            backgroundImage: AssetImage(
                                              'assets/patient2.jpg',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DoctorDetailPage(
                                            doctorDetails:
                                                snapshot.data!.docs[index],
                                          ),
                                        ),
                                      );
                                    },
                                    tileColor: const Color.fromARGB(255, 217, 228, 237),
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  }),
            )
          ],
        ),
      )),
    );
  }
}
