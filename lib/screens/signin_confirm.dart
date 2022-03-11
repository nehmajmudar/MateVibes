import 'package:flutter/material.dart';
import 'package:matevibes/res/app_string.dart';

class SignInConfirm extends StatefulWidget {
  SignInConfirm({Key? key}) : super(key: key);

  @override
  State<SignInConfirm> createState() => _SignInConfirmState();
}

class _SignInConfirmState extends State<SignInConfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.txtwelcometohomepage),
        centerTitle: true,
      ),
      body: Center(child: Text(AppString.txtyouaresuccessfullyloggedin)),
    );
  }
}
