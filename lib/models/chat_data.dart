import 'package:cloud_firestore/cloud_firestore.dart';

class MessageChat {
  String idFrom;
  String idTo;
  String timestamp;
  String content;
  String peerUsername;
  String peerProfileImage;

  MessageChat(
      {required this.idFrom,
      required this.idTo,
      required this.timestamp,
      required this.content,
      required this.peerUsername,
      required this.peerProfileImage});

  Map<String, dynamic> toJson() {
    return {
      "idFrom": this.idFrom,
      "idTo": this.idTo,
      "timestamp": this.timestamp,
      "content": this.content,
      "peerUsername": this.peerUsername,
      "peerProfileImage": this.peerProfileImage
    };
  }

  factory MessageChat.fromDocument(DocumentSnapshot doc) {
    String idFrom = doc.get("idFrom");
    String idTo = doc.get("idTo");
    String timestamp = doc.get("timestamp");
    String content = doc.get("content");
    String peerUsername = doc.get("peerUsername");
    String peerProfileImage = doc.get("peerProfileImage");

    return MessageChat(
        idFrom: idFrom,
        idTo: idTo,
        timestamp: timestamp,
        content: content,
        peerUsername: peerUsername,
        peerProfileImage: peerProfileImage);
  }
}
