import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/screens/story_screen.dart';

class StoryButtonUser extends StatefulWidget {
  final snap;
  const StoryButtonUser({Key? key,required this.snap}) : super(key: key);

  @override
  _StoryButtonUserState createState() => _StoryButtonUserState();
}

class _StoryButtonUserState extends State<StoryButtonUser> {
  String username="";
  String userId="";
  String profImage="";
  bool viewedOnce=false;

  void getUserDetails()async{

    setState(() {
      // username=userSnap.data()!['username']!=null?userSnap.data()!['username']:"";
      // userId=widget.snap.data()['uid'];
      // profImage=userSnap.data()!['photoUrl']!=null?userSnap.data()!['photoUrl']:"";
      username=widget.snap.data()['username']!=null?widget.snap.data()['username']:"";
      userId=widget.snap.data()['uid'];
      profImage=widget.snap.data()['photoUrl']!=null?widget.snap.data()['photoUrl']:"";
    });
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                viewedOnce=true;
              });
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StoryScreen(userId: userId)));
            },
            // child: Container(
            //   width: 68,
            //   height: 68,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(34),
            //           gradient: LinearGradient(
            //               begin: Alignment.topCenter,
            //               end: Alignment.bottomCenter,
            //               colors: AppColors.colorsOfStories)
            //     ),
            //   child: profImage==""?ClipOval(
            //     child: Image.network(profImage,fit: BoxFit.cover,height: 67,width: 67,),
            //   )
            //       :CircleAvatar(
            //     radius: 33.5,
            //     backgroundImage: AssetImage('assets/images/profile_placeholder.jpg'),
            //   )
            // ),

            // child: username==""?CircleAvatar(
            //   child: Container(
            //     decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //                   begin: Alignment.topCenter,
            //                   end: Alignment.bottomCenter,
            //                   colors: AppColors.colorsOfStories)
            //     ),
            //   ),
            //   radius: 33.5,
            //   backgroundImage: NetworkImage('profImage'),
            // )
            //     :CircleAvatar(
            //   child: Container(
            //     decoration: BoxDecoration(
            //         gradient: LinearGradient(
            //             begin: Alignment.topCenter,
            //             end: Alignment.bottomCenter,
            //             colors: AppColors.colorsOfStories)
            //     ),
            //   ),
            //   radius: 33.5,
            //   backgroundImage: AssetImage('assets/images/user_profile_img.png'),
            // ),
            child: Container(
              width: 67,
              height: 67,
              decoration: viewedOnce==false?BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                // border: Border.all(color: colors)),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: AppColors.colorsOfStories))
              :BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: AppColors.colorWhite)),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: AppColors.colorWhite),
                      image: profImage==""?DecorationImage(
                        image: AssetImage('assets/images/profile_placeholder.jpg'),
                        fit: BoxFit.cover
                      ):DecorationImage(
                          image:NetworkImage(profImage),
                          fit: BoxFit.cover)),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(username,style: TextStyle(fontSize: 10,fontFamily: 'Manrope',
                    fontWeight: FontWeight.w400),)),
          )
        ],
      ),
    );
  }
}
