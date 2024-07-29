import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:photo_view/photo_view.dart';
import 'chat_service.dart';

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
  final ChatService _chatService = ChatService();

  @override
  void initState() {
    super.initState();
    _updateSeenStatus();
  }

  void _updateSeenStatus() async {
    User? user = _auth.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('chats')
          .doc(widget.chatId)
          .collection('messages')
          .where('senderId', isNotEqualTo: user.uid)
          .where('seen', isEqualTo: false)
          .get()
          .then((snapshot) {
        for (var doc in snapshot.docs) {
          doc.reference.update({'seen': true});
        }
      }).catchError((error) {
        print('Error updating seen status: $error');
      });
    }
  }

  void _sendMessage({String? mediaUrl, String? mediaType}) async {
    if (_messageController.text.isEmpty && mediaUrl == null) return;

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
        'seen': false,
        'mediaUrl': mediaUrl,
        'mediaType': mediaType,
      });

      _messageController.clear();
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      String mediaUrl = await _chatService.uploadMedia(File(image.path), widget.chatId);
      _sendMessage(mediaUrl: mediaUrl, mediaType: 'image');
    }
  }

  Future<void> _pickVideo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);

    if (video != null) {
      String mediaUrl = await _chatService.uploadMedia(File(video.path), widget.chatId);
      _sendMessage(mediaUrl: mediaUrl, mediaType: 'video');
    }
  }

  void _openFullScreenImage(String imageUrl) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: PhotoView(
            imageProvider: NetworkImage(imageUrl),
          ),
        ),
      );
    }));
  }

  void _openFullScreenVideo(String videoUrl) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return Scaffold(
        
        body: Center(
          child: VideoPlayerScreen(videoUrl: videoUrl),
        ),
      );
    }));
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

                    bool isMe = messageData['senderId'] == _auth.currentUser!.uid;
                    bool seen = messageData['seen'] ?? false;

                    return _buildMessage(
                      messageData['text'],
                      isMe,
                      seen,
                      messageData['mediaUrl'],
                      messageData['mediaType'],
                    );
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

  Widget _buildMessage(
    String message,
    bool isMe,
    bool seen,
    String? mediaUrl,
    String? mediaType,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (mediaUrl != null)
            mediaType == 'image'
                ? GestureDetector(
                    onTap: () => _openFullScreenImage(mediaUrl),
                    child: Image.network(mediaUrl, width: 150, height: 150, fit: BoxFit.cover),
                  )
                : GestureDetector(
                    onTap: () => _openFullScreenVideo(mediaUrl),
                    child: Container(
                      width: 150,
                      height: 150,
                      color: Colors.black,
                      child: Center(
                        child: Icon(Icons.play_arrow, color: Colors.white),
                      ),
                    ),
                  ),
          Container(
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
                if (isMe && seen)
                  const Icon(
                    Icons.check,
                    size: 16,
                    color: Colors.white,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageComposer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.photo),
            onPressed: _pickImage,
            color: const Color.fromARGB(255, 16, 89, 149),
          ),
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: _pickVideo,
            color: const Color.fromARGB(255, 16, 89, 149),
          ),
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
            onPressed: () => _sendMessage(),
            color: const Color.fromARGB(255, 16, 89, 149),
          ),
        ],
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerScreen({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying ? _controller.pause() : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
