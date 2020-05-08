import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zuci/Screen/video_chat2.dart';
import 'package:zuci/models/user.dart';
import 'package:zuci/provider/user_provider.dart';
import 'package:zuci/resources/firebase_methods.dart';

class VideoChat extends StatefulWidget {
  @override
  _VideoChatState createState() => _VideoChatState();
}

class _VideoChatState extends State<VideoChat> {
  FirebaseMethods firebaseMethods =FirebaseMethods();

  String gender;
  String gen;
  bool _isloading;
  void Gender(uid) async{
    print('Gender is called');
     gen=await firebaseMethods.gender(uid).whenComplete((){
       setState(() {
         if(gen=='Female'){
           gender='Male';
         }
         else{
           gender='Female';
         }
         print('Setstate is called');
         _isloading=false;
       });
     });
  }
  UserProvider userProvider;
  @override
  void initState() {
    UserProvider userProvider = Provider.of<UserProvider>(context,listen: false);
    super.initState();
    print('Initstate called');
    _isloading=true;
    Gender(userProvider.getUser);
    setState(() {
      _isloading=false;
    });
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
                  child:Padding(
                    padding: EdgeInsets.only(
                      left: size.width * .05,
                      right: size.width * .05,
                      top: size.height * .03,
                    ),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance.collection("USER").where('gender',isEqualTo: gender).snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return new Text('Error: ${snapshot.error}');
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: itemHeight / itemWidth,
                                  crossAxisSpacing: size.width * .05,
                                  mainAxisSpacing: size.height * .02),

                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (_, index) => LayoutBuilder(
                                builder: (ctx, constraint) {
                                  User rec = User(
                                    name: snapshot.data.documents[index].data["name"],
                                    uid: snapshot.data.documents[index].data["uid"],
                                    id:snapshot.data.documents[index].data['Id'],
                                    age: snapshot.data.documents[index].data['age'],
                                    bio: snapshot.data.documents[index].data['bio'],
                                    callrate: snapshot.data.documents[index].data['callrate'],
                                    country: snapshot.data.documents[index].data['country'],
                                    onlinetime: snapshot.data.documents[index].data['onlinetime'],
                                    profilePhoto: snapshot.data.documents[index].data['profile_pic'],
                                  );
                                  print(rec.bio);
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => NxtVideoChat(receiver:rec,user:userProvid.getUser),
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
                                                borderRadius:
                                                BorderRadius.circular(10)),
                                            height: constraint.maxHeight *
                                                .75, //size.height * .23,
                                            width: double.infinity,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Image.network(snapshot.data.documents[index].data['profile_pic']==null?"https://images.pexels.com/photos/1937394/pexels-photo-1937394.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500":
                                              snapshot.data.documents[index].data['profile_pic'],
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
                                                    "${rec.name}",
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
                                            height: constraint.maxHeight * .00,
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
                            );
                          }
                        }),
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
                      stream: Firestore.instance.collection("USER").where('gender',isEqualTo: gender).snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return new Text('Error: ${snapshot.error}');
                        }
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: itemHeight / itemWidth,
                                crossAxisSpacing: size.width * .05,
                                mainAxisSpacing: size.height * .02),

                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (_, index) => LayoutBuilder(
                              builder: (ctx, constraint) {
                                User rec = User(
                                  name: snapshot.data.documents[index].data["name"],
                                  uid: snapshot.data.documents[index].data["uid"],
                                  id:snapshot.data.documents[index].data['Id'],
                                  age: snapshot.data.documents[index].data['age'],
                                  bio: snapshot.data.documents[index].data['bio'],
                                  callrate: snapshot.data.documents[index].data['callrate'],
                                  country: snapshot.data.documents[index].data['country'],
                                  onlinetime: snapshot.data.documents[index].data['onlinetime'],
                                  profilePhoto: snapshot.data.documents[index].data['profile_pic'],

                                );
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NxtVideoChat(receiver:rec),
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
                                              borderRadius:
                                              BorderRadius.circular(10)),
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
                                                  "${rec.name}",
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
                                          height: constraint.maxHeight * .00,
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
                          );
                        }
                      }),
                  Container(
                    child: _isloading?Center(child: CircularProgressIndicator(),):Container(height: 0,width: 0,),
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
              child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection("USER").snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return new Text('Error: ${snapshot.error}');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: itemHeight / itemWidth,
                            crossAxisSpacing: size.width * .05,
                            mainAxisSpacing: size.height * .02),

                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (_, index) => LayoutBuilder(
                          builder: (ctx, constraint) {
                            User rec = User(
                              name: snapshot.data.documents[index].data["name"],
                              uid: snapshot.data.documents[index].data["uid"],

                            );
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NxtVideoChat(receiver:rec),
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
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
                                              "${rec.name}",
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
                                      height: constraint.maxHeight * .00,
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
                      );
                    }
                  }),
              //here
            ),
          ],
        ),
      ),
    );
  }
}
