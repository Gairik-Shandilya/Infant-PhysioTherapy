import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:physiotherapy/firestore_services.dart/m_services.dart';

class Article {
  final String title;
  final String content;

  Article({required this.title, required this.content});
}

class WriteArticle extends StatefulWidget {
  const WriteArticle({super.key});

  @override
  State<WriteArticle> createState() => _WriteArticleState();
}

class _WriteArticleState extends State<WriteArticle> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _contentController = TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;

  final TextEditingController searchbarcontroller = TextEditingController();
  late String doctorName = '';
  void initState() {
    super.initState();
    getDoctorName();
    getDoctorName().then((value) {
      setState(() {
        doctorName = value;
      });
    });
  }

  Future<void> _submitArticle() async {
    User? user = _auth.currentUser;

    if (user != null) {
      String userId = user.uid;

      await FirebaseFirestore.instance.collection('articles').add({
        'doctorId': userId,
        'doctorName': doctorName,
        'title': _titleController.text,
        'content': _contentController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Clear text fields after submitting
      _titleController.clear();
      _contentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              
              const Text(
                'Write Your Own Article',
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
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _contentController,
                maxLines: 5,
                decoration: const InputDecoration(labelText: 'Content'),
              ),
              const SizedBox(height: 150.0),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      _submitArticle();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(300, 50),
                        backgroundColor: const Color.fromARGB(255, 16, 89, 149)),
                    child: const Text(
                      'Submit Article',
                      style: TextStyle(fontSize: 20),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
