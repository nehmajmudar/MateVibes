import 'package:flutter/material.dart';
import 'package:matevibes/Widgets/story_button_widget.dart';
import 'package:matevibes/Widgets/storydata.dart';
import 'package:matevibes/res/app_string.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<StoryData> stories = [
    new StoryData(
        username: 'Bhargav Dobariya',
        avatarUrl: AssetImage('lib/assets/images/forgot_password_img.png'),
        storyUrl: 'https://unsplash.com/photos/mEZ3PoFGs_k'),
    new StoryData(
        username: 'Bhargav',
        avatarUrl: AssetImage('lib/assets/images/forgot_password_img.png'),
        storyUrl: 'https://unsplash.com/photos/mEZ3PoFGs_k'),
    new StoryData(
        username: 'Bhargav',
        avatarUrl: AssetImage('lib/assets/images/forgot_password_img.png'),
        storyUrl: 'https://unsplash.com/photos/mEZ3PoFGs_k'),
    new StoryData(
        username: 'Bhargav',
        avatarUrl: AssetImage('lib/assets/images/forgot_password_img.png'),
        storyUrl: 'https://unsplash.com/photos/mEZ3PoFGs_k'),
    new StoryData(
        username: 'Bhargav',
        avatarUrl: AssetImage('lib/assets/images/forgot_password_img.png'),
        storyUrl: 'https://unsplash.com/photos/mEZ3PoFGs_k'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Container(
              width: double.infinity,
              height: 150,
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
              ))
        ],
      ),
    ));
  }
}
