import 'dart:io'; // Ensure this import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:physiotherapy/common/copy_cl.dart';
import 'package:physiotherapy/common/edit_profile.dart';
import 'package:physiotherapy/common/faq_about.dart';
import 'package:physiotherapy/common/profile_image.dart';
import 'package:physiotherapy/pages/profile_selection.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({super.key});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  String? profileImageURL;
  late String doctorName = '';
  File? imagefile;

  @override
  void initState() {
    super.initState();
    getDoctorName();
    getDoctorName().then((value) {
      setState(() {
        doctorName = value;
      });
    });
    loadProfileImageURL();
  }

  Future<void> loadProfileImageURL() async {
    profileImageURL = await ImageHandler.loadProfileImageURL(context, 'Doctors');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 89, 149),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CupertinoButton(
                onPressed: () {
                  ImageHandler.showPhotoOptions(context, 'Doctors');
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: (imagefile != null)
                      ? FileImage(imagefile!)
                      : (profileImageURL != null
                          ? NetworkImage(profileImageURL!)
                          : null) as ImageProvider?,
                  child: (imagefile == null && profileImageURL == null)
                      ? const Icon(
                          Icons.person,
                          size: 50,
                        )
                      : null,
                ),
              ),
              Text(doctorName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Pacificio',
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(
                          double.infinity, 50), // Set the height ..as needed
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DoctorProfilePage()));
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.edit,
                        color: Color.fromRGBO(38, 47, 151, 1),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Therapist Profile",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(38, 47, 151, 1),
                        ),
                      ),
                    ],
                  )),
              
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(
                          double.infinity, 50), // Set the height as needed
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutMePage(),
                        ));
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.info,
                        color: Color.fromRGBO(38, 47, 151, 1),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "About Us",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(38, 47, 151, 1),
                        ),
                      ),
                    ],
                  )),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(
                          double.infinity, 50), // Set the height as needed
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DoctorChecklistFAQ()));
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.input,
                        color: Color.fromRGBO(38, 47, 151, 1),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "FAQs",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(38, 47, 151, 1),
                        ),
                      ),
                    ],
                  )),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(
                          double.infinity, 50), // Set the height as needed
                    ),
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: ((context) => const ProfileSelection())));
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.logout,
                        color: Color.fromRGBO(208, 13, 22, 1),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Logout",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(208, 13, 22, 1),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
