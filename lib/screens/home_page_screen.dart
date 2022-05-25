import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/Widgets/posts_card.dart';
import 'package:matevibes/Widgets/story_button_widget.dart';
import 'package:matevibes/Widgets/storydata.dart';
import 'package:matevibes/res/app_colors.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List<StoryData> stories = [
    new StoryData(
        username: 'Bhargav Dobariya',
        avatarUrl: AssetImage('assets/images/forgot_password_img.png'),
        storyUrl: 'https://unsplash.com/photos/mEZ3PoFGs_k'),
    new StoryData(
        username: 'Bhargav',
        avatarUrl: AssetImage('assets/images/forgot_password_img.png'),
        storyUrl: 'https://unsplash.com/photos/mEZ3PoFGs_k'),
    new StoryData(
        username: 'Bhargav',
        avatarUrl: AssetImage('assets/images/forgot_password_img.png'),
        storyUrl: 'https://unsplash.com/photos/mEZ3PoFGs_k'),
    new StoryData(
        username: 'Bhargav',
        avatarUrl: AssetImage('assets/images/forgot_password_img.png'),
        storyUrl: 'https://unsplash.com/photos/mEZ3PoFGs_k'),
    new StoryData(
        username: 'Bhargav',
        avatarUrl: AssetImage('assets/images/forgot_password_img.png'),
        storyUrl: 'https://unsplash.com/photos/mEZ3PoFGs_k'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.colorBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                  width: double.infinity,
                  height: 150,
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height / 36.7),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      storyButton(stories[0], context),
                      storyButton(stories[1], context),
                      storyButton(stories[2], context),
                      storyButton(stories[3], context),
                      storyButton(stories[4], context),
                      storyButton(stories[4], context),
                      storyButton(stories[4], context),
                      storyButton(stories[4], context),
                      storyButton(stories[4], context),
                    ],
                  )),
              Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('posts')
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (ctx, index) => Container(
                          child: PostsCard(snap: snapshot.data!.docs[index]),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
