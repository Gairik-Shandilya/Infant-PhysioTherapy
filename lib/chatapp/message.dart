class Message {
  final String sender;
  final String text;
  final String? mediaUrl; // URL of the media file
  final String? mediaType; // Type of the media file (image, video)

  Message({required this.sender, required this.text, this.mediaUrl, this.mediaType});
}
