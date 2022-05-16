import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/models/chat_data.dart';
import 'package:matevibes/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../res/Methods/check_Internet_button.dart';
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
  late QuerySnapshot searchSnapshot;
  // bool haveUserSearched = false;
  // var snapChat = FirebaseFirestore.instance.collection('chat').doc().get();
  var snapUser = FirebaseFirestore.instance.collection('users').doc().get();
  late SharedPreferences _pref;
  var currentUser = '';
  late List<MessageChat> chatUserData;
  var chatUser = [];
  List<String> peerUserIdList = [];
  List<UserModel> chatListUsers = [];
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>> listener;
  @override
  initState() {
    super.initState();
    obj = FirebaseFirestore.instance;

    subscription =
        Connectivity().onConnectivityChanged.listen(showConnectivityToast);
    SharedPreferences.getInstance().then((sharedPref) async {
      _pref = sharedPref;

      var userId = _pref.getString(AppString.userIDKey);
      currentUser = userId!;
      // QuerySnapshot querySnapshot;
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
      peerUserId = messagechat.idTo;
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
    // print(chatUser.length);

    return Scaffold(
        body: Stack(
      children: [
        chatListUsers.length > 0
            ? ListView.builder(
                itemCount: chatListUsers.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      // listener.cancel();

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                    peerUserData: chatListUsers[index].toMap(),
                                  )));
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Text(chatListUsers[index].username!),
                    ),
                  );
                })
            : Center(child: CircularProgressIndicator())
      ],
    ));
  }

  @override
  void dispose() {
    super.dispose();
    listener.cancel();
  }

  Widget chatsUi() {
    return Container();
    //     child: StreamBuilder<QuerySnapshot>(
    //   stream: FirebaseFirestore.instance
    //       .collection('chat')
    //       .doc(chatUser[])
    //       .collection(groupChatId)
    //       .orderBy('timestamp', descending: true)
    //       .snapshots(),
    // ));
    // ListView.builder(itemCount: , itemBuilder: (context, index)  {

    // });
  }
}
