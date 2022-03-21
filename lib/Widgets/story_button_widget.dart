import 'package:flutter/material.dart';
import 'package:matevibes/Widgets/storydata.dart';

Widget storyButton(StoryData story, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(3.0),
    child: Column(
      children: [
        GestureDetector(
          onTap: () {
            print("Story Clicked");
          },
          child: Container(
            width: 67,
            height: 67,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF982282), Color(0xFFEEA863)])),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.white),
                    image: DecorationImage(
                        image:
                            AssetImage('lib/assets/images/login_bgimage.png'),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
        ),
        Center(
          child: Container(
              margin: EdgeInsets.only(top: 5),
              width: 68,
              child: Text(story.username)),
        )
      ],
    ),
  );
}
