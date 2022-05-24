import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/Widgets/story_view_widget.dart';
import 'package:story_view/story_view.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({Key? key}) : super(key: key);

  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  StoryController storyController = StoryController();

  String userId = "";
  String profImage = "";
  String storyUrl = "";
  // bool hasStory=false;
  String storyId = "";
  List storyIds = [];
  int storyIdNo = 0;
  final storyItems = <StoryItem>[];

  void addItems() {}

  void getUserDetails() async {
    var snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
 
    setState(() {
      profImage =
          snap.data()!['photoUrl'] != null ? snap.data()!['photoUrl'] : "";
  
    });
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('stories')
              .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            return StoryViewWidget(snap: snapshot.data!.docs);
          }),
    );
  }
}
