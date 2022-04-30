import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:matevibes/Widgets/storage_methods.dart';
import 'package:matevibes/models/post_model.dart';
import 'package:matevibes/models/user_model.dart';
import 'package:matevibes/res/app_string.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;


  Future<String> uploadPost(
      String description,
      Uint8List file,
      String uid,
      String username,
      String profImage,
      )async{
    String res=AppString.txtSomeErrorOccurred;

    try{
      String photoUrl=await StorageMethods().uploadImageToStorage('posts',file,true);
      String postId=Uuid().v1();
      print(photoUrl);
      print(postId);
      PostModel post=PostModel(description: description, uid: uid, username: username, likes: [], postId: postId, datePublished: DateTime.now(), postUrl: photoUrl, profImage: profImage);
      
      _firestore.collection('posts').doc(postId).set(post.toMap());
      res=AppString.txtSuccess;
      return res;
    }catch(err){
      res=err.toString();
    }
    return "";
  }



  Future<String> insertMoreUserDetails({
    required String displayName,
    required String userName,
    required String phoneNumber,
    required String userBio,
    required String userGender,
    required Uint8List coverImage,
    required Uint8List profileImage,
  }) async{
    String res = "Some error Occurred";
    try{
      String profilePhotoUrl = await StorageMethods().uploadProfileImageToStorage('profilePics', profileImage, false);
      String userCoverPhotoUrl = await StorageMethods().uploadCoverImageToStorage('userCoverPics', coverImage, false);

      UserModel _user=UserModel(
        uid: FirebaseAuth.instance.currentUser!.uid,
        email: FirebaseAuth.instance.currentUser!.email,
        username: userName,
        phoneNumber: phoneNumber,
        photoUrl: profilePhotoUrl,
        coverPhotoUrl: userCoverPhotoUrl,
        displayName: displayName,
        bio: userBio,
        gender: userGender,
      );

      await _firestore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set(_user.toMap());

      res=AppString.txtSuccess;
    }catch(err){
      return err.toString();
    }
    return res;

  }

  Future<void> likePost(String postId, String uid, List likes)async{
    try{
      if(likes.contains(uid)){
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      }
      else{
       await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    }catch(e){
      print(e.toString());
    }
  }
}