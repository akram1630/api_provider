import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseProvider extends ChangeNotifier {
  //final _pref = SharedPreferences.getInstance(); //auto_type_detect
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  String _token = '';
  String _userId = '';
  String get token => _token;
  String get userId => _userId;
  void saveToken(String token) async {
    SharedPreferences value = await _pref;
    value.setString('token', token);
  }
  void saveUserId(String id) async {
    SharedPreferences value = await _pref;
    value.setString('id', id);
  }
  Future<String> getToken() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('token')) { //if not empty
      String data = value.getString('token')!;
      _token = data;
      notifyListeners();
      return data;
    } else {
      _token = '';
      notifyListeners();
      return '';
    }
  }

  Future<String> getUserId() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('id')) {
      String data = value.getString('id')!;
      _userId = data;
      notifyListeners();
      return data;
    } else {
      _userId = '';
      notifyListeners();
      return '';
    }
  }

}