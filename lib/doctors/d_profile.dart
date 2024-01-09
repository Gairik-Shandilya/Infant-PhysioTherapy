import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:physiotherapy/firestore_services.dart/m_services.dart';
import 'package:physiotherapy/pages/profile_selection.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({super.key});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
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
  }

  void selectImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      cropImage(pickedFile);
    }
  }

  void cropImage(XFile file) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        compressQuality: 20,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        sourcePath: file.path);
    if (croppedFile != null) {
      File? croppedImage = File(croppedFile.path);
      if (croppedImage != null) {
        setState(() {
          imagefile = croppedImage as File;
          
        });
      try {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    Reference storageReference =
        FirebaseStorage.instance.ref().child('profile_images/$uid.jpg');

    // Upload the file to Cloud Storage
    UploadTask uploadTask = storageReference.putFile(croppedImage);

    // Get the download URL when the upload is complete
    String downloadURL =
        await (await uploadTask).ref.getDownloadURL();

    // Save the download URL to Firestore
    await FirebaseFirestore.instance
        .collection('Doctors') // Replace with your collection name
        .doc(uid) // Replace with the document ID (typically the user's UID)
        .update({'profileImageURL': downloadURL});

    print('Profile image uploaded successfully!');
  } catch (error) {
    print('Error uploading profile image: $error');
  }
      }
    }
  }

  void showPhotoOptions() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Upload Profile Picture"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    selectImage(ImageSource.gallery);
                  },
                  leading: const Icon(Icons.browse_gallery),
                  title: const Text("Select from Gallery"),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    selectImage(ImageSource.camera);
                  },
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Take a photo"),
                )
              ],
            ),
          );
        });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromRGBO(38, 47, 151, 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CupertinoButton(
                onPressed: () {
                  showPhotoOptions();
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      (imagefile != null) ? FileImage(imagefile!) : null,
                  child: (imagefile == null)
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
                      const Size(double.infinity, 50), // Set the height ..as needed
                    ),
                  ),
                  onPressed: () {},
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
                      const Size(double.infinity, 50), // Set the height as needed
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Icon(
                        Icons.notifications,
                        color: Color.fromRGBO(38, 47, 151, 1),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Notifications",
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
                      Size(double.infinity, 50), // Set the height as needed
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Icon(
                        Icons.settings,
                        color: Color.fromRGBO(38, 47, 151, 1),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Settings",
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
                      Size(double.infinity, 50), // Set the height as needed
                    ),
                  ),
                  onPressed: () {},
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
                  onPressed: () {},
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
                      Size(double.infinity, 50), // Set the height as needed
                    ),
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: ((context) => ProfileSelection())));
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
