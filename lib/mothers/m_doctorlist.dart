import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:physiotherapy/common/detail_info.dart';
import 'package:physiotherapy/common/profile_image.dart';

class Doctorlist extends StatefulWidget {
  const Doctorlist({super.key});

  @override
  State<Doctorlist> createState() => _DoctorlistState();
}

class _DoctorlistState extends State<Doctorlist> {
  User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController searchbarcontroller = TextEditingController();
  String searchQuery = '';

  Future<String?> _getProfileImageURL(String docId) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('Doctors')
          .doc(docId)
          .get();
      return doc['profileImageURL'];
    } catch (e) {
      print('Error fetching profile image URL: $e');
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    searchbarcontroller.addListener(() {
      setState(() {
        searchQuery = searchbarcontroller.text;
      });
    });
  }

  @override
  void dispose() {
    searchbarcontroller.dispose();
    super.dispose();
  }

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
              'Doctors',
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
                  hintText: 'Search for Doctors',
                  hintStyle: TextStyle(color: Colors.grey[500])),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Doctors')
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

                    var filteredDocs = snapshot.data!.docs.where((doc) {
                      var data = doc.data() as Map<String, dynamic>;
                      var name = data['Name'].toString().toLowerCase();
                      var speciality = data['Speciality'].toString().toLowerCase();
                      var searchLower = searchQuery.toLowerCase();
                      return name.contains(searchLower) || speciality.contains(searchLower);
                    }).toList();

                    return ListView.builder(
                        itemCount: filteredDocs.length,
                        itemBuilder: (context, index) {
                          var doctorData = filteredDocs[index];
                          var docId = doctorData.id;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: Text(doctorData['Name']),
                                  subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Text('Speciality : '),
                                              Text(doctorData['Speciality']),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text('Experience : '),
                                              Text(doctorData['Experience']),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text('Degree : '),
                                              Text(doctorData['Degree']),
                                            ],
                                          ),
                                        ],
                                      ),
                                      FutureBuilder<String?>(
                                        future: _getProfileImageURL(docId),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const CupertinoActivityIndicator();
                                          }
                                          if (snapshot.hasError || !snapshot.hasData) {
                                            return const CircleAvatar(
                                              radius: 40,
                                              backgroundImage: AssetImage(
                                                'assets/patient2.jpg',
                                              ),
                                            );
                                          }
                                          return CircleAvatar(
                                            radius: 40,
                                            backgroundImage: NetworkImage(snapshot.data!),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DoctorDetailPage(
                                          doctorDetails: doctorData,
                                        ),
                                      ),
                                    );
                                  },
                                  tileColor:
                                      const Color.fromARGB(255, 217, 228, 237),
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
