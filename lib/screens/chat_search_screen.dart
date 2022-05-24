import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/models/user_model.dart';
import 'package:matevibes/screens/chat_screen.dart';

import '../res/app_colors.dart';
import '../res/app_string.dart';

class ChatSearchScreen extends StatefulWidget {
  ChatSearchScreen({Key? key}) : super(key: key);

  @override
  State<ChatSearchScreen> createState() => _ChatSearchScreenState();
}

class _ChatSearchScreenState extends State<ChatSearchScreen> {
  late QuerySnapshot searchSnapshot;
  bool haveUserSearched = false;
  TextEditingController searchTextEditingController = TextEditingController();
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>> listener;
  List<UserModel> chatListUsers = [];
  List matchUserList = [];

  @override
  void initState() {
    FirebaseFirestore.instance.collection('users').get().then(
      (querySnapshot) {
        querySnapshot.docs.forEach((element) async {
          FirebaseFirestore.instance
              .collection('users')
              .doc(element.id)
              .get()
              .then((userDocumentSnapshot) {
            UserModel userModel =
                UserModel.fromMap(userDocumentSnapshot.data());

            chatListUsers.add(userModel);
            setState(() {});
          });
        });
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return searchUi();
  }

  Widget userTile(String username, int index) {
    return Material(
      elevation: 2,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: AppColors.colorBackgroundColor),
          child: Row(
            children: [
              CircleAvatar(
                  foregroundImage: NetworkImage(matchUserList[index].photoUrl),
                  radius: 20,
                  backgroundImage: AssetImage(
                    'assets/images/user_profile_img.png',
                  )),
              SizedBox(width: MediaQuery.of(context).size.height / 53.44),
              Text(username),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatScreen(
                                peerUserData: matchUserList[index].toMap(),
                              )));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                      color: AppColors.purpleColor,
                      borderRadius: BorderRadius.circular(24)),
                  child: Text("Message",
                      style: TextStyle(color: AppColors.colorWhite)),
                ),
              )
            ],
          )),
    );
  }

  Widget searchUi() {
    initiateSearch() {
      setState(() {
        haveUserSearched = true;
      });
    }

    Widget searchList() {
      List tempList = [];
      chatListUsers.forEach((element) async {
        if (element.username!.contains(searchTextEditingController.text) &&
            searchTextEditingController.text.isNotEmpty) {
          tempList.add(element);
        }
        matchUserList.clear();
        matchUserList.addAll(tempList);
        setState(() {});
      });
      return haveUserSearched
          ? ListView.separated(
              shrinkWrap: true,
              itemCount: matchUserList.length,
              itemBuilder: (context, index) {
                return userTile(matchUserList[index].username!, index);
              },
              separatorBuilder: (BuildContext context, int index) => Divider(
                    color: AppColors.colorWhite,
                    height: 8,
                    thickness: 0,
                  ))
          : Container(
              child: Text("Not Searched Anything"),
            );
    }

    return Scaffold(
        body: SafeArea(
      child: Container(
        child: Column(
          children: [
            Container(

              child: PhysicalModel(
                borderRadius: BorderRadius.circular(10),
                elevation: 1,
                color: Colors.white,
                child: TextFormField(
                  controller: searchTextEditingController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () => {initiateSearch()},
                      icon: Icon(Icons.search_outlined),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.height / 23.44),
                    hintText: AppString.txtSearch,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.colorHintText,
                      fontFamily: 'Manrope',
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 23.44,
                        left: MediaQuery.of(context).size.height / 33.44,
                        right: MediaQuery.of(context).size.height / 33.44),
                    child: searchList())),
          ],
        ),
      ),
    ));
  }
}
