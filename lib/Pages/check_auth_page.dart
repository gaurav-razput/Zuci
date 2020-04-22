import 'package:flutter/material.dart';
import 'package:zuci/Firebase/Authentication.dart';
import 'package:zuci/main.dart';
import 'package:zuci/Login/Login_page.dart';


enum loginStatus{

  Log_In,
  Not_Log_In,
  Not_Specified

}

class Check_Status extends StatefulWidget {

  Check_Status({this.auth});

  final firebase_methods auth;

  @override
  _Check_StatusState createState() => _Check_StatusState();
}

class _Check_StatusState extends State<Check_Status> {

  loginStatus authStatus =loginStatus.Not_Specified;
  String _userId = "";

  @override

  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
        }
        authStatus =
        user?.uid == null ? loginStatus.Not_Log_In : loginStatus.Log_In;
      });
    });
  }

  void loginCallback() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = loginStatus.Log_In;
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = loginStatus.Not_Log_In;
      _userId = "";
    });
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case loginStatus.Not_Specified:
        return buildWaitingScreen();
        break;
      case loginStatus.Not_Log_In:
        return new LoginPAge(
          auth: widget.auth,
          loginCallback: loginCallback,
        );
        break;
      case loginStatus.Log_In:
        if (_userId.length > 0 && _userId != null) {
          return new MyhomePage(
            userId: _userId,
            auth: widget.auth,
            logoutCallback: logoutCallback,
          );
        } else
          return buildWaitingScreen();
        break;
      default:
        return buildWaitingScreen();
    }
  }
}
