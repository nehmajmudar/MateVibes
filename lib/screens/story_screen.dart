import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/Widgets/story_view_widget.dart';
import 'package:story_view/story_view.dart';

class StoryScreen extends StatefulWidget {
  final String userId;
  const StoryScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  StoryController storyController = StoryController();

  @override
  void initState() {
    super.initState();
    // getUserDetails();
  }

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(storyIdNo);
    // print(storyIds);
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('stories')
              .where('uid', isEqualTo: widget.userId)
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
