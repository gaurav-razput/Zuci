import 'package:flutter/material.dart';
import 'package:zuci/Firebase/Authentication.dart';
import 'package:zuci/Pages/FavouriteList.dart';
import 'package:zuci/Pages/Messages.dart';
import 'package:zuci/Pages/Profile.dart';
import 'package:zuci/Pages/VideoChat.dart';
import 'package:zuci/Pages/check_auth_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {


  int currentIndex = 0;
  var barcount = [
    VideoChat(),
    Messages(),
    FavouriteList(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
//        appBar: PreferredSize(
//          child: Container(
//            decoration: BoxDecoration(
//                gradient: LinearGradient(
//                    begin: Alignment.topCenter,
//                    end: Alignment.bottomCenter,
//                    stops: [0.2, 1],
//                    colors: [Colors.purple, Colors.pinkAccent])),
//            child: SafeArea(
//                child: Column(
//              children: <Widget>[
//                TabBar(
//                  tabs: [
//                    Container(
//                      child: Text(
//                        'Live',
//                        style: TextStyle(fontSize: 20.0),
//                      ),
//                    ),
//                    Container(
//                      child: Text(
//                        'RANDOM',
//                        style: TextStyle(fontSize: 20.0),
//                      ),
//                    ),
//                    Container(
//                      child: Text(
//                        'NEW',
//                        style: TextStyle(fontSize: 20.0),
//                      ),
//                    ),
//                  ],
//                  labelColor: Colors.white,
//                  indicatorColor: Colors.white,
//                )
//              ],
//            )
//
//            ),
//          ),
//          preferredSize: Size.fromHeight(32.0),
//        ),
//        body:TabBarView(
//          children: <Widget>[
//            Column(
//              children: <Widget>[
//                Center(child: Text("LIVE")),
//                Center(
//                  child: FlatButton(
//                    child: Text('LogOut'),
//                    onPressed: (){
//                      auth().signOut();
//                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Check_Status(auth: auth())));
//                    },
//                  ),
//                )
//
//              ],
//            ),
//            Column(
//              children: <Widget>[Center(child: Text("RANDOM"))],
//            ),
//            Column(
//              children: <Widget>[Center(child: Text("NEW"))],
//            )
//          ],
//        ),


        body: barcount[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          fixedColor:Color(0xFFD34B96),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.videocam),
              title: Text('Video Chat'),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.message,
              ),
              title: Text(
                'Messages',
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
              ),
              title: Text(
                'Subscriptions',
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              title: Text(
                "Me",
              ),
            ),
          ],
        ),

      ),
    );
  }
}
