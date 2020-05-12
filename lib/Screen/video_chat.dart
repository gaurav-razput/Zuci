import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zuci/Screen/live/live_audience.dart';

import 'package:zuci/Screen/video_chat2.dart';
import 'package:zuci/constants/strings.dart';
import 'package:zuci/models/user.dart';
import 'package:zuci/provider/user_provider.dart';
import 'package:zuci/resources/firebase_methods.dart';

class VideoChat extends StatefulWidget {
  @override
  _VideoChatState createState() => _VideoChatState();
}

class _VideoChatState extends State<VideoChat> {
  bool _isloading;

  @override
  void initState() {
    super.initState();
    _isloading = false;
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvid = Provider.of<UserProvider>(context);
    Size size = MediaQuery.of(context).size;
    final double itemHeight = size.height * .1;
    final double itemWidth = size.width * .31;
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
                colors: [
                  Color(0xFFB44EB1),
                  Color(0xFFDA4D91),
                ],
              ),
            ),
            child: SafeArea(
              child: LayoutBuilder(
                builder: (ctx, constraint) {
                  return Column(
                    children: <Widget>[
                      TabBar(
                        tabs: [
                          Container(
                            //color: Colors.blue,
                            margin: EdgeInsets.only(
                                top: constraint.maxHeight * .27,
                                bottom: constraint.maxHeight * .27),
                            child: Text(
                              'RANDOM',
                              style: TextStyle(
                                fontSize: constraint.maxHeight * .32,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: constraint.maxHeight * .27,
                                bottom: constraint.maxHeight * .27),
                            child: Text(
                              'LIVE',
                              style: TextStyle(
                                fontSize: constraint.maxHeight * .32,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: constraint.maxHeight * .27,
                                bottom: constraint.maxHeight * .27),
                            child: Text(
                              'NEW',
                              style: TextStyle(
                                fontSize: constraint.maxHeight * .32,
                              ),
                            ),
                          ),
                        ],
                        //labelColor: Colors.white,

                        indicatorColor: Colors.white,
                      )
                    ],
                  );
                },
              ),
            ),
          ),
          preferredSize: Size.fromHeight(size.height * .07),
        ),
        body: _isloading
            ? Center(child: CircularProgressIndicator())
            : TabBarView(
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: size.height * .02),
                        height: size.height * .06,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                left: size.width * .04,
                                right: size.width * .02,
                              ),
                              width: size.width * .3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Color(0xFFE6EAEB),
                              ),
                              child: Center(
                                child: Text(
                                  "All",
                                  style: TextStyle(
                                    color: Color(0xFF808080),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: size.width * .04,
                                right: size.width * .02,
                              ),
                              width: size.width * .3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Color(0xFFE6EAEB),
                              ),
                              child: Center(
                                child: Text(
                                  "English",
                                  style: TextStyle(
                                    color: Color(0xFF808080),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: size.width * .04,
                                right: size.width * .02,
                              ),
                              width: size.width * .3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Color(0xFFE6EAEB),
                              ),
                              child: Center(
                                child: Text(
                                  "Arabic",
                                  style: TextStyle(
                                    color: Color(0xFF808080),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: size.width * .04,
                                right: size.width * .02,
                              ),
                              width: size.width * .3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Color(0xFFE6EAEB),
                              ),
                              child: Center(
                                child: Text(
                                  "Indian",
                                  style: TextStyle(
                                    color: Color(0xFF808080),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: size.width * .04,
                                right: size.width * .02,
                              ),
                              width: size.width * .3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Color(0xFFE6EAEB),
                              ),
                              child: Center(
                                child: Text(
                                  "All",
                                  style: TextStyle(
                                    color: Color(0xFF808080),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: size.width * .05,
                            right: size.width * .05,
                            top: size.height * .03,
                          ),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                  child: _isloading
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Container(
                                          height: 0.0,
                                          width: 0.0,
                                        )),
                              StreamBuilder<QuerySnapshot>(
                                  stream: Firestore.instance
                                      .collection("USER")
                                      .where('gender',
                                          isEqualTo: userProvid.getGender)
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasError) {
                                      return new Text(
                                          'Error: ${snapshot.error}');
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text("Loading..."),
                                            SizedBox(
                                              height: 50.0,
                                            ),
                                            CircularProgressIndicator()
                                          ],
                                        ),
                                      );
                                    } else {
                                      return GridView.builder(
                                        shrinkWrap: true,
                                        //physics: NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio:
                                                    itemHeight / itemWidth,
                                                crossAxisSpacing:
                                                    size.width * .05,
                                                mainAxisSpacing:
                                                    size.height * .02),

                                        itemCount:
                                            snapshot.data.documents.length,
                                        itemBuilder: (_, index) =>
                                            LayoutBuilder(
                                          builder: (ctx, constraint) {
                                            User rec = User(
                                              name: snapshot
                                                  .data
                                                  .documents[index]
                                                  .data["name"],
                                              uid: snapshot.data
                                                  .documents[index].data["uid"],
                                              id: snapshot.data.documents[index]
                                                  .data['Id'],
                                              age: snapshot.data
                                                  .documents[index].data['age'],
                                              bio: snapshot.data
                                                  .documents[index].data['bio'],
                                              callrate: snapshot
                                                  .data
                                                  .documents[index]
                                                  .data['callrate'],
                                              country: snapshot
                                                  .data
                                                  .documents[index]
                                                  .data['country'],
                                              onlinetime: snapshot
                                                  .data
                                                  .documents[index]
                                                  .data['onlinetime'],
                                              profilePhoto: snapshot
                                                  .data
                                                  .documents[index]
                                                  .data['profile_pic'],
                                            );
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        NxtVideoChat(
                                                      receiver: rec,
                                                      sender:
                                                          userProvid.getUser,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Color(0xFFF0F0F0),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      height: constraint
                                                              .maxHeight *
                                                          .75, //size.height * .23,
                                                      width: double.infinity,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: rec.profilePhoto ==
                                                                null
                                                            ? Image(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: AssetImage(
                                                                    'assets/Image/person.png'))
                                                            : Image.network(
                                                                rec.profilePhoto,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.all(
                                                          constraint.maxHeight *
                                                              .025),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          Container(
                                                            //color: Colors.red,
                                                            width: constraint
                                                                    .maxWidth *
                                                                .6,
                                                            child: Text(
                                                              "${rec.name}",
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xFF383838),
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            "${rec.age}",
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          constraint.maxHeight *
                                                              .00,
                                                    ),
                                                    Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          Text(
                                                            "${rec.country}",
                                                          ),
                                                          Text(
                                                            "Online",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .redAccent),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    }
                                  }),
                            ],
                          ),
                          //here
                        ),
                      )
                    ],
                  ),
                  // For Ranadom TabBar
                  Padding(
                    padding: EdgeInsets.only(
                      left: size.width * .05,
                      right: size.width * .05,
                      top: size.height * .03,
                    ),
                    child: Stack(
                      children: <Widget>[
                        StreamBuilder<QuerySnapshot>(
                            stream: Firestore.instance
                                .collection(LIVE_COLLECTION)
                                .where('gender',
                                    isEqualTo: userProvid.getGender)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return new Text('Error: ${snapshot.error}');
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Loading..."),
                                      SizedBox(
                                        height: 50.0,
                                      ),
                                      CircularProgressIndicator()
                                    ],
                                  ),
                                );
                              } else {
                                return GridView.builder(
                                  shrinkWrap: true,
                                  //physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio:
                                              itemHeight / itemWidth,
                                          crossAxisSpacing: size.width * .05,
                                          mainAxisSpacing: size.height * .02),

                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder: (_, index) => LayoutBuilder(
                                    builder: (ctx, constraint) {
                                      User live = User(
                                        name: snapshot.data.documents[index]
                                            .data["token"],
                                        uid: snapshot
                                            .data.documents[index].data["uid"],
                                        bio: snapshot
                                            .data.documents[index].data["name"],
                                        age: snapshot
                                            .data.documents[index].data["age"],
                                        country: snapshot.data.documents[index]
                                            .data["country"],
                                      );
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Audience(
                                                      token: live.name,
                                                    )),
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color(0xFFF0F0F0),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                height: constraint.maxHeight *
                                                    .75, //size.height * .23,
                                                width: double.infinity,
                                                child: live.profilePhoto == null
                                                    ? Image(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                            'assets/Image/person.png'))
                                                    : Image.network(
                                                        live.profilePhoto,
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.all(
                                                    constraint.maxHeight *
                                                        .025),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Container(
                                                      //color: Colors.red,
                                                      width:
                                                          constraint.maxWidth *
                                                              .6,
                                                      child: Text(
                                                        "${live.bio}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF383838),
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      "${live.age}",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    constraint.maxHeight * .00,
                                              ),
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Text(
                                                      "${live.country}",
                                                    ),
                                                    Text(
                                                      "Online",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.redAccent),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                            }),
                        Container(
                          child: _isloading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Container(
                                  height: 0,
                                  width: 0,
                                ),
                        )
                      ],
                    ),
                    //here
                  ),
                  // For New tabBar
                  Padding(
                    padding: EdgeInsets.only(
                      left: size.width * .05,
                      right: size.width * .05,
                      top: size.height * .03,
                    ),
                    child: Stack(
                      children: <Widget>[
                        StreamBuilder<QuerySnapshot>(
                            stream: Firestore.instance
                                .collection("USER")
                                .where('gender',
                                    isEqualTo: userProvid.getGender)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return new Text('Error: ${snapshot.error}');
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Loading...."),
                                      SizedBox(
                                        height: 50.0,
                                      ),
                                      CircularProgressIndicator()
                                    ],
                                  ),
                                );
                              } else {
                                return GridView.builder(
                                  shrinkWrap: true,
                                  //physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio:
                                              itemHeight / itemWidth,
                                          crossAxisSpacing: size.width * .05,
                                          mainAxisSpacing: size.height * .02),

                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder: (_, index) => LayoutBuilder(
                                    builder: (ctx, constraint) {
                                      User rec = User(
                                        name: snapshot
                                            .data.documents[index].data["name"],
                                        uid: snapshot
                                            .data.documents[index].data["uid"],
                                        id: snapshot
                                            .data.documents[index].data['Id'],
                                        age: snapshot
                                            .data.documents[index].data['age'],
                                        bio: snapshot
                                            .data.documents[index].data['bio'],
                                        callrate: snapshot.data.documents[index]
                                            .data['callrate'],
                                        country: snapshot.data.documents[index]
                                            .data['country'],
                                        onlinetime: snapshot
                                            .data
                                            .documents[index]
                                            .data['onlinetime'],
                                        profilePhoto: snapshot
                                            .data
                                            .documents[index]
                                            .data['profile_pic'],
                                      );
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  NxtVideoChat(
                                                receiver: rec,
                                                sender: userProvid.getUser,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color(0xFFF0F0F0),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                height: constraint.maxHeight *
                                                    .75, //size.height * .23,
                                                width: double.infinity,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: rec.profilePhoto ==
                                                          null
                                                      ? Image(
                                                          fit: BoxFit.cover,
                                                          image: AssetImage(
                                                              'assets/Image/person.png'))
                                                      : Image.network(
                                                          rec.profilePhoto,
                                                          fit: BoxFit.cover,
                                                        ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.all(
                                                    constraint.maxHeight *
                                                        .025),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Container(
                                                      //color: Colors.red,
                                                      width:
                                                          constraint.maxWidth *
                                                              .6,
                                                      child: Text(
                                                        "${rec.name}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF383838),
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      "${rec.age}",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    constraint.maxHeight * .00,
                                              ),
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Text(
                                                      "${rec.country}",
                                                    ),
                                                    Text(
                                                      "Online",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.redAccent),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                            }),
                        Container(
                          child: _isloading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Container(
                                  height: 0,
                                  width: 0,
                                ),
                        )
                      ],
                    ),
                    //here
                  ),
                ],
              ),
      ),
    );
  }
}
