import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          child: Container(
            padding: EdgeInsets.only(top: size.height * .025),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                  0.2,
                  1
                ],
                    colors: [
                  Color(0xFFB44EB1),
                  Color(0xFFDA4D91),
                ])),
            child: SafeArea(
                child: Column(
              children: <Widget>[
                TabBar(
                  tabs: [
                    Container(
                      margin: EdgeInsets.only(bottom: size.height * .02),
                      child: Text(
                        'MESSAGES',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: size.height * .02),
                      child: Text(
                        'VIDEO HISTORY',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                   
                  ],
                  //labelColor: Colors.white,
                  indicatorColor: Colors.white,
                )
              ],
            )),
          ),
          preferredSize: Size.fromHeight(size.height * .08),
        ),
        body: TabBarView(
          children: <Widget>[
            // for Messeges
            ListView.builder(
              itemCount: 8,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 6),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  "https://images.pexels.com/photos/247878/pexels-photo-247878.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "HelloWorld",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        "11:23 AM",
                                        style: TextStyle(color: Colors.black45),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: Text(
                                      "chatItem.mostRecentMessage",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            //For Video History
            ListView.builder(
              itemCount: 8,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 6),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  "https://images.pexels.com/photos/247878/pexels-photo-247878.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "HelloWorld",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        "11:23 AM",
                                        style: TextStyle(color: Colors.black45),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                          padding: const EdgeInsets.only(
                                            top: 2.0,
                                          ),
                                          child: Icon(
                                            Icons.videocam,
                                            color: Color(0xFFD34B96),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 2.0, left: 4.0),
                                        child: Text(
                                          "Incoming video call",
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
