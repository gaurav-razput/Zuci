import 'package:flutter/material.dart';
import 'package:zuci/Firebase/Authentication.dart';
import 'package:zuci/Pages/check_auth_page.dart';

class VideoChat extends StatefulWidget {
  @override
  _VideoChatState createState() => _VideoChatState();
}

class _VideoChatState extends State<VideoChat> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.2, 1],
                    colors: [Colors.purple, Colors.pinkAccent])),
            child: SafeArea(
                child: Column(
              children: <Widget>[
                TabBar(
                  tabs: [
                    Container(
                      child: Text(
                        'Live',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    Container(
                      child: Text(
                        'RANDOM',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    Container(
                      child: Text(
                        'NEW',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ],
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                )
              ],
            )),
          ),
          preferredSize: Size.fromHeight(32.0),
        ),
        body: TabBarView(
          children: <Widget>[
            ListView(
              children: <Widget>[
                Container(
                  height: 70,
                  width: 70,
                  color: Colors.red,
                ),
                Center(
                  child: FlatButton(
                    child: Text('LogOut'),
                    onPressed: () {
                      auth().signOut();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Check_Status(auth: auth())));
                    },
                  ),
                )
              ],
            ),
            Column(
              children: <Widget>[Center(child: Text("RANDOM"))],
            ),
            Column(
              children: <Widget>[Center(child: Text("NEW"))],
            )
          ],
        ),
      ),
    );
  }
}
