import 'package:flutter/material.dart';

class PhoneBind extends StatefulWidget {
  @override
  _PhoneBindState createState() => _PhoneBindState();
}

class _PhoneBindState extends State<PhoneBind> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD94D91),
        title: Text("Phone Binding"),
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width * .06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              //color: Colors.red,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: size.height * .35,
                    child: Image.asset("assets/handphone.png"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.height * .03),
                    child: Text(
                      "You haven't bound the phone",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height: size.height * .07,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.phone_iphone,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size.width * .05),
                        child: Text(
                          'Binding Now',
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
                  // color: Colors.black26,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.2, 1],
                    colors: [Color(0xFFB44EB1), Color(0xFFDA4D91)],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * .03),
              child: Text(
                "Reward for Binding",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Color(0xFF505050)),
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: size.height * .03, right: 8),
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: Color(0xFFD94D91),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * .03),
                  child: Text(
                    "20 free messages for chat",
                    style: TextStyle(color: Color(0xFFD94D91)),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: size.height * .03, right: 8),
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: Color(0xFFD94D91),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: size.height * .03),
                    child: Text(
                      "Coupon:You can gain 10% free coins once after next recharge.",
                      //overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color(0xFFD94D91),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
