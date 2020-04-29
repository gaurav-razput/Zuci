import 'package:flutter/material.dart';
import 'package:zuci/Call/video_call/pickup_layout.dart';
import 'package:zuci/Pages/FavouriteList.dart';
import 'package:zuci/Pages/Messages.dart';
import 'package:zuci/Pages/Profile.dart';
import 'package:zuci/Pages/VideoChat.dart';

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
      length: 4,
      child:  PickupLayout(
        scaffold: Scaffold(
            body: barcount[currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              type: BottomNavigationBarType.fixed,
              fixedColor: Color(0xFFD34B96),
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
      ),
    );
  }
}
