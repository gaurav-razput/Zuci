import 'package:flutter/material.dart';

class Shair extends StatefulWidget {
  @override
  _ShairState createState() => _ShairState();
}

class _ShairState extends State<Shair> {
  Widget items(name) {
    return Container(
      padding: EdgeInsets.all(18),
      color: Colors.white,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: AssetImage("assets/$name"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Shair"),
        ),
        body: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 1,
          mainAxisSpacing: 6,
          children: <Widget>[
            items("facebook.png"),
            items("insta.png"),
            items("twiter.png"),
            items("snap.png"),
            items("youtube.png"),
            items("whatsapp.png"),
          ],
        ));
  }
}
