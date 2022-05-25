import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/models/chat_data.dart';
import 'package:matevibes/models/user_model.dart';
import 'package:matevibes/screens/chat_search_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../res/Methods/check_Internet_button.dart';
import '../res/app_colors.dart';
import '../res/app_string.dart';
import 'chat_screen.dart';

class ChatsPage extends StatefulWidget {
  final Map<String, dynamic> userData;

  ChatsPage({Key? key, required this.userData}) : super(key: key);

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  late FirebaseFirestore obj;

  var profilePhoto = "";
  late StreamSubscription subscription;
  late SharedPreferences _pref;
  var currentUser = '';
  late List<MessageChat> chatUserData;
  List<String> peerUserIdList = [];
  List<UserModel> chatListUsers = [];
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>> listener;
  @override
  initState() {
    super.initState();
    subscription =
        Connectivity().onConnectivityChanged.listen(showConnectivityToast);
    ;
    initChat();
  }

  void initChat() {
    SharedPreferences.getInstance().then((sharedPref) async {
      _pref = sharedPref;

      var userId = _pref.getString(AppString.userIDKey);
      currentUser = userId!;
      FirebaseFirestore.instance.collection('chat').get().then(
        (querySnapshot) {
          querySnapshot.docs.forEach((element) async {
            if (element.id.contains(currentUser)) {
              listener = FirebaseFirestore.instance
                  .collection('chat')
                  .doc(element.id)
                  .collection(element.id)
                  .snapshots()
                  .listen((event) {
                firebaseListener(event);
              });
            }
          });
        },
      );
    });
  }

  void firebaseListener(QuerySnapshot<Map<String, dynamic>> event) {
    List<DocumentSnapshot> dataList = event.docs;
    MessageChat messagechat = MessageChat.fromDocument(dataList[0]);
    String peerUserId;
    if (messagechat.idFrom == currentUser) {
      peerUserId = messagechat.idTo;
      peerUserIdList.add(messagechat.idTo);
    } else {
      peerUserId = messagechat.idFrom;
      peerUserIdList.add(messagechat.idFrom);
    }
    if (peerUserId.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(peerUserId)
          .get()
          .then((userDocumentSnapshot) {
        UserModel userModel = UserModel.fromMap(userDocumentSnapshot.data());
        if (!chatListUsers.any((element) => element.uid == userModel.uid)) {
          chatListUsers.add(userModel);

          setState(() {});
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 25.83,
            left: MediaQuery.of(context).size.width / 20.83,
            right: MediaQuery.of(context).size.width / 20.83),
        child: Column(
          children: [
            chatsTopUi(),
            SizedBox(
              height: 15,
            ),
            Expanded(child: chatsUi()),
          ],
        ),
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    listener.cancel();
  }

  Widget chatsTopUi() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height / 76.7,
          ),
          child: Text(
            AppString.txtChat,
            style: TextStyle(
                color: AppColors.colorNotifacations,
                fontSize: 24,
                fontWeight: FontWeight.w900,
                fontFamily: 'Manrope'),
          ),
        ),
        Container(
            decoration: BoxDecoration(
                color: AppColors.colorWhite,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.colorSkipforNow,
                    blurRadius: 15,
                  )
                ]),
            child: IconButton(
              visualDensity: VisualDensity.compact,
              icon: new Icon(Icons.search_rounded),
              iconSize: MediaQuery.of(context).size.height / 34.4,
              onPressed: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => (ChatSearchScreen())))
                    .then((value) {
                  initChat();

                  setState(() {});
                });
              },
            ))
      ],
    );
  }

  Widget chatsUi() {
    return chatListUsers.length > 0
        ? ListView.separated(
            itemCount: chatListUsers.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatScreen(
                                peerUserData: chatListUsers[index].toMap(),
                              )));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.colorWhite,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.colorSkipforNow,
                          blurRadius: 15,
                        )
                      ]),
                  alignment: Alignment.center,
                  child: ListTile(
                    leading: CircleAvatar(
                        foregroundImage:
                            NetworkImage(chatListUsers[index].photoUrl!),
                        radius: 20,
                        backgroundImage: AssetImage(
                          'assets/images/user_profile_img.png',
                        )),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chatListUsers[index].username!,
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColors.chatName,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Manrope'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => Divider(
                  color: AppColors.colorWhite,
                  height: 8,
                  thickness: 0,
                ))
        : Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "No Chat Data",
                style: TextStyle(fontSize: 20),
              ),
              LinearProgressIndicator(
                backgroundColor: AppColors.colorForgotPassword,
              )
            ],
          ));
  }
}
