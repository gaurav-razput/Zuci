import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zuci/Firebase/Authentication.dart';
import 'package:zuci/Firebase/user_model.dart';
import 'package:zuci/Message/message_page.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  bool loading;
  String user_uid;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  cur_uid()async{
    FirebaseUser user = await _firebaseAuth.currentUser().whenComplete((){
      setState(() {
       loading=false;
      });
    });

   user_uid=user.uid;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cur_uid();
    loading =true;
  }
  Widget _showCircularProgress() {
    Size size = MediaQuery.of(context).size;
    if (loading) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.black12,
          backgroundBlendMode: BlendMode.darken,

        ),
        child: Center(
            child: CircularProgressIndicator()
        ),
        height: size.height,
        width: size.width,
      );
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.2, 1],
                  colors: [Colors.purple, Colors.pinkAccent]),
            ),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  TabBar(
                    tabs: [
                      Container(
                        child: Text(
                          'Messages',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Container(
                        child: Text(
                          'Video History',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ],
                    labelColor: Colors.white,
                    indicatorColor: Colors.white,
                  )
                ],
              ),
            ),
          ),
          preferredSize: Size.fromHeight(32.0),
        ),
        body: Stack(

          children: <Widget>[
            TabBarView(
              children: <Widget>[
                // for Messeges
                StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection("USER").snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (_, index) {
                          User rec=User(
                            name: snapshot.data.documents[index].data["name"],
                            uid: snapshot.data.documents[index].data["uid"]
                          );

                          return ListTile(
                              title:Text(snapshot.data.documents[index].data["name"]),
                              subtitle:Text(snapshot.data.documents[index].data["Id"]),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Chat_page(receiver: rec,)));
                            },
                          );

                        },
                      );
                    }
                  },
                ),
                //For Video History
                ListView.builder(
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Chat_page()));
                      },
                      child: Column(
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
                      ),
                    );
                  },
                ),
              ],
            ),
    _showCircularProgress(),
          ],
        ),
      ),
    );
  }
}
