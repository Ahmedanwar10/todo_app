

import 'package:flutter/cupertino.dart';
import 'package:todo/database/model/user.dart';

class AuthinProvider extends ChangeNotifier{
  User? currentUser;
  void updateUser(User loggedInUser){
    currentUser = loggedInUser;
  notifyListeners();
  }
}
