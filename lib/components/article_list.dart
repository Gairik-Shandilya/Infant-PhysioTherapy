import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ArticleList extends StatefulWidget {
  const ArticleList({super.key});

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController searchbarcontroller = TextEditingController();
  
  Future<String?> _getProfileImageUrl(String doctorId) async {
    try {
      Reference storageReference = FirebaseStorage.instance.ref().child('profile_images/$doctorId.jpg');
      return await storageReference.getDownloadURL();
    } catch (e) {
      print('Error getting profile image URL: $e');
      return null;
    }
  }

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
                  var article = snapshot.data!.docs[index];
                  return FutureBuilder<String?>(
                    future: _getProfileImageUrl(article['doctorId']), // Replace with correct field if different
                    builder: (context, AsyncSnapshot<String?> imageSnapshot) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: ListTile(
                                title: Text(article['title']),
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
                                              Text(article['doctorName']),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text('Content : '),
                                              Text(
                                                  _truncateText(article['content'], 10)),
                                              const Text('....')
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5.0),
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundImage: imageSnapshot.data != null
                                            ? NetworkImage(imageSnapshot.data!)
                                            : const AssetImage('assets/patient2.jpg') as ImageProvider,
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ArticleFullView(
                                        articleDetails: article,
                                      ),
                                    ),
                                  );
                                },
                                tileColor: const Color.fromARGB(255, 218, 209, 239),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                });
          }),
    );
  }
}

class ArticleFullView extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> articleDetails;

  const ArticleFullView({Key? key, required this.articleDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extract data from the QueryDocumentSnapshot
    Map<String, dynamic> data = articleDetails.data() as Map<String, dynamic>;
    Timestamp? timestamp = data['timestamp']; // Assuming data['timestamp'] is of type Timestamp?

    String formattedDateTime = timestamp != null
        ? DateFormat('dd-MM-yyyy HH:mm:ss').format(timestamp.toDate())
        : 'N/A'; // You can customize the date and time format

    return Scaffold(
      appBar: AppBar(
        title: Text(data['title']),
        backgroundColor: const Color.fromARGB(255, 16, 89, 149),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Published By : ${data['doctorName']}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF4A545E),
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Published At : $formattedDateTime',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF4A545E),
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('-----------------------------------------------------------------------------------------'),
            const SizedBox(
              height: 20,
            ),
            Text(
              data['content'],
              textAlign: TextAlign.justify,
              style: const TextStyle(
                color: Color(0xFF4A545E),
                fontSize: 15,
                fontFamily: 'Pacificio',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
