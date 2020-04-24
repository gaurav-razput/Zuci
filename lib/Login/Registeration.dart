import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:zuci/Firebase/Authentication.dart';
import 'package:zuci/Pages/check_auth_page.dart';

class Registration extends StatefulWidget {
  Registration({this.auth, this.loginCallback});

  final firebase_methods auth;
  final VoidCallback loginCallback;
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String _email;
  String _password;
  String _username;
  String _phone_no;

  String _errorMessage;
  bool _isLoading;

  final _formKey = new GlobalKey<FormState>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final databaseReference = Firestore.instance;

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    super.initState();
  }

  void Register(user_id) async {
    Firestore db = Firestore.instance;

    try {
      print('Register call');
      print(user_id);

      DocumentReference documentReference =
          Firestore.instance.document('USER/${user_id}');
      Map<String, String> info = <String, String>{
        'name': '$_username',
        'email': '$_email',
        'phone_no': '$_phone_no'
      };
      await documentReference.setData(info).whenComplete(() {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Check_Status(auth: auth())));
      });
    } catch (e) {
      print('Register catch ');
      print(e.message);
    }
  }

  void validateAndRegister() async {
    if (validateAndSave()) {
      setState(() {
        _errorMessage = "";
        _isLoading = true;
      });

      try {
        AuthResult result = await _firebaseAuth
            .createUserWithEmailAndPassword(email: _email, password: _password)
            .whenComplete(() {
          print('user created');
        });
        FirebaseUser user = result.user;

        Register(user.uid);

        if (user.uid.length > 0 && user.uid != null) {
          widget.loginCallback();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

//  Widget custom_text_field(name, values, Icons) {
//    return Padding(
//      padding: const EdgeInsets.all(20.0),
//      child: TextFormField(
//        decoration: InputDecoration(
//          labelText: name,
//          icon: Icon(
//            Icons,
//            color: Colors.purpleAccent,
//            size: 35.0,
//          ),
//          focusedBorder: OutlineInputBorder(
//            borderRadius: BorderRadius.all(Radius.circular(10.0)),
//            borderSide: BorderSide(color: Colors.black38),
//          ),
//          enabledBorder: OutlineInputBorder(
//            borderRadius: BorderRadius.all(Radius.circular(10.0)),
//            borderSide: BorderSide(color: Colors.black87),
//          ),
//        ),
//        validator: (value) => value.isEmpty ? '$name can\'t be empty' : null,
//        onSaved: (value) => values = value.trim(),
//        obscureText:  name =="Password" ?true:false,
//      ),
//    );
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Center(
                  child: Text(
                    'ZUCI',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
                    elevation: 5.0,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              icon: Icon(
                                Icons.email,
                                color: Colors.purpleAccent,
                                size: 35.0,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.black38),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.black87),
                              ),
                            ),
                            validator: (value) =>
                                value == _email ? 'Email cann\'t empty' : null,
                            onSaved: (value) => _email = value.trim(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Phone number',
                              icon: Icon(
                                Icons.phone,
                                color: Colors.purpleAccent,
                                size: 35.0,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.black38),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.black87),
                              ),
                            ),
                            validator: (value) => value == _phone_no
                                ? 'Password cann\'t empty'
                                : null,
                            onSaved: (value) => _phone_no = value.trim(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Username',
                              icon: Icon(
                                Icons.supervised_user_circle,
                                color: Colors.purpleAccent,
                                size: 35.0,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.black38),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.black87),
                              ),
                            ),
                            validator: (value) => value == _username
                                ? 'Username cann\'t empty'
                                : null,
                            onSaved: (value) => _username = value.trim(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Password',
                              icon: Icon(
                                Icons.lock,
                                color: Colors.purpleAccent,
                                size: 35.0,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.black38),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.black87),
                              ),
                            ),
                            obscureText: true,
                            validator: (value) => value == _password
                                ? 'Password cann\'t empty'
                                : null,
                            onSaved: (value) => _password = value.trim(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              icon: Icon(
                                Icons.lock,
                                color: Colors.purpleAccent,
                                size: 35.0,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.black38),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.black87),
                              ),
                            ),
                            obscureText: true,
                            validator: (value) => value == _password
                                ? 'Password doesn\'t match'
                                : null,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 30.0),
                          child: GestureDetector(
                            onTap: () {
                              validateAndRegister();
                              print('register$_email,$_password');
                            },
                            child: Container(
                              height: 50.0,
                              child: Center(
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: Colors.white10,
                                  ),
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: [
                                        0.2,
                                        1
                                      ],
                                      colors: [
                                        Colors.purple,
                                        Colors.pinkAccent
                                      ])),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'You have an account?',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'LogIn',
                          style: TextStyle(
                              color: Colors.purpleAccent, fontSize: 20.0),
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
