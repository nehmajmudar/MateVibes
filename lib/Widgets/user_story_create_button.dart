// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:matevibes/Widgets/story_type_selection_dialogue.dart';
// import 'package:matevibes/res/app_colors.dart';
// import 'package:matevibes/screens/story_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class UserStoryCreateButton extends StatefulWidget {
//   const UserStoryCreateButton({Key? key}) : super(key: key);
//
//   @override
//   _UserStoryCreateButtonState createState() => _UserStoryCreateButtonState();
// }
//
// class _UserStoryCreateButtonState extends State<UserStoryCreateButton> {
//
//   String userId="";
//   String profImage="";
//   // bool hasStory=false;
//   String storyId="";
//
//   void getUserDetails()async{
//     var snap=await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
//     var snapStoryRef=await FirebaseFirestore.instance.collection('stories').doc();
//     var snapStory=await snapStoryRef.get();
//     // StreamBuilder(
//     //   stream: FirebaseFirestore.instance.collection('stories').where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
//     //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//     //     if(snapshot.hasData){
//     //       hasStory=true;
//     //     }
//     // },);
//     // var snapStory=await FirebaseFirestore.instance.collection('stories').where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
//     setState(() {
//       profImage=snap.data()!['photoUrl']!=null?snap.data()!['photoUrl']:"";
//       storyId=snapStory.data()!['storyId'];
//       // storyId=snapStory.docs.;
//       // storyId=snapStory.data()!['storyId']!=null?snapStory.data()!['storyId']:"";
//     });
//   }
//
//   void getUserId()async{
//     SharedPreferences prefs=await SharedPreferences.getInstance();
//     setState(() {
//       userId=prefs.getString('userId')!;
//     });
//   }
//
//   @override
//   void initState() {
//     getUserDetails();
//     getUserId();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(3.0),
//         child: Column(
//           children: [
//             GestureDetector(
//               onTap: () {
//                 // if(storyId==""){
//                 //   showDialog(
//                 //       context: context,
//                 //       builder: (BuildContext context)=>StoryTypeSelectionDialogue()
//                 //   );
//                 // }
//                 // else{
//                 //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StoryScreen()));
//                 // }
//                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StoryScreen()));
//               },
//               child: (storyId=="")?Container(
//                 width: 67,
//                 height: 67,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(50),
//                     color: AppColors.colorWhite
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(3.0),
//                   child: (profImage=="")?CircleAvatar(
//                     radius: 33.5,
//                     backgroundImage: AssetImage('assets/images/user_profile_img.png'),
//                   ):Container(
//                     width: 67,
//                     height: 67,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(50),
//                         image: DecorationImage(
//                             image:NetworkImage(profImage),
//                             fit: BoxFit.cover)),
//                   ),
//                 ),
//               )
//                   :Container(
//                 width: 67,
//                 height: 67,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(50),
//                     gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: AppColors.colorsOfStories)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(3.0),
//                   child: (profImage=="")?CircleAvatar(
//                     radius: 34,
//                     backgroundImage: AssetImage('assets/images/user_profile_img.png'),
//                   ):Container(
//                     width: 68,
//                     height: 68,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(50),
//                         image: DecorationImage(
//                             image:NetworkImage(profImage),
//                             fit: BoxFit.cover)),
//                   ),
//                 ),
//               ),
//             ),
//             Center(
//               child: Container(
//                   margin: EdgeInsets.only(top: 5),
//                   width: 68,
//                   child: Text(userId)),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
