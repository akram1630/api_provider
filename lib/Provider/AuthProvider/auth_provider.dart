import 'dart:convert';
import 'dart:io';

import '../../Constants/url.dart';
import 'package:flutter/foundation.dart'; //ChangeNotifier
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../Screens/Authentication/login.dart';
import '../../Utils/routers.dart';
class AuthenticationProvider extends ChangeNotifier {

  ///Base Url
  final requestBaseUrl = AppUrl.baseUrl;

  ///Setter
  bool _isLoading = false;
  String _resMessage = '';

  //Getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  void registerUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = "${requestBaseUrl}api/register/";

    final body = {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password
    };
    print(body);

    try {
      http.Response req =
      await http.post(Uri.parse(url), body: body);

      if (req.statusCode == 200 || req.statusCode == 201) {
        print(200);
        print(req.body);
        _isLoading = false;
        _resMessage = "Account created!";
        notifyListeners();
        PageNavigator(ctx: context).nextPageOnly(page: const loginPage());
      } else {
        final res = json.decode(req.body);

        _resMessage = res['message'];

        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available`";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again`";
      notifyListeners();

      print(":::: $e");
    }
  }

  //Login
  void loginUser({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = "${requestBaseUrl}api/token/";
    print(url);
    final body = {
      "username" : email,
      "password" : password
    };
    print(body);

    try {
      http.Response req =
      await http.post(Uri.parse(url), body: body);

      if (req.statusCode == 200 || req.statusCode == 201) {
        print(200);
        print(req.body);
        // final res = json.decode(req.body);
        // print(res);
        _isLoading = false;
        _resMessage = "Login successfull!";
        notifyListeners();

        //Save Token then navigate to homepage
        // final userId = res['user']['id'];
        // final token = res['authToken'];
        // DatabaseProvider().saveToken(token);
        // DatabaseProvider().saveUserId(userId);
        //PageNavigator(ctx: context).nextPageOnly(page: const HomePage());
      } else {
        print(404);

        final res = json.decode(req.body);

        _resMessage = res['message'];

        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      print(504);

      _isLoading = false;
      _resMessage = "Internet connection is not available`";
      notifyListeners();
    } catch (e) {
      print(604);

      _isLoading = false;
      _resMessage = "Please try again`";
      notifyListeners();

      print(":::: $e");
    }
  }
  void clear() {
    _resMessage = "";
    // _isLoading = false;
    notifyListeners();
  }
}
