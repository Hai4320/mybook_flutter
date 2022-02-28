import 'package:flutter/material.dart';

import '../ui/widgets/stateful/login_form.dart';
import '../ui/widgets/stateful/register_form.dart';

class AuthProvider extends ChangeNotifier{
  int _tabindex;
  AuthProvider(this._tabindex);
  int get tab => _tabindex;
  set setTabIndex(int value){
    _tabindex = value;
    ChangeNotifier();
  } 
}