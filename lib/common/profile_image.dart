import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageHandler {
  static Future<String?> loadProfileImageURL(BuildContext context, String collectionName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cachedURL = prefs.getString('profileImageURL');

    if (cachedURL != null) {
      return cachedURL;
    } else {
      return await fetchProfileImageURL(context, collectionName);
    }
  }

  static Future<String?> fetchProfileImageURL(BuildContext context, String collectionName) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(uid)
          .get();

      String url = snapshot['profileImageURL'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('profileImageURL', url);

      return url;
    } catch (error) {
      print('Error fetching profile image URL: $error');
      return null;
    }
  }

  static Future<void> uploadProfileImage(BuildContext context, String collectionName, File imagefile) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      Reference storageReference =
          FirebaseStorage.instance.ref().child('profile_images/$uid.jpg');

      UploadTask uploadTask = storageReference.putFile(imagefile);

      String downloadURL = await (await uploadTask).ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(uid)
          .update({'profileImageURL': downloadURL});

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('profileImageURL', downloadURL);

      print('Profile image uploaded and cached successfully!');
    } catch (error) {
      print('Error uploading profile image: $error');
    }
  }

  static Future<File?> cropImage(XFile file) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        compressQuality: 20,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        sourcePath: file.path);
    if (croppedFile != null) {
      return File(croppedFile.path);
    }
    return null;
  }

  static Future<void> selectImage(BuildContext context, String collectionName, ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      File? croppedImage = await cropImage(pickedFile);
      if (croppedImage != null) {
        await uploadProfileImage(context, collectionName, croppedImage);
      }
    }
  }

  static void showPhotoOptions(BuildContext context, String collectionName) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Upload Profile Picture"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    selectImage(context, collectionName, ImageSource.gallery);
                  },
                  leading: const Icon(Icons.browse_gallery),
                  title: const Text("Select from Gallery"),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    selectImage(context, collectionName, ImageSource.camera);
                  },
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Take a photo"),
                )
              ],
            ),
          );
        });
  }
}
