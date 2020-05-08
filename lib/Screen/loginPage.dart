import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zuci/Screen/HomePage.dart';
import 'package:zuci/Screen/Registration.dart';
import 'package:zuci/Screen/Rgisterwithgoogle.dart';
import 'package:zuci/resources/firebase_methods.dart';


class LoginPAge extends StatefulWidget {
  @override
  _LoginPAgeState createState() => _LoginPAgeState();
}

class _LoginPAgeState extends State<LoginPAge> {
  FirebaseMethods firebaseMethods=FirebaseMethods();
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;
  bool _isLoading;

  @override
  void initState() {
    _errorMessage = "";
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

  void validateAndSubmit() async {
    if (validateAndSave()) {
      setState(() {
        _errorMessage = "";
        _isLoading = true;
      });
      String userId = "";
      try {
        userId = await FirebaseMethods().signIn(_email, _password);
        setState(() {
          _isLoading = false;
        });
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));

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
    Size size = MediaQuery.of(context).size;
    if (_isLoading) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.black12,
          backgroundBlendMode: BlendMode.darken,

        ),
        child: Center(
            child: CircularProgressIndicator()
        ),
        height: size.height,
        width: size.width,
      );
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }


  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //resizeToAvoidBottomPadding: true,
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * .08,
                    left: size.width * .05,
                    right: size.width * .05),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: size.height*.16,
                        width: double.infinity,
                        child: Image.asset("assets/Image/IMG_4073.jpg",fit: BoxFit.cover,),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: size.height * .015,
                          bottom: size.height * .015,
                        ),
                        child: Card(
                          elevation: 3.0,
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(
                                  size.width * .04,
                                ),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.0),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(
                                  size.width * .03,
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                    labelStyle: TextStyle(fontSize: 16.0),
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
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Color(0xFFC84EA1),
                                      size: size.height * .03,
                                    ),
                                  ),
                                  validator: (value) => value.isEmpty
                                      ? 'Email can\'t be empty'
                                      : null,
                                  onSaved: (value) => _email = value.trim(),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(size.width * .03),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    labelStyle: TextStyle(fontSize: 16.0),
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
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Color(0xFFC84EA1),
                                      size: size.height * .03,
                                    ),
                                  ),
                                  validator: (value) => value.isEmpty
                                      ? 'Password can\'t be empty'
                                      : null,
                                  onSaved: (value) => _password = value.trim(),
                                  obscureText: true,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0.0, size.height * .01,
                                    size.width * .04, size.height * .01),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    GestureDetector(
                                      child: Text('Forgot Password?'),
                                      onTap: () {
                                        print('forgot password');
                                      },
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    size.width * .05,
                                    size.height * .015,
                                    size.width * .05,
                                    size.height * .035),
                                child: GestureDetector(
                                  onTap: () {
                                    print('Login button is press');
                                    validateAndSubmit();
                                  },
                                  child: Container(
                                    height: size.height * .065,
                                    child: Center(
                                      child: Text(
                                        'LOGIN',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(
                                        color: Colors.red,
                                      ),
                                      // color: Colors.black26,
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        stops: [0.2, 1],
                                        colors: [
                                          Color(0xFFB44EB1),
                                          Color(0xFFDA4D91)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Or login with',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(
                                  size.height * .02,
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          print("Google button is press");
                                          performLogin();
                                        },
                                        child: Container(
                                          // color: Colors.red,
                                          height: size.height * .05,
                                          width: size.width * .1,
                                          child: Image.asset(
                                              "assets/Image/googlelogin.png"),
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width * .12,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          print("Google button is press");
                                        },
                                        child: Container(
                                          //color: Colors.red,
                                          height: size.height * .06,
                                          width: size.width * .11,
                                          child: Image.asset(
                                              "assets/Image/fblogin.png"),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account?"),
                          GestureDetector(
                            child: Container(
                              child: Text(
                                'Register',
                                style: TextStyle(color: Color(0xFFB44EB1),),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Registration()));
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ), //form
              _showCircularProgress(),
            ],
          ),
        ));
  }
  void performLogin() {

    setState(() {
      _isLoading=true;
    });

    firebaseMethods.signInWithgoogle().then((FirebaseUser user) {
      if (user != null) {
        authenticateUser(user);
      }
    });
  }
  void authenticateUser(FirebaseUser user) {
    firebaseMethods.authenticateUserbygamil(user).then((isNewUser) {
      setState(() {
//        isLoginPressed = false;
      });

      if (isNewUser) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterWithGoogle(uid: user.uid,gmail: user.email,profile: user.photoUrl,)));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
              return HomePage();
            }));
      }
    });
  }
}
