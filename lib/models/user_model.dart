import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? email;
  String? username;
  String? phoneNumber;
  String? photoUrl;
  String? bio;
  List? followers;
  List? following;


  UserModel({this.uid, this.email, this.username, this.phoneNumber, this.photoUrl, this.bio, this.followers, this.following});

  //receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      username: map['username'],
      phoneNumber: map['phoneNumber'],
      photoUrl: map['photoUrl'],
      bio: map['bio'],
      followers: map['followers'],
      following: map['following'],
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
      'bio': bio,
      'followers': followers,
      'following': following,
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
