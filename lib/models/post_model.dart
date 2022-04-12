import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? description;
  String? uid;
  String? username;
  final likes;
  String? postId;
  DateTime? datePublished;
  String? postUrl;
  String? profImage;

  PostModel(
      {this.description, this.uid, this.username, this.likes, this.postId, this.datePublished, this.postUrl, this.profImage,});

  factory PostModel.fromMap(map) {
    return PostModel(
      description: map['description'],
      uid: map['uid'],
      username: map['username'],
      likes: map['likes'],
      postId: map['postId'],
      datePublished: map['datePublished'],
      postUrl: map['postUrl'],
      profImage: map['profImage'],
    );
  }
  // sending data to server
  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'uid': uid,
      'username': username,
      'likes': likes,
      'postId': postId,
      'datePublished': datePublished,
      'postUrl': postUrl,
      'profImage': profImage,
    };
  }
}
