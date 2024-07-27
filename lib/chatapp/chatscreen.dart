import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String name;

  const ChatScreen({Key? key, required this.chatId, required this.name})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _updateSeenStatus();
  }

  void _updateSeenStatus() async {
    User? user = _auth.currentUser;
    if (user != null) {
      print('Updating seen status for user: ${user.uid}');
      
      FirebaseFirestore.instance
          .collection('chats')
          .doc(widget.chatId)
          .collection('messages')
          .where('senderId', isNotEqualTo: user.uid) // Only update messages sent by the other user
          .where('seen', isEqualTo: false)
          .get()
          .then((snapshot) {
        print('Found ${snapshot.docs.length} messages to update');
        
        for (var doc in snapshot.docs) {
          doc.reference.update({'seen': true});
          print('Updated seen for message: ${doc.id}');
        }
      }).catchError((error) {
        print('Error updating seen status: $error');
      });
    }
  }

  void _sendMessage() async {
    if (_messageController.text.isEmpty) return;

    User? user = _auth.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(widget.chatId)
          .collection('messages')
          .add({
        'text': _messageController.text,
        'senderId': user.uid,
        'timestamp': FieldValue.serverTimestamp(),
        'seen': false, // Initialize seen to false
      });

      print('Message sent with seen set to false');
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: const Color.fromARGB(255, 16, 89, 149),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(widget.chatId)
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                var messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index];
                    var messageData = message.data() as Map<String, dynamic>;

                    if (!messageData.containsKey('senderId')) {
                      // If senderId does not exist, skip the message
                      return Container();
                    }

                    bool isMe = messageData['senderId'] == _auth.currentUser!.uid;
                    bool seen = messageData['seen'] ?? false;

                    print('Message data: $messageData');
                    return _buildMessage(messageData['text'], isMe, seen);
                  },
                );
              },
            ),
          ),
          _buildMessageComposer(),
        ],
      ),
    );
  }

  Widget _buildMessage(String message, bool isMe, bool seen) {
    print('Building message: $message, isMe: $isMe, seen: $seen');
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
            if (isMe && seen) // Show seen indicator for sent messages
              const Icon(
                Icons.check,
                size: 16,
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageComposer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _sendMessage,
            color: const Color.fromARGB(255, 16, 89, 149),
          ),
        ],
      ),
    );
  }
}
