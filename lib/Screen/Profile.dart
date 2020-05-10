import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zuci/Screen/Coins.dart';
import 'package:zuci/Screen/PhoneBind.dart';
import 'package:zuci/Screen/Settings.dart';
import 'package:zuci/Screen/Shair.dart';
import 'package:zuci/Screen/Vip.dart';
import 'package:zuci/Screen/editProfile.dart';
import 'package:zuci/Screen/loginPage.dart';
import 'package:zuci/provider/user_provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseUser user;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserProvider userProvider;
  _neverSatisfied() {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Account Information'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Id:${userProvider.getUser.id}'),
                    MaterialButton(
                      onPressed: () {},
                      height: 30,
                      minWidth: 60,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      color: Colors.pink[300],
                      child: Text(
                        "Copy",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Id:${userProvider.getUser.id}"),
                    MaterialButton(
                      onPressed: () {},
                      height: 30,
                      minWidth: 60,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      color: Colors.pink[300],
                      child: Text(
                        "Copy",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget options(logo, titleText, selection) {
    return InkWell(
      onTap: () {
        switch (selection) {
          case 1:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfile(
                    name: userProvider.getUser.name,
                    age: userProvider.getUser.age,
                    bio: userProvider.getUser.bio,
                    callrate: userProvider.getUser.callrate,
                    mobilenumber: userProvider.getUser.phone_no,
                    uid: userProvider.getUser.uid,
                    onlinetime: userProvider.getUser.onlinetime,
                    profile_pic:userProvider.getUser.profilePhoto,
                  ),
                ),
              );
              break;
            }
          case 2:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Coins(
                    coins:userProvider.getUser.coin,
                    uid: userProvider.getUser.uid,
                  ),
                ),
              );
              break;
            }
          case 3:
            {
              _neverSatisfied();
              break;
            }
          case 4:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PhoneBind(),
                ),
              );
              break;
            }
          case 5:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Shair(),
                ),
              );
              break;
            }
          case 6:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Settings(),
                ),
              );
              break;
            }
          case 7:
            {
              _firebaseAuth.signOut().whenComplete(() {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPAge()));
              });
            }
        }
      },
      child: ListTile(
        leading: Icon(logo),
        title: Text(titleText),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    userProvider.refreshUser();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  color: Colors.blueAccent,
                  height: size.height * .33,
                  width: double.infinity,
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(child: Text("${userProvider.getUser.followers} Followers")),
                    Container(child: Text("${userProvider.getUser.following} Following"))
                  ],
                ),
                options(Icons.edit, "Edit Profile", 1),
                options(Icons.attach_money, "Get Coins", 2),
                options(Icons.person, "Acount Info", 3),
                options(Icons.phone_iphone, "Phone Bonding", 4),
                options(Icons.share, "Share", 5),
                options(Icons.settings, "Setting", 6),
                options(Icons.clear, "Logout", 7),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              // color: Colors.orange,
              height: size.height * .35,
              alignment: Alignment.center,
              //margin: EdgeInsets.only(right: size.height * .05),
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: size.height * .07,
                      backgroundColor: Colors.red,
                      backgroundImage: NetworkImage(userProvider.getUser.profilePhoto==null?
                          "https://images.pexels.com/photos/3762775/pexels-photo-3762775.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"
                      :userProvider.getUser.profilePhoto
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(4),
                      child: Text(
                        "${userProvider.getUser.name}",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(4),
                      child: Text(
                        "Id:${userProvider.getUser.id}",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(4),
                      child: Text(
                        "⭐ ${userProvider.getUser.coin}",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ), //Stack
      ), //sinlechildscrollview
    );
  }
}
