import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? email;
  String? username;
  String? phoneNumber;
  String? photoUrl;
  String? coverPhotoUrl;
  String? bio;
  String? displayName;
  String? gender;
  final followers;
  final following;
  final storyIds;


  UserModel({this.uid, this.email, this.username, this.phoneNumber, this.photoUrl, this.coverPhotoUrl, this.bio, this.displayName, this.gender, this.followers, this.following, this.storyIds});

  //receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'] ?? " ",
      email: map['email'] ?? " ",
      username: map['username'] ?? " ",
      phoneNumber: map['phoneNumber'] ?? " ",
      photoUrl: map['photoUrl'] ?? " ",
      coverPhotoUrl: map['coverPhotoUrl'] ?? " ",
      bio: map['bio'] ?? " ",
      displayName: map['displayName'] ?? " ",
      gender: map['gender'] ?? " ",
      followers: map['followers'] ?? " ",
      following: map['following'] ?? " ",
      storyIds: map['storyIds'] ?? " ",
    );
  }
  // sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'coverPhotoUrl': coverPhotoUrl,
      'bio': bio,
      'displayName': displayName,
      'gender': gender,
      'followers': followers,
      'following': following,
      'storyIds': storyIds,
    };
  }
  //
  // static UserModel fromSnap(DocumentSnapshot snap){
  //   var snapshot=snap.data() as Map<String, dynamic>;
  //    return UserModel(
  //      uid: snapshot['uid'],
  //      email: snapshot['email'],
  //      username: snapshot['username'],
  //      phoneNumber: snapshot['phineNumber'],
  //    );
  // }
}
