// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:matevibes/Widgets/story_button_widget.dart';
// import 'package:matevibes/Widgets/storydata.dart';
// import 'package:matevibes/res/Methods/check_Internet_button.dart';
// import 'package:matevibes/res/app_colors.dart';
//
// class HomeScreen extends StatefulWidget {
//   HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => HomeScreenState();
// }
//
// class HomeScreenState extends State<HomeScreen> {
//   late StreamSubscription subscription;
//
//   @override
//   initState() {
//     super.initState();
//
//     subscription =
//         Connectivity().onConnectivityChanged.listen(showConnectivityToast);
//   }
//
//   @override
//   void dispose() {
//     subscription.cancel();
//     super.dispose();
//   }
//
//   int selectedIndex = 0;
//   screenOptions(int index) {
//     switch (index) {
//       case 0:
//         return HomeScreen();
//
//       ///Home screen
//       case 1:
//         return HomeScreen();
//
//       ///Notification screen
//       case 2:
//         return HomeScreen();
//
//       ///Add post/story screen
//       case 3:
//         return HomeScreen();
//
//       ///Chat screen
//       case 4:
//         return HomeScreen();
//
//       ///Profile screen
//       default:
//         return HomeScreen();
//     }
//   }
//
//   List<StoryData> stories = [
//     new StoryData(
//         username: 'Bhargav Dobariya',
//         avatarUrl: AssetImage('lib/assets/images/forgot_password_img.png'),
//         storyUrl: 'https://unsplash.com/photos/mEZ3PoFGs_k'),
//     new StoryData(
//         username: 'Bhargav',
//         avatarUrl: AssetImage('lib/assets/images/forgot_password_img.png'),
//         storyUrl: 'https://unsplash.com/photos/mEZ3PoFGs_k'),
//     new StoryData(
//         username: 'Bhargav',
//         avatarUrl: AssetImage('lib/assets/images/forgot_password_img.png'),
//         storyUrl: 'https://unsplash.com/photos/mEZ3PoFGs_k'),
//     new StoryData(
//         username: 'Bhargav',
//         avatarUrl: AssetImage('lib/assets/images/forgot_password_img.png'),
//         storyUrl: 'https://unsplash.com/photos/mEZ3PoFGs_k'),
//     new StoryData(
//         username: 'Bhargav',
//         avatarUrl: AssetImage('lib/assets/images/forgot_password_img.png'),
//         storyUrl: 'https://unsplash.com/photos/mEZ3PoFGs_k'),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         bottomNavigationBar: Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(30), topLeft: Radius.circular(30)),
//               boxShadow: [
//                 BoxShadow(color: AppColors.colorTimeOfPost, blurRadius: 10)
//               ]),
//           child: ClipRRect(
//             borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(30), topLeft: Radius.circular(30)),
//             child: BottomNavigationBar(
//               selectedFontSize: 0,
//               // unselectedFontSize: 0,
//               type: BottomNavigationBarType.fixed,
//               backgroundColor: AppColors.colorBackgroundColor,
//               showUnselectedLabels: false,
//               selectedItemColor: AppColors.colorSelectedItemNavBar,
//               unselectedItemColor: AppColors.colorTimeOfPost,
//               selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
//               items: [
//                 BottomNavigationBarItem(
//                     icon: Icon(Icons.wysiwyg_sharp), label: "___"),
//                 BottomNavigationBarItem(
//                     icon: Icon(Icons.notifications_none_sharp), label: "___"),
//                 BottomNavigationBarItem(
//                     icon: Icon(Icons.add_circle_outline_sharp), label: "___"),
//                 BottomNavigationBarItem(
//                     icon: Icon(Icons.messenger_outline_sharp), label: "___"),
//                 BottomNavigationBarItem(
//                     icon: Icon(Icons.account_circle_sharp), label: "___"),
//               ],
//               currentIndex: selectedIndex,
//               onTap: (index) {
//                 setState(() {
//                   selectedIndex = index;
//                 });
//               },
//             ),
//           ),
//         ),
//         backgroundColor: AppColors.colorBackgroundColor,
//         body: SingleChildScrollView(
//           child: SafeArea(
//             child: Column(
//               children: [
//                 Container(
//                     width: double.infinity,
//                     height: 150,
//                     margin: EdgeInsets.only(
//                         bottom: MediaQuery.of(context).size.height / 36.7),
//                     child: ListView(
//                       scrollDirection: Axis.horizontal,
//                       children: [
//                         storyButton(stories[0], context),
//                         storyButton(stories[1], context),
//                         storyButton(stories[2], context),
//                         storyButton(stories[3], context),
//                         storyButton(stories[4], context),
//                         storyButton(stories[4], context),
//                         storyButton(stories[4], context),
//                         storyButton(stories[4], context),
//                         storyButton(stories[4], context),
//                       ],
//                     )),
//               ],
//             ),
//           ),
//         ));
//   }
// }
