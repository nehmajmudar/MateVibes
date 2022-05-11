// import 'dart:async';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:matevibes/Widgets/chat_card.dart';
// import 'package:matevibes/res/Methods/check_Internet_button.dart';
// import 'package:matevibes/res/app_colors.dart';
// import 'package:matevibes/res/app_string.dart';

// class ChatScreen extends StatefulWidget {
//   ChatScreen({Key? key}) : super(key: key);

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   late StreamSubscription subscription;

//   @override
//   initState() {
//     super.initState();
//     subscription =
//         Connectivity().onConnectivityChanged.listen(showConnectivityToast);
//   }

//   @override
//   void dispose() {
//     subscription.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Padding(
//             padding: EdgeInsets.only(
//                 left: MediaQuery.of(context).size.width / 10.83,
//                 right: MediaQuery.of(context).size.width / 10.83),
//             child: Stack(
//               children: [
//                 Container(
//                   margin: EdgeInsets.only(
//                       top: MediaQuery.of(context).size.height / 14.06),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(
//                           bottom: MediaQuery.of(context).size.height / 76.7,
//                         ),
//                         child: Text(
//                           AppString.txtChat,
//                           style: TextStyle(
//                               color: AppColors.colorNotifacations,
//                               fontSize: 24,
//                               fontWeight: FontWeight.w900,
//                               fontFamily: 'Manrope'),
//                         ),
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           color: AppColors.colorWhite,
//                           borderRadius: BorderRadius.all(Radius.circular(5)),
//                           boxShadow: [
//                             BoxShadow(
//                               color: AppColors.colorSkipforNow,
//                               blurRadius: 15,
//                             )
//                           ]
//                         ),
//                         width: MediaQuery.of(context).size.width / 28.13,
//                         child: IconButton(
//                           visualDensity: VisualDensity.compact,
//                           icon: new Icon(Icons.person_add_alt_1_outlined),
//                           iconSize: MediaQuery.of(context).size.height / 54.4,
//                           onPressed: () {},
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                       color: AppColors.colorWhite,
//                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppColors.colorSkipforNow,
//                           blurRadius: 15,
//                         )
//                       ]
//                   ),
//                   height: MediaQuery.of(context).size.height / 23.44,
//                   margin: EdgeInsets.only(
//                       top: MediaQuery.of(context).size.height / 7.09),
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       suffixIcon: IconButton(
//                         onPressed: () => {},
//                         icon: Icon(Icons.search_outlined,color: AppColors.colorSearchIconInChat,size: 8),
//                       ),
//                       contentPadding: EdgeInsets.symmetric(
//                           horizontal:
//                               MediaQuery.of(context).size.height / 23.44),
//                       hintText: AppString.txtSearch,
//                       border: OutlineInputBorder(
//                           borderSide: BorderSide.none,
//                           borderRadius: BorderRadius.circular(10)),
//                       hintStyle: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w400,
//                         color: AppColors.colorHintText,
//                         fontFamily: 'Manrope',
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(
//                       top: MediaQuery.of(context).size.height / 5.08),
//                   child: Expanded(
//                     child: SizedBox(
//                       height: double.maxFinite,
//                       child: ListView.builder(
//                           itemCount: 10,
//                           itemBuilder: (BuildContext context, int index) {
//                             return ChatCard();
//                           }),
//                     ),
//                   ),
//                 ),
//               ],
//             )));
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../res/app_string.dart';

class ChatScreen extends StatefulWidget {
  final peerId;
  ChatScreen(String uid, {Key? key, this.peerId}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String peerUserId = '';
  String currentUser = '';
  String groupChatId = "";
  late SharedPreferences _pref;
  @override
  void initState() {
    SharedPreferences.getInstance().then((sharedPref) {
      _pref = sharedPref;

      var userId = _pref.getString(AppString.userIDKey);
      currentUser = userId!;
      print("current user Id = ${currentUser}");
    });

    peerUserId = widget.peerId;
    createGroupChatId();
    super.initState();
  }

  createGroupChatId() {
    print("peer  id${widget.peerId}");
    print("current user id${currentUser}");

    if (currentUser.compareTo(peerUserId) > 0) {
      groupChatId = '$currentUser-$peerUserId';
    } else {
      groupChatId = '$peerUserId-$currentUser';
    }
    print("group chat id${groupChatId}");
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
