import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> initializeChat(String userId, String targetUserId) async {
    String chatId;

    // Check if a chat already exists
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

    // If no chat exists, create a new one
    DocumentReference chatDoc = await _firestore.collection('chats').add({
      'participants': [userId, targetUserId],
      'lastMessage': '',
      'timestamp': FieldValue.serverTimestamp(),
    });

    chatId = chatDoc.id;
    return chatId;
  }
}
