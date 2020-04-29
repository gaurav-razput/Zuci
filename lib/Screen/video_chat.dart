import 'package:flutter/material.dart';
import 'package:zuci/Screen/video_chat2.dart';

class VideoChat extends StatefulWidget {
  @override
  _VideoChatState createState() => _VideoChatState();
}

class _VideoChatState extends State<VideoChat> {
  @override
  Widget build(BuildContext context) {
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
                          childAspectRatio: itemHeight / itemWidth,
                          crossAxisSpacing: size.width * .05,
                          mainAxisSpacing: size.height * .02),
                      itemCount: 30,
                      itemBuilder: (context, i) => LayoutBuilder(
                        builder: (ctx, constraint) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NxtVideoChat(),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFFF0F0F0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: constraint.maxHeight *
                                        .75, //size.height * .23,
                                    width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        "https://images.pexels.com/photos/1937394/pexels-photo-1937394.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(
                                        constraint.maxHeight * .025),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                          //color: Colors.red,
                                          width: constraint.maxWidth * .6,
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
                                    height: constraint.maxHeight * .01,
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
                                          style: TextStyle(
                                              color: Colors.redAccent),
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
                    ),
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
              child: GridView.builder(
                shrinkWrap: true,
                //physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: itemHeight / itemWidth,
                    crossAxisSpacing: size.width * .05,
                    mainAxisSpacing: size.height * .02),
                itemCount: 30,
                itemBuilder: (context, i) => LayoutBuilder(
                  builder: (ctx, constraint) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NxtVideoChat(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFF0F0F0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              height: constraint.maxHeight *
                                  .75, //size.height * .23,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  "https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              margin:
                              EdgeInsets.all(constraint.maxHeight * .025),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    //color: Colors.red,
                                    width: constraint.maxWidth * .6,
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
                              height: constraint.maxHeight * .01,
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
                    );
                  },
                ),
              ),
            ),
            // For New tabBar
            Padding(
              padding: EdgeInsets.only(
                left: size.width * .05,
                right: size.width * .05,
                top: size.height * .03,
              ),
              child: GridView.builder(
                shrinkWrap: true,
                //physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: itemHeight / itemWidth,
                    crossAxisSpacing: size.width * .05,
                    mainAxisSpacing: size.height * .02),
                itemCount: 30,
                itemBuilder: (context, i) => LayoutBuilder(
                  builder: (ctx, constraint) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NxtVideoChat(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFF0F0F0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              height: constraint.maxHeight *
                                  .75, //size.height * .23,
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
                              margin:
                              EdgeInsets.all(constraint.maxHeight * .025),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    //color: Colors.red,
                                    width: constraint.maxWidth * .6,
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
                              height: constraint.maxHeight * .01,
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
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
