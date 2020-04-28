
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zuci/Call/call_method.dart';
import 'package:zuci/Call/call_model.dart';
import 'package:zuci/Call/video_call/pickup_screen.dart';


class PickupLayout extends StatefulWidget {
  PickupLayout({@required this.scaffold});
  final Widget scaffold;

  @override
  _PickupLayoutState createState() => _PickupLayoutState();
}

class _PickupLayoutState extends State<PickupLayout> {
  final CallMethods callMethods =CallMethods();
  FirebaseUser user;
  bool loading=false;
  getuser() async{
     user = await FirebaseAuth.instance.currentUser().whenComplete((){
       setState(() {
         loading=true;
       });
     });
     print('User id is ${user.uid}');
  }
  @override
  void initState() {
    // TODO: implement initState
    getuser();
//    print(user.uid);
  }

  @override
  Widget build(BuildContext context) {
    print(user.uid);
    return (loading ) ? StreamBuilder<DocumentSnapshot>(
      stream: callMethods.callStream(uid: user.uid),
      builder:(context,snapshot){
        if(snapshot.hasData && snapshot.data.data!=null){
          Call call =Call.fromMap(snapshot.data.data);
          return PickupScreen(call: call,user_uid: user.uid,);
        }
        return widget.scaffold;
      } ,
    )
    : Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),

    );
  }
}
