import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zuci/provider/user_provider.dart';
import 'package:zuci/resources/firebase_methods.dart';
import 'package:zuci/utils/universal_variables.dart';

class FavouriteList extends StatefulWidget {
  @override
  _FavouriteListState createState() => _FavouriteListState();
}

class _FavouriteListState extends State<FavouriteList> {

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite List'),
        backgroundColor: Colors.pinkAccent,
      ),
      body:StreamBuilder<QuerySnapshot>(
          stream: FirebaseMethods().fetchSubscribe(
            userId: userProvider.getUser,
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

                  return Custom_tile(uid:docList[index].data['to']);
                },
              );
            }

            return Center(child: CircularProgressIndicator());
          }),
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
          color: UniversalVariables.separatorColor,
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
              SizedBox(height: 25),
//              FlatButton(
//                color: UniversalVariables.lightBlueColor,
//                child: Text("START SEARCHING"),
//                onPressed: () => Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                    builder: (context) => SearchScreen(),
//                  ),
//                ),
//              ),
            ],
          ),
        ),
      ),
    );
  }
}
class Custom_tile extends StatefulWidget {
  final uid;
  Custom_tile({this.uid});
  @override
  _Custom_tileState createState() => _Custom_tileState();
}

class _Custom_tileState extends State<Custom_tile> {
  String name,gmail,id,coin,binded,followers,following,vip,phone_no,uid;
  bool loading=true;
  void getuserdata() async
  {
    var document = await Firestore.instance.collection('USER').document(widget.uid);
    document.get().then((document){
      name = document['name'];
      id=document['Id'];
    }).whenComplete((){
      setState(() {
        loading=false;
      });
    });

  }
  @override
  void initState() {
    super.initState();
    setState(() {
      getuserdata();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Container(
              height: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Center(child: Text("$name")),
                  Center(child: Text("$id"))
                ],
              ),
            ),
          ),
        ),
//        Center(
//          child: loading?CircularProgressIndicator():Container(),
//        )
      ],
    );
  }
}
