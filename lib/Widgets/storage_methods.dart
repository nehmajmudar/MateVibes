import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // adding image to firebase storage
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    String currentUserUid = _auth.currentUser!.uid;
    String id = const Uuid().v1();
    final ref = _storage.ref('posts/$currentUserUid/$id');

    // putting in uint8list format -> Upload task like a future but not future
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String> uploadStoryToStorage(
      String childName, Uint8List file, bool isPost) async {
    String currentUserUid = _auth.currentUser!.uid;
    String id = const Uuid().v1();
    final ref = _storage.ref('stories/$currentUserUid/$id');

    // putting in uint8list format -> Upload task like a future but not future
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String> uploadProfileImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    String currentUserUid = _auth.currentUser!.uid;
    String id = const Uuid().v1();
    final ref = _storage.ref('profilePics/$currentUserUid/$id');

    // putting in uint8list format -> Upload task like a future but not future
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String> uploadCoverImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    String currentUserUid = _auth.currentUser!.uid;
    String id = const Uuid().v1();
    final ref = _storage.ref('userCoverPics/$currentUserUid/$id');

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }
}
