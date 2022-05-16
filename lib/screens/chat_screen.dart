import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/models/chat_data.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../res/app_string.dart';

class ChatScreen extends StatefulWidget {
  final Map<String, dynamic> peerUserData;
  ChatScreen({Key? key, required this.peerUserData}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String peerUserId = '';
  String currentUser = '';
  String groupChatId = "";
  String peerUsername = '';
  String peerProfileImage = '';
  late SharedPreferences _pref;
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    SharedPreferences.getInstance().then((sharedPref) {
      _pref = sharedPref;
      peerUserId = widget.peerUserData["uid"];
      peerUsername = widget.peerUserData["username"];
      peerProfileImage = widget.peerUserData["photoUrl"];

      var userId = _pref.getString(AppString.userIDKey);
      currentUser = userId!;
      // print("current user Id = ${currentUser}");
      createGroupChatId();
    });

    super.initState();
  }

  createGroupChatId() {
    print("peer id :-${widget.peerUserData["uid"]}");
    print("current user id${currentUser}");

    if (currentUser.hashCode <= peerUserId.hashCode) {
      groupChatId = '$currentUser-$peerUserId';
    } else {
      groupChatId = '$peerUserId-$currentUser';
    }
    setState(() {});
    print("group chat id${groupChatId}");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              "Chat",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height / 28,
              ),
            ),
            backgroundColor: AppColors.colorHintText,
            centerTitle: true),
        body: Stack(
          children: [
            Container(
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height / 18),
                child: buildUiMessages()),
            Container(alignment: Alignment.bottomCenter, child: buildInput()),
          ],
        ),
      ),
    );
  }

  Widget buildItem(int index, DocumentSnapshot? document) {
    late Widget widget;
    if (document != null) {
      MessageChat messageChat = MessageChat.fromDocument(document);
      if (messageChat.idFrom == currentUser) {
        // Right (my message)
        widget =
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Container(
            child: Text(
              messageChat.content,
              style: TextStyle(color: AppColors.colorWhite),
            ),
            padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
            width: 200,
            decoration: BoxDecoration(
                color: AppColors.purpleColor,
                borderRadius: BorderRadius.circular(8)),
            margin: EdgeInsets.only(
              bottom: 10,
            ),
          )
        ]);
      } else {
        widget = Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Text(
                messageChat.content,
                style: TextStyle(color: AppColors.colorBlack),
              ),
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              width: 200,
              decoration: BoxDecoration(
                  color: AppColors.colorSkipforNow,
                  borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.only(bottom: 10),
            ),
          ],
        );
      }
    }
    return widget;
  }

  Widget buildUiMessages() {
    final ScrollController listScrollController = ScrollController();

    List<QueryDocumentSnapshot>? listMessage = [];
    return groupChatId.isNotEmpty
        ? Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chat')
                  .doc(groupChatId)
                  .collection(groupChatId)
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.colorBlack)));
                } else {
                  listMessage = snapshot.data!.docs;
                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) =>
                        buildItem(index, snapshot.data!.docs[index]),
                    itemCount: snapshot.data!.docs.length,
                    reverse: true,
                    controller: listScrollController,
                  );
                }
              },
            ),
          )
        : CircularProgressIndicator();
  }

  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          Flexible(
            child: Container(
              child: TextField(
                onSubmitted: (value) {
                  if (textEditingController.text.isNotEmpty) {
                    onSendMessage(textEditingController.text);
                  }
                },

                style: TextStyle(color: AppColors.colorBlack, fontSize: 15),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: AppColors.greyColor),
                ),
                // focusNode: focusNode,
              ),
            ),
          ),

          // Button send message
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  if (textEditingController.text.isNotEmpty) {
                    onSendMessage(textEditingController.text);
                  }
                },
                color: AppColors.greyColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          border:
              Border(top: BorderSide(color: AppColors.colorBlack, width: 0.5)),
          color: Colors.white),
    );
  }

  onSendMessage(String message) async {
    textEditingController.clear();
    var data = await FirebaseFirestore.instance
        .collection("chat")
        .doc(groupChatId)
        .set({"temp": 0});

    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("chat")
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    MessageChat messageChat = MessageChat(
        idFrom: currentUser,
        idTo: peerUserId,
        timestamp: DateTime.now().microsecondsSinceEpoch.toString(),
        content: message,
        peerUsername: peerUsername,
        peerProfileImage: peerProfileImage);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(documentReference, messageChat.toJson());
    });
  }
}
