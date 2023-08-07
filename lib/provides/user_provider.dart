import 'package:flutter/material.dart';
import 'package:instagram/models/user.dart';
import 'package:instagram/resources/auth_methods.dart';

class UserProvider with ChangeNotifier{
  User? _user;
  final Authmethod _authmethod = Authmethod();

  User get getuser => _user!;

Future<void> refreshUser()async{
  User user = await _authmethod.getUserDetails();
  _user = user;
  notifyListeners();
}
}