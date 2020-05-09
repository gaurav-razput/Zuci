import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nanoid/generate.dart';

import 'package:zuci/Screen/HomePage.dart';

class RegisterWithGoogle extends StatefulWidget {
  final uid;
  final gmail;
  final profile;
  RegisterWithGoogle({
    this.uid,
    this.gmail,
    this.profile,
});
  @override
  _RegisterWithGoogleState createState() => _RegisterWithGoogleState();
}

class _RegisterWithGoogleState extends State<RegisterWithGoogle> {


  String _email;
  String _password;
  String _username;
  String _phone_no;
  String _gender='Male';
  bool _isLoading;
  String _age;
  String _country;

  final _formKey = new GlobalKey<FormState>();
  final databaseReference = Firestore.instance;



  @override
  void initState() {
    _isLoading = false;
    super.initState();
  }
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void register(uid) async {
    try {
      DocumentReference documentReference =
      Firestore.instance.document('USER/$uid');
      Map<String, String> info = <String, String>{
        'name': '$_username',
        'email': '${widget.gmail}',
        'phone_no': '$_phone_no',
        'Id': generate('1234567890', 8),
        'gender':_gender,
        'Coins': '0',
        'Binded': '0',
        'followers': '0',
        'following': '0',
        'uid': uid,
        'age':_age,
        'bio':'',
        'callrate':'',
        'country':_country,
        'profile_pic':'${widget.profile}'
      };
      await documentReference.setData(info).whenComplete(() {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      });
    } catch (e) {
      print(e.message);
    }
  }

  void validateAndRegister() async {
    if (validateAndSave()) {
      setState(() {
        _isLoading = true;
      });

      try {
        register(widget.uid);
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _formKey.currentState.reset();
        });
      }
    }
  }

  Widget _showCircularProgress() {
    Size size = MediaQuery.of(context).size;
    if (_isLoading) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.black12,
          backgroundBlendMode: BlendMode.darken,
        ),
        child: Center(child: CircularProgressIndicator()),
        height: size.height,
        width: size.width,
      );
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    Center(
                      // child: Image.asset("assets/Image/IMG_4073.jpg"),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.height * .015,
                        right: size.height * .015,
                        top: size.height * .05,
                      ),
                      child: Card(
                        elevation: 3.0,
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: size.height * .16,
                              width: double.infinity,
                              child: Image.asset(
                                "assets/Image/IMG_4073.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: size.height * .02,
                                right: size.height * .02,
                                top: size.height * .01,
                                bottom: size.height * .01,
                              ),
                              child: TextFormField(
                                keyboardType:TextInputType.numberWithOptions(),
                                decoration: InputDecoration(
                                  labelText: 'Phone number',
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: Colors.purpleAccent,
                                    size: size.height * .03,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                    borderSide: BorderSide(color: Colors.black38),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                    borderSide: BorderSide(color: Colors.black87),
                                  ),
                                ),
                                validator: (value) =>
                                value.isEmpty ? 'Phone number cann\'t empty' : null,
                                onSaved: (value) => _phone_no = value.trim(),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: size.height * .02,
                                right: size.height * .02,
                                top: size.height * .01,
                                bottom: size.height * .01,
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  prefixIcon: Icon(
                                    Icons.supervised_user_circle,
                                    color: Colors.purpleAccent,
                                    size: size.height * .03,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                    borderSide: BorderSide(color: Colors.black38),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                    borderSide: BorderSide(color: Colors.black87),
                                  ),
                                ),
                                validator: (value) =>
                                value.isEmpty ? 'Username cann\'t empty' : null,
                                onSaved: (value) => _username = value.trim(),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: size.height * .02,
                                right: size.height * .02,
                                top: size.height * .01,
                                bottom: size.height * .01,
                              ),
                              child: Container(
                                height: 50.0,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Gender",style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 19
                                    ),),
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                          value: 'Male',
                                          groupValue: _gender,
                                          onChanged:(value){
                                            setState(() {
                                              _gender=value;
                                            });
                                          },
                                          activeColor: Colors.purpleAccent,
                                        ),
                                        Text('Male',style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 19
                                        ),),

                                      ],
                                    ),
                                    Row(children: <Widget>[
                                      Radio(
                                        value: 'Female',
                                        groupValue: _gender,
                                        onChanged:(value){
                                          setState(() {
                                            _gender=value;
                                          });
                                        },
                                        activeColor: Colors.purpleAccent,
                                      ),
                                      Text('Female',style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 19
                                      ),)
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: size.height * .02,
                                right: size.height * .02,
                                top: size.height * .01,
                                bottom: size.height * .01,
                              ),
                              child: TextFormField(
                                keyboardType:TextInputType.numberWithOptions(),
                                decoration: InputDecoration(
                                  labelText: 'Age',
                                  prefixIcon: Icon(
                                    Icons.date_range,
                                    color: Colors.purpleAccent,
                                    size: size.height * .03,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                    borderSide: BorderSide(color: Colors.black38),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                    borderSide: BorderSide(color: Colors.black87),
                                  ),
                                ),
                                validator: (value) =>value.isEmpty? 'Age cann\'t empty' : null,
                                onSaved: (value) => _age = value.trim(),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: size.height * .02,
                                right: size.height * .02,
                                top: size.height * .01,
                                bottom: size.height * .01,
                              ),
                              child: TextFormField(
                                keyboardType:TextInputType.numberWithOptions(),
                                decoration: InputDecoration(
                                  labelText: 'Country',
                                  prefixIcon: Icon(
                                    Icons.date_range,
                                    color: Colors.purpleAccent,
                                    size: size.height * .03,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                    borderSide: BorderSide(color: Colors.black38),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                    borderSide: BorderSide(color: Colors.black87),
                                  ),
                                ),
                                validator: (value) =>value.isEmpty? 'Country cann\'t empty' : null,
                                onSaved: (value) => _country = value.trim(),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: size.height * .04,
                                right: size.height * .04,
                                top: size.height * .02,
                                bottom: size.height * .03,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  validateAndRegister();
                                  print('register$_email,$_password');
                                },
                                child: Container(
                                  height: size.height * .07,
                                  child: Center(
                                    child: Text(
                                      'REGISTER',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: Colors.white10,
                                    ),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: [0.2, 1],
                                      colors: [
                                        Color(0xFFB44EB1),
                                        Color(0xFFDA4D91),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(size.height * .005),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'You have an Account? ',
                            style: TextStyle(),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                  color: Color(0xFFB44EB1),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
            _showCircularProgress()
          ],
        ));
  }
  }

