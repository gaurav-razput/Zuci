import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zuci/Screen/loginPage.dart';


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  FirebaseUser user ;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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


  String name,gmail,id,coin,binded,followers,following,vip,phone_no;
  bool loading=true;

  void getuserdata() async
  {
    user = await FirebaseAuth.instance.currentUser();
    print(user.uid);
    var document = await Firestore.instance.collection('USER').document(user.uid);
    document.get().then((document){
      name = document['name'];
      gmail = document['gmail'];
      id=document['Id'];
      coin=document['Coins'];
      binded=document['Binded'];
      followers=document['followers'];
      following=document['following'];
      vip=document['Vip'];
      phone_no=document['phone_no'];
    }).whenComplete((){
      setState(() {
        loading=false;
      });
    });

  }
  @override
  void initState() {
    super.initState();
    getuserdata();

  }
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
                    Text('Id:${user.uid}'),
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
                    Text("Id:${user.uid}"),
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
//                  builder: (context) => Vip(),
                ),
              );
              break;
            }
          case 2:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
//                  builder: (context) => Coins(),
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
//                  builder: (context) => PhoneBind(),
                ),
              );
              break;
            }
          case 5:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
//                  builder: (context) => Shair(),
                ),
              );
              break;
            }
          case 6:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
//                  builder: (context) => Settings(),
                ),
              );
              break;
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  color: Colors.blueAccent,
                  height: size.height * .37,
                  width: double.infinity,
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(child: Text("$followers Followers")),
                    Container(child: Text("$following Following"))
                  ],
                ),
                options(Icons.attach_money, "VIP", 1),
                options(Icons.attach_money, "Get Coins", 2),
                options(Icons.person, "Acount Info", 3),
                options(Icons.phone_iphone, "Phone Bonding", 4),
                options(Icons.share, "Share", 5),
                options(Icons.settings, "Setting", 6),
                ListTile(
                  title: Text('Logout',style: TextStyle(fontSize: 30.0),),
                  trailing: Icon(Icons.arrow_back_ios),
                  onTap: ()=>_firebaseAuth.signOut().whenComplete((){
                    Navigator.pop(context);
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPAge()));
                  }),

                )
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
                      backgroundImage: NetworkImage(
                          "https://images.pexels.com/photos/3762775/pexels-photo-3762775.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                    ),
                    Container(
                      margin: EdgeInsets.all(4),
                      child: Text(
                        "$name",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(4),
                      child: Text(
                        "Id:$id",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(4),
                      child: Text(
                        "⭐ $coin",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            _showCircularProgress(),
          ],
        ),//Stack
      ),//sinlechildscrollview
    );
  }
}