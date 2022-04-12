import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matevibes/Widgets/storage_methods.dart';
import 'package:matevibes/models/post_model.dart';
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
      PostModel post=PostModel(description: description, uid: uid, username: username, likes: [], postId: postId, datePublished: DateTime.now(), postUrl: photoUrl, profImage: profImage);
      
      _firestore.collection('posts').doc(postId).set(post.toMap());
      res=AppString.txtSuccess;
    }catch(err){
      res=err.toString();
    }
    return "";
  }
}