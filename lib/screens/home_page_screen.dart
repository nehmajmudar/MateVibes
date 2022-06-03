import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/Widgets/posts_card.dart';
import 'package:matevibes/Widgets/story_button_user.dart';

import 'package:matevibes/res/app_colors.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackgroundColor,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsSelected) {
            return <Widget>[
              SliverAppBar(
                  backgroundColor: AppColors.colorWhite,
                  expandedHeight: MediaQuery.of(context).size.height / 7.381,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                        color: AppColors.colorBackgroundColor,
                        width: double.infinity,
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .where('storyIds', isNull: false)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<
                                        QuerySnapshot<Map<String, dynamic>>>
                                    snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (ctx, index) {
                                  if(index==0){
                                    return StoryButtonUser(snap: snapshot.data!.docs[index],index: index);
                                  }
                                  else if(index==1){
                                    return Container(
                                      //Divider
                                      height: 20,
                                      width: 2,
                                      margin: EdgeInsets.only(
                                          top: 5,
                                          bottom: 13,
                                          left: 5,
                                          right: 5),
                                      color: AppColors.colorSkipforNow,
                                    );
                                  }
                                  else{
                                    return StoryButtonUser(
                                        snap: snapshot.data!.docs[index],index: index,);
                                  }
                                },
                              );
                            })),
                  ))
            ];
          },
          body: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('posts').snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
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
      ),
    );
  }
}
