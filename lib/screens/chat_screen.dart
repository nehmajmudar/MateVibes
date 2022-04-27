import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/Widgets/chat_card.dart';
import 'package:matevibes/Widgets/chat_search.dart';
import 'package:matevibes/models/database.dart';
import 'package:matevibes/res/Methods/check_Internet_button.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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

  getUsername() {
    // return searchSnapshot.docs[index].data()!["username"];
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
  // FirebaseFirestore.instance
  //           .collection('users')
  //           .snapshots()
  //           .listen((event) {
  //         event.docs.forEach((document) {
  //           print(document['username']);
  //         });

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
      body: Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 10.83,
              right: MediaQuery.of(context).size.width / 10.83),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 14.06),
                child: Row(
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
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Manrope'),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 28.13,
                      child: IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: new Icon(Icons.record_voice_over),
                        iconSize: MediaQuery.of(context).size.height / 54.4,
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatSearchUser()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 23.44,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 7.09),
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
                          horizontal:
                              MediaQuery.of(context).size.height / 23.44),
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
                    top: MediaQuery.of(context).size.height / 5.08),
                child: Expanded(
                  child: SizedBox(
                    height: double.maxFinite,
                    child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return ChatCard();
                        }),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 6.06),
                  child: searchList()),
            ],
          )),
      floatingActionButton: FloatingActionButton(onPressed: () {
        FirebaseFirestore.instance
            .collection('users')
            .snapshots()
            .listen((event) {
          event.docs.forEach((document) {
            print(document['username']);
          });
        });
        // print(user.uid);
      }),
    );
  }
}

// class SearchTile extends StatelessWidget {
//   final String username;
//   const SearchTile({Key? key, required this.username}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       elevation: 2,
//       child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//               color: AppColors.colorBackgroundColor),
//           child: Row(
//             children: [
//               Text(username),
//               Spacer(),
//               GestureDetector(
//                 onTap: () {},
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                   decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(24)),
//                   child: Text("Message"),
//                 ),
//               )
//             ],
//           )),
//     );
//   }
// }
