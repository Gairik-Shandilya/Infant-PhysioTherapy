import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> initializeChat(String userId, String targetUserId) async {
    String chatId;

    QuerySnapshot chatQuery = await _firestore
        .collection('chats')
        .where('participants', arrayContains: userId)
        .get();

    for (var doc in chatQuery.docs) {
      List participants = doc['participants'];
      if (participants.contains(targetUserId)) {
        chatId = doc.id;
        return chatId;
      }
    }

    DocumentReference chatDoc = await _firestore.collection('chats').add({
      'participants': [userId, targetUserId],
      'lastMessage': '',
      'timestamp': FieldValue.serverTimestamp(),
    });

    chatId = chatDoc.id;
    return chatId;
  }

  Future<String> uploadMedia(File file, String chatId) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = _storage.ref().child('chats/$chatId/$fileName');
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
