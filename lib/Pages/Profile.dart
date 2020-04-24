import 'package:flutter/material.dart';
import 'package:zuci/Pages/Coins.dart';
import 'package:zuci/Pages/PhoneBind.dart';
import 'package:zuci/Pages/Settings.dart';
import 'package:zuci/Pages/Shair.dart';
import 'package:zuci/Pages/Vip.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
                    Text('id:567565656'),
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
                    Text('id:567565656'),
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
                  builder: (context) => Vip(),
                ),
              );
              break;
            }
          case 2:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Coins(),
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
                  builder: (context) => PhoneBind(),
                ),
              );
              break;
            }
          case 5:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Shair(),
                ),
              );
              break;
            }
          case 6:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Settings(),
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
                    Container(child: Text("0 Followers")),
                    Container(child: Text("0 Following"))
                  ],
                ),
                options(Icons.attach_money, "VIP", 1),
                options(Icons.attach_money, "Get Coins", 2),
                options(Icons.person, "Acount Info", 3),
                options(Icons.phone_iphone, "Phone Bonding", 4),
                options(Icons.share, "Shair", 5),
                options(Icons.settings, "Setting", 6),
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
                        "Name",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(4),
                      child: Text(
                        "id:67567645",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(4),
                      child: Text(
                        "⭐ 250",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
