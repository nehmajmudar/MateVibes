import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:matevibes/Widgets/posts_card.dart';
import 'package:matevibes/Widgets/story_button_user.dart';
import 'package:matevibes/Widgets/story_button_widget.dart';
import 'package:matevibes/Widgets/storydata.dart';
import 'package:matevibes/Widgets/user_story_create_button.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {

  // List<StoryData> stories = [
  //   new StoryData(
  //       username: 'Bhargav Dobariya',
  //       avatarUrl: AssetImage('assets/images/forgot_password_img.png'),
  //       storyUrl: 'https://unsplash.com/photos/mEZ3PoFGs_k'),
  //   new StoryData(
  //       username: 'Bhargav',
  //       avatarUrl: AssetImage('assets/images/forgot_password_img.png'),
  //       storyUrl: 'https://unsplash.com/photos/mEZ3PoFGs_k'),
  //   new StoryData(
  //       username: 'Bhargav',
  //       avatarUrl: AssetImage('assets/images/forgot_password_img.png'),
  //       storyUrl: 'https://unsplash.com/photos/mEZ3PoFGs_k'),
  //   new StoryData(
  //       username: 'Bhargav',
  //       avatarUrl: AssetImage('assets/images/forgot_password_img.png'),
  //       storyUrl: 'https://unsplash.com/photos/mEZ3PoFGs_k'),
  //   new StoryData(
  //       username: 'Bhargav',
  //       avatarUrl: AssetImage('assets/images/forgot_password_img.png'),
  //       storyUrl: 'https://unsplash.com/photos/mEZ3PoFGs_k'),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.colorBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                color: AppColors.colorBackgroundColor,
                width: double.infinity,
                height: 100,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('users').where('storyIds', isNull: false).snapshots(),
                  builder: (context,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (ctx,index){
                        return StoryButtonUser(snap: snapshot.data!.docs[index]);
                      },
                    );
                  }
                ),
              ),
              // Container(
              //     width: double.infinity,
              //     height: 150,
              //     margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/36.7),
              //     child: ListView(
              //       scrollDirection: Axis.horizontal,
              //       children: [
              //         storyButton(stories[0], context),
              //         storyButton(stories[1], context),
              //         storyButton(stories[2], context),
              //         storyButton(stories[3], context),
              //         storyButton(stories[4], context),
              //         storyButton(stories[4], context),
              //         storyButton(stories[4], context),
              //         storyButton(stories[4], context),
              //         storyButton(stories[4], context),
              //       ],
              //     )
              // ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('posts').snapshots(),
                  builder: (context,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder:(ctx,index)=>Container(
                        child: PostsCard(snap: snapshot.data!.docs[index]),
                      ),
                    );
                  }
                ),
              ),
              // Card(
              //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              //   elevation: 2,
              //   color: AppColors.colorWhite,
              //   margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/26,right: MediaQuery.of(context).size.width/26,bottom: MediaQuery.of(context).size.height/76.72),
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width/26,horizontal: MediaQuery.of(context).size.height/56.26),
              //     child: Column(
              //       children: [
              //         Row(
              //           children: [
              //             CircleAvatar(
              //               backgroundImage: AssetImage('lib/assets/images/user_profile_img.png'),
              //             ),
              //             Column(
              //               children: [
              //                 Container(
              //                   margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/19.5),
              //                   child: Text(AppString.txtUsername,style: TextStyle(
              //                       fontSize: 14,
              //                       color: AppColors.colorLetsGetStarted,
              //                       fontWeight: FontWeight.w600,
              //                       fontFamily: 'Manrope'),),
              //                 ),
              //                 Container(
              //                   margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/19.5),
              //                   child: Text(AppString.txtTimeExample,style: TextStyle(
              //                       fontSize: 11,
              //                       color: AppColors.colorTimeOfPost,
              //                       fontWeight: FontWeight.w300,
              //                       fontFamily: 'Manrope'),),
              //                 )
              //               ],
              //             ),
              //           ],
              //         ),
              //         Container(
              //           margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/64.92,bottom: MediaQuery.of(context).size.height/31.25),
              //           child: Text(AppString.txtLoremIpsum,softWrap:true,maxLines:10,style: TextStyle(
              //               fontSize: 11,
              //               color: AppColors.colorBlack,
              //               fontWeight: FontWeight.w800,
              //               fontFamily: 'Manrope'),),
              //         ),
              //         StaggeredGrid.count(
              //           crossAxisCount: 2,
              //           crossAxisSpacing: 2,
              //           mainAxisSpacing: 2,
              //           children: [
              //             StaggeredGridTile.count(crossAxisCellCount: 1, mainAxisCellCount: 2, child: Image(image: AssetImage('lib/assets/images/forgot_password_img.png'),fit: BoxFit.fill,)),
              //             StaggeredGridTile.count(crossAxisCellCount: 1, mainAxisCellCount: 1, child: Image(image: AssetImage('lib/assets/images/MateVibes_logo.png'),fit: BoxFit.fill,)),
              //             StaggeredGridTile.count(crossAxisCellCount: 1, mainAxisCellCount: 1, child: Opacity(opacity: 0.3,child: Image(image: AssetImage('lib/assets/images/MateVibes_logo.png'),fit: BoxFit.fill,),))
              //           ],
              //         ),
              //         Container(
              //           height: 1,
              //           margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/31.25,bottom: MediaQuery.of(context).size.height/65.57),
              //           width: MediaQuery.of(context).size.width/1.25,
              //           color: AppColors.colorHintText,
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border_sharp),color: AppColors.colorTimeOfPost,iconSize: 12,),
              //             Container(
              //               margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/65.32,right: MediaQuery.of(context).size.width/17.83),
              //               child: Text("1.2k",style: TextStyle(
              //                   fontSize: 12,
              //                   color: AppColors.colorTimeOfPost,
              //                   fontWeight: FontWeight.w300,
              //                   fontFamily: 'Manrope'),),
              //             ),
              //             IconButton(onPressed: (){}, icon: Icon(Icons.messenger_outline_sharp),color: AppColors.colorTimeOfPost,iconSize: 12),
              //             Container(
              //               margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/65.32,right: MediaQuery.of(context).size.width/4.875),
              //               child: Text("80",style: TextStyle(
              //                   fontSize: 12,
              //                   color: AppColors.colorTimeOfPost,
              //                   fontWeight: FontWeight.w300,
              //                   fontFamily: 'Manrope'),),
              //             ),
              //             IconButton(onPressed: (){}, icon: Icon(Icons.star_border_sharp),color: AppColors.colorTimeOfPost,iconSize: 12),
              //             IconButton(onPressed: (){}, icon: Icon(Icons.share_sharp),color: AppColors.colorTimeOfPost,iconSize: 12),
              //           ],
              //         )
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        )
    );
  }
}
