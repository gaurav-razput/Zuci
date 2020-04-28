import 'package:flutter/widgets.dart';
import 'package:zuci/Firebase/Authentication.dart';
import 'package:zuci/Firebase/user_model.dart';

class UserProvider with ChangeNotifier {
  User _user;
  auth _auth=auth();
  User get getUser => _user;

  void refreshUser() async {
    User user = await _auth.getUserDetails();
    _user = user;
    notifyListeners();
  }

}