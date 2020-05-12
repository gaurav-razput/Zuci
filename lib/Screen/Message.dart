import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zuci/Screen/chat_screen/chat_page.dart';
import 'package:zuci/Screen/live/live_host.dart';
import 'package:zuci/Screen/live/live_method.dart';
import 'package:zuci/models/contact.dart';
import 'package:zuci/models/message.dart';
import 'package:zuci/models/user.dart';
import 'package:zuci/provider/user_provider.dart';
import 'package:zuci/resources/firebase_methods.dart';
import 'package:zuci/utils/permissions.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  bool loading;
  String user_uid;
  User userinfo;
  LiveMethod liveMethod = LiveMethod();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  cur_uid() async {
    FirebaseUser user = await _firebaseAuth.currentUser().whenComplete(() {
      setState(() {
        loading = false;
      });
    });
    user_uid = user.uid;
    userinfo = User(uid: user.uid);
  }

  String token;
  @override
  void initState() {
    super.initState();
    cur_uid();
    loading = true;
  }

  Widget _showCircularProgress() {
    Size size = MediaQuery.of(context).size;
    if (loading) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.black12,
          backgroundBlendMode: BlendMode.darken,
        ),
        child: Center(child: CircularProgressIndicator()),
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
    UserProvider userProvider = Provider.of<UserProvider>(context);
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            print('in message inside float pass uid to host ${userProvider.getUser.uid}');
            token = await liveMethod.GoLiveMethod(
                    userProvider.getUser.uid,
                    userProvider.getUser.gender,
                    userProvider.getUser.name,
                    userProvider.getUser.age,
                    userProvider.getUser.country,context);

          },
          child: Icon(Icons.video_call),
        ),
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
                            margin: EdgeInsets.only(
                                top: constraint.maxHeight * .27,
                                bottom: constraint.maxHeight * .27),
                            child: Text(
                              'MESSAGES',
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
                              'VIDEO HISTORY',
                              style: TextStyle(
                                fontSize: constraint.maxHeight * .32,
                              ),
                            ),
                          ),
                        ],
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
            // for Messeges
            Stack(
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseMethods().fetchContacts(
                      userId: userProvider.getUser.uid,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var docList = snapshot.data.documents;

                        if (docList.isEmpty) {
                          return QuietBox();
                        }
                        return ListView.builder(
                          padding: EdgeInsets.all(10),
                          itemCount: docList.length,
                          itemBuilder: (context, index) {
                            Contact contact =
                                Contact.fromMap(docList[index].data);
                            return ContactView(contact);
                          },
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    }),
                _showCircularProgress(),
              ],
            ),
            //For Video History
            Stack(
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseMethods().fetchHistory(
                      userId: userProvider.getUser.uid,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var docList = snapshot.data.documents;

                        if (docList.isEmpty) {
                          return QuietBoxHistory();
                        }
                        return ListView.builder(
                          padding: EdgeInsets.all(10),
                          itemCount: docList.length,
                          itemBuilder: (context, index) {
                            return history(
                              uid: docList[index].data['to'],
                              call: docList[index].data['call'],
                              time: DateTime.fromMicrosecondsSinceEpoch(
                                  docList[index]
                                      .data['time']
                                      .microsecondsSinceEpoch),
                            );
                          },
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    }),
                _showCircularProgress(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ContactView extends StatelessWidget {
  final Contact contact;

  ContactView(this.contact);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: FirebaseMethods().getUserDetailsById(contact.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data;

          return ViewLayout(
            contact: user,
          );
        }
        return Center(
          child: Container(),
        );
      },
    );
  }
}

class ViewLayout extends StatelessWidget {
  final User contact;

  ViewLayout({
    @required this.contact,
  });
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Card(
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Chat_page(
              receiver: contact,
              sen: userProvider.getUser,
            ),
          ),
        ),
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
                      backgroundImage: contact.profilePhoto == null
                          ? AssetImage('assets/Image/person.png')
                          : NetworkImage(contact.profilePhoto),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                (contact != null ? contact.name : null) != null
                                    ? contact.name
                                    : "..",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 19),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: LastMessageContainer(
                              stream: FirebaseMethods().fetchLastMessageBetween(
                                senderId: userProvider.getUser.uid,
                                receiverId: contact.uid,
                              ),
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
        ),
      ),
    );
  }
}

class LastMessageContainer extends StatelessWidget {
  final stream;
  LastMessageContainer({
    @required this.stream,
  });
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          var docList = snapshot.data.documents;
          if (docList.isNotEmpty) {
            Message message = Message.fromMap(docList.last.data);
            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                message.message,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            );
          }
          return Text(
            "No Message",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          );
        }
        return Text(
          "..",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        );
      },
    );
  }
}

class QuietBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 35, horizontal: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "This is where all the contacts are listed",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 25),
              Text(
                "Search for your friends and family to start calling or chatting with them",
                textAlign: TextAlign.center,
                style: TextStyle(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuietBoxHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 35, horizontal: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "This is where all the call History are listed",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 25),
              Text(
                "Call for your friends and family.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class history extends StatefulWidget {
  final uid;
  final call;
  final time;
  history({this.uid, this.call, this.time});
  @override
  _historyState createState() => _historyState();
}

class _historyState extends State<history> {
  String name, profileurl;
  bool loading;
  void getuserdata(uid) async {
    var document =
        await Firestore.instance.collection('USER').document(widget.uid);
    document.get().then((document) {
      name = document['name'];
      profileurl = document['profile_pic'];
    }).whenComplete(() {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loading = true;
    getuserdata(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: <Widget>[
              Card(
                child: Padding(
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
                                    '$name',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    "${widget.time}".substring(11, 16),
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
                                      widget.call == 'dial'
                                          ? 'Outgoing'
                                          : 'Incoming',
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
              ),
            ],
          );
  }
}
