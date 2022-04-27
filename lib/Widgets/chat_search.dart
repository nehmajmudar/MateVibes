import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/models/database.dart';
import 'package:matevibes/res/Methods/check_Internet_button.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';
import 'package:matevibes/screens/chatrooms.dart';

class ChatSearchUser extends StatefulWidget {
  ChatSearchUser({Key? key}) : super(key: key);

  @override
  State<ChatSearchUser> createState() => _ChatSearchUserState();
}

class _ChatSearchUserState extends State<ChatSearchUser> {
  late StreamSubscription subscription;
  Databasemethods databsemethods = new Databasemethods();
  late QuerySnapshot searchSnapshot;
  bool haveUserSearched = false;

  @override
  initState() {
    super.initState();
    subscription =
        Connectivity().onConnectivityChanged.listen(showConnectivityToast);
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  Widget searchList() {
    return haveUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot.docs.length.toInt(),
            itemBuilder: (context, index) {
              print("hello---------------");
              return SearchTile(
                  username: searchSnapshot.docs[index]["username"]);
            })
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    TextEditingController searchTextEditingController = TextEditingController();
    initiateSearch() {
      databsemethods.getusername(searchTextEditingController.text).then((val) {
        searchSnapshot = val;
        print('----------');
        print(val);
        setState(() {
          searchSnapshot = val;
          haveUserSearched = true;
        });
      });
    }

    return Scaffold(
        body: SafeArea(
      child: Container(
        child: Column(
          children: [
            Container(
              // padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
            Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 6.06),
                child: searchList()),
          ],
        ),
      ),
    ));
  }
}

class SearchTile extends StatelessWidget {
  final String username;
  const SearchTile({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: AppColors.colorBackgroundColor),
          child: Row(
            children: [
              Text(username),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatRoom()));
                  print("tapped");
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(24)),
                  child: Text("Message"),
                ),
              )
            ],
          )),
    );
  }
}
