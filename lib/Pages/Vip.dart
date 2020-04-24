import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class Vip extends StatefulWidget {
  @override
  _VipState createState() => _VipState();
}

class _VipState extends State<Vip> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("VIP"),
      ),
      body: Padding(
        padding: EdgeInsets.all(size.height * .025),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10),
              height: 300.0,
              width: double.infinity,
              child: Carousel(
                boxFit: BoxFit.cover,
                autoplay: false,
                animationCurve: Curves.fastOutSlowIn,
                animationDuration: Duration(milliseconds: 1000),
                dotSize: 6.0,
                dotIncreasedColor: Color(0xFFFF335C),
                dotBgColor: Colors.transparent,
                //dotPosition: DotPosition.topRight,
                dotVerticalPadding: 10.0,
                showIndicator: true,
                indicatorBgPadding: 7.0,
                images: [
                  NetworkImage(
                      'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
                  NetworkImage(
                      'https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
                  ExactAssetImage("assets/images/LaunchImage.jpg"),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              elevation: 3,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                height: size.height * .07,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text("01 Month"),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: size.height * .05,
                        width: size.width * .25,
                        child: Center(
                          child: Text(
                            'Rs 850.00',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
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
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              elevation: 3,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  
                ),
                height: size.height * .07,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text("Lifetime"),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: size.height * .05,
                        width: size.width * .25,
                        child: Center(
                          child: Text(
                            'Rs 10000',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
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
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: size.height * .03),
                child: Text(
                  "Coupon:You can gain 10% free coins once after next recharge.lovghdbvjgcv dsrsrssezfh ugyf f",
                  //overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xFFD94D91),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
