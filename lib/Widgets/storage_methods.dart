import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // String uid="";
  //
  // void getUserid()async{
  //   DocumentSnapshot snap= await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
  //
  //   setState(() {
  //     uid=(snap.data() as Map<String, dynamic>)['uid'];
  //   });
  // }

  // adding image to firebase storage
  Future<String> uploadImageToStorage(String childName, Uint8List file, bool isPost) async {
    // creating location to our firebase storage

    // String imagePath = new String.fromCharCodes(file);
    // File imageFile=File.fromRawPath(file);
    // File imagePath=File(imageFile.path);


    String currentUserUid=_auth.currentUser!.uid;
    String id = const Uuid().v1();
    final ref =
    _storage.ref('posts/$currentUserUid/$id');


    print(_auth.currentUser!.uid);
    print(id);
    // putting in uint8list format -> Upload task like a future but not future
    UploadTask uploadTask = ref.putData(file);

    // String _imagePath=imagePath.toString();
    // print(_imagePath);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    print(downloadUrl);
    return downloadUrl;
  }

  Future<String> uploadStoryToStorage(String childName, Uint8List file, bool isPost) async {
    // creating location to our firebase storage

    // String imagePath = new String.fromCharCodes(file);
    // File imageFile=File.fromRawPath(file);
    // File imagePath=File(imageFile.path);


    String currentUserUid=_auth.currentUser!.uid;
    String id = const Uuid().v1();
    final ref =
    _storage.ref('stories/$currentUserUid/$id');


    print(_auth.currentUser!.uid);
    print(id);
    // putting in uint8list format -> Upload task like a future but not future
    UploadTask uploadTask = ref.putData(file);

    // String _imagePath=imagePath.toString();
    // print(_imagePath);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    print(downloadUrl);
    return downloadUrl;
  }


  Future<String> uploadProfileImageToStorage(String childName, Uint8List file, bool isPost) async {
    // creating location to our firebase storage

    // String imagePath = new String.fromCharCodes(file);
    // File imageFile=File.fromRawPath(file);
    // File imagePath=File(imageFile.path);


    String currentUserUid=_auth.currentUser!.uid;
    String id = const Uuid().v1();
    final ref =
    _storage.ref('profilePics/$currentUserUid/$id');


    print(_auth.currentUser!.uid);
    print(id);
    // putting in uint8list format -> Upload task like a future but not future
    UploadTask uploadTask = ref.putData(file);

    // String _imagePath=imagePath.toString();
    // print(_imagePath);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    print(downloadUrl);
    return downloadUrl;
  }

  Future<String> uploadCoverImageToStorage(String childName, Uint8List file, bool isPost) async {
    // creating location to our firebase storage

    // String imagePath = new String.fromCharCodes(file);
    // File imageFile=File.fromRawPath(file);
    // File imagePath=File(imageFile.path);


    String currentUserUid=_auth.currentUser!.uid;
    String id = const Uuid().v1();
    final ref =
    _storage.ref('userCoverPics/$currentUserUid/$id');


    print(_auth.currentUser!.uid);
    print(id);
    // putting in uint8list format -> Upload task like a future but not future
    UploadTask uploadTask = ref.putData(file);

    // String _imagePath=imagePath.toString();
    // print(_imagePath);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    print(downloadUrl);
    return downloadUrl;
  }
}
