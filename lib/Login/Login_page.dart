import 'package:flutter/material.dart';
import 'package:zuci/Firebase/Authentication.dart';
import 'package:zuci/Login/Registeration.dart';

class LoginPAge extends StatefulWidget {
  LoginPAge({this.auth, this.loginCallback});

  final firebase_methods auth;
  final VoidCallback loginCallback;

  @override
  _LoginPAgeState createState() => _LoginPAgeState();
}

class _LoginPAgeState extends State<LoginPAge> {
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
        userId = await widget.auth.signIn(_email, _password);
        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null ) {
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
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: Stack(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset("assets/Image/IMG_4073.jpg"),
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  child: Card(
                    elevation: 3.0,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: TextStyle(fontSize: 20.0),
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
                            validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
                            onSaved: (value) => _email = value.trim(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(fontSize: 20.0),
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
                            validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
                            onSaved: (value) => _password = value.trim(),
                            obscureText: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 8.0, 15.0, 8.0),
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
                          padding:
                          const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 30.0),
                          child: GestureDetector(
                            onTap: (){
                              print('Login button is press');
                              validateAndSubmit();
                            },
                            child: Container(
                              height: 50.0,
                              child: Center(
                                child: Text(
                                  'LogIn',
                                  style: TextStyle(
                                      fontSize: 20.0, fontWeight: FontWeight.bold),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: Colors.white10,
                                  ),
//                              color: Colors.black26,
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: [0.2, 1],
                                      colors: [Colors.purple, Colors.pinkAccent])
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Or login with',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: (){
                                    print("Google button is press");
                                  },
                                  child: Container(
                                    height: 55.0,
                                    width: 55.0,
                                    child:
                                    Image.asset("assets/Image/image8-2.jpg"),
                                  ),
                                ),
                                SizedBox(
                                  width: 50.0,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    print("Google button is press");
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(40.0))
                                    ),
                                    height: 55.0,
                                    width: 55.0,
                                    child:
                                    Image.asset("assets/Image/image8-2.jpg"),
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
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.pink),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Registration()));
                      },
                    )
                  ],
                )
              ],
            ),
          ),//form
          _showCircularProgress(),

        ],
      )
    );
  }
}
