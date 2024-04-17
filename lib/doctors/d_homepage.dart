import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:physiotherapy/components/article_list.dart';
import 'package:physiotherapy/doctors/d_writearticle.dart';
import 'package:physiotherapy/common/copy_cl.dart';

class Article {
  final String title;
  final String content;

  Article({required this.title, required this.content});
}

class DoctorArticleScreen extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController searchbarcontroller = TextEditingController();

  DoctorArticleScreen({super.key});

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
            Text(doctorUserName,
                style: const TextStyle(
                    fontFamily: 'Pacificio',
                    fontWeight: FontWeight.bold,
                    fontSize: 30)),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Articles',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF4A545E),
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const WriteArticle()),
                    );
                }, icon: const Icon(Icons.edit))
              ],
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
                  hintText: 'Search for Articles',
                  hintStyle: TextStyle(color: Colors.grey[500])),
            ),
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
