import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:physiotherapy/mothers/m_doctordetail.dart';

class ArticleList extends StatefulWidget {
  const ArticleList({super.key});

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController searchbarcontroller = TextEditingController();
  String _truncateText(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  } else {
    return text.substring(0, maxLength);
  }
}
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('articles').snapshots(),
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
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: ListTile(
                            title: Text(snapshot.data!.docs[index]['title']),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text('Doctor : '),
                                          Text(snapshot.data!.docs[index]
                                              ['doctorName']),
                                        ],
                                      ),
                                      
                                      Row(
                                        children: [
                                          const Text('content : '),
                                          
                                          Text('${_truncateText(snapshot.data!.docs[index]
                                              ['content'],10)}'),
                                              Text('....')
                                               
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5.0),
                                  child: CircleAvatar(
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
                                    doctorDetails: snapshot.data!.docs[index],
                                  ),
                                ),
                              );
                            },
                            tileColor:Color.fromARGB(255, 218, 209, 239),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
