import 'package:flutter/material.dart';

class NxtVideoChat extends StatefulWidget {
  @override
  _NxtVideoChatState createState() => _NxtVideoChatState();
}

class _NxtVideoChatState extends State<NxtVideoChat> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            LayoutBuilder(
              builder: (ctx, constraint) {
                return Container(
                  height: size.height * .45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "https://images.pexels.com/photos/1937394/pexels-photo-1937394.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                      ),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        colors: [
                          Colors.black.withOpacity(.4),
                          Colors.black.withOpacity(.2),
                        ],
                      ),
                    ),
                    child: Stack(
                      children: <Widget>[
                        //For Back Button
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: EdgeInsets.all(4),
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.arrow_back,
                              color: Color(0xFFF5F5F5),
                              size: 30,
                            ),
                          ),
                        ),
                        //For Name Id On Picture
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  width: constraint.maxWidth * .5,
                                  child: Text(
                                    "Katty Perry",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  "24",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  margin:
                                      EdgeInsets.all(constraint.maxWidth * .02),
                                  child: Text(
                                    "Canada",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.all(constraint.maxWidth * .02),
                                  child: Text(
                                    "Zuci ID: 123455",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            //For Buttons
            Container(
              margin: EdgeInsets.all(size.height * .01),
              height: size.height * .05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  buttons(Icons.add_circle, "Follow"),
                  buttons(Icons.call, "Voice Call"),
                  buttons(Icons.message, "Say Hi"),
                ],
              ),
            ),
            //Profile and other Information
            Padding(
              padding: EdgeInsets.only(
                left: size.width * .05,
                right: size.width * .05,
                top: size.height * .01,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Profile",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(),
                  items("Score", "5 Star"),
                  items("Biography", "I love video chat with boys"),
                  items("Price", "24 points/min"),
                  items("Online Time", "21:00 - 19:00"),
                  items("Local Time", "01-21-20 15:59:39"),
                  items("Probability", "100%"),
                  items("Grand Total", "994 minutes(s)"),
                  //Video Call Button
                  InkWell(
                    onTap: () {
                      print("Vidio calling");
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: size.height * .025),
                      height: size.height * .07,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.videocam,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: size.width * .05),
                              child: Text(
                                'Video Call Now',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Colors.white10,
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.2, 1],
                          colors: [Color(0xFFB44EB1), Color(0xFFDA4D91)],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

//Button widget
  Widget buttons(img, txt) {
    return LayoutBuilder(
      builder: (ctx, constraint) {
        return Container(
          padding: EdgeInsets.all(8),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  img,
                  color: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    txt,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: Colors.white10,
            ),
            // color: Colors.black26,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.2, 1],
              colors: [Color(0xFFB44EB1), Color(0xFFDA4D91)],
            ),
          ),
        );
      },
    );
  }

  //profile and details widgets
  Widget items(ques, ans) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            ques,
            style: TextStyle(fontSize: 16),
          ),
          Text(
            ans,
            style: TextStyle(fontSize: 16, color: Color(0xFF686868)),
          ),
        ],
      ),
    );
  }
}
