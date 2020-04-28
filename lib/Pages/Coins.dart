import 'package:flutter/material.dart';

class Coins extends StatefulWidget {
  @override
  _CoinsState createState() => _CoinsState();
}

class _CoinsState extends State<Coins> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(18),
          width: double.infinity,
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Available Coins",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "0",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                  child: Text(
                    "Additional free VIP duration can be accumulated",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: 30,
                itemBuilder: (context, i) => Container(
                  color: Color(0xFFF9D2D7),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        // color: Colors.red,
                        height:size.height * .08,
                        width: size.width * .15,
                        child: Image.asset("assets/Image/coins.png"),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: Text("309"),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: size.height * .042,
                          width: size.width * .25,
                          child: Center(
                            child: Text(
                              'RS56',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
