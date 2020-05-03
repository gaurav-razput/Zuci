import 'package:flutter/material.dart';
import 'package:zuci/Screen/Language.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Widget settingopt(titleText,choose) {
    return InkWell(
      onTap: (){
        switch(choose){
          case 1:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Language(),
                ),
              );
              break;
            }
        }
      },
          child: ListTile(
        leading: Text(titleText),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Column(
        children: <Widget>[
          settingopt("Language",1),
          settingopt("Privacy Policy",2),
          settingopt("Feedback",3),
          settingopt("Rate Us",4),
          settingopt("About Us",5),
          settingopt("Blocked List",6),
        ],
      ),
    );
  }
}
