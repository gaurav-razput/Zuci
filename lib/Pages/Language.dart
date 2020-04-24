

import 'package:flutter/material.dart';

class Language extends StatefulWidget {
  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  Widget languageopt(titleText,choose) {
    return InkWell(
      onTap: (){
        switch(choose){
          case 1:
            {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => Language(),
              //   ),
              // );
              break;
            }
        }
      },
          child: ListTile(
        leading: Icon(Icons.person),
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
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  
                 
                  height:size.height*.1,
                  width: size.width*.2,
                  child: Image.asset("assets/Image/lang.png"),
              ),
              Container(
                  margin: EdgeInsets.only(top:10,bottom: 10),
                  child: Text("Choose your preferred Language",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
              ),
              Divider(),
              languageopt("Default System Language", 1),
              Divider(),
              languageopt("Bahasa Indonesia", 1),
              Divider(),
              languageopt("English", 1),
              Divider(),
              languageopt("Francais", 1),
              Divider(),
              languageopt("Hindi", 1),
              Divider(),
            ],
          ),
                ),
        ),
      ),
      
    );
  }
}