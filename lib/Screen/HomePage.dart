import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:zuci/Screen/Fav_list.dart';
import 'package:zuci/Screen/Message.dart';
import 'package:zuci/Screen/Profile.dart';
import 'package:zuci/Screen/video_chat.dart';
import 'package:zuci/callScreen/pickup/pickup_layout.dart';
import 'package:zuci/provider/user_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  int currentIndex = 1;
  var barcount = [
    VideoChat(),
    Messages(),
    FavouriteList(),
    Profile(),
  ];


  UserProvider userProvider;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.refreshUser();
    });

  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: PickupLayout(
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
