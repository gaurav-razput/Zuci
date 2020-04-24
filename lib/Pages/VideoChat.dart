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
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          
          child: Container(
            padding: EdgeInsets.only(top:size.height*.025),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.2, 1],
                    colors: [Color(0xFFB44EB1), Color(0xFFDA4D91),])),
            child: SafeArea(
                child: Column(
              children: <Widget>[
                TabBar(
                  tabs: [
                    Container(
                      margin: EdgeInsets.only(bottom: size.height*.02),
                      child: Text(
                        'LIVE',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: size.height*.02),
                      child: Text(
                        'RANDOM',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: size.height*.02),
                      child: Text(
                        'NEW',
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
          preferredSize: Size.fromHeight(size.height*.08),
        ),
        body: TabBarView(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: size.height * .02),
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
                    ),
                    child: GridView.builder(
                      shrinkWrap: true,
                      //physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: .67,
                          crossAxisSpacing: size.width * .05,
                          mainAxisSpacing: size.height * .02),
                      itemCount: 30,
                      itemBuilder: (context, i) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFF0F0F0),
                        ),
                        height: size.height * .3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              height: size.height * .23,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  "https://images.pexels.com/photos/247120/pexels-photo-247120.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(size.height * .01),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    width: size.width * .3,
                                    child: Text(
                                      "Katty Perry",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Color(0xFF383838),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "24",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * .002,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    "🇮🇳  India",
                                  ),
                                  Text(
                                    "Online",
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
