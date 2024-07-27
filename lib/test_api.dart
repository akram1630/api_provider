import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

void loginUser({
  required String email,
  required String password,
}) async {


  String url = "http://localhost:7000/api/token/";

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
      final res = json.decode(req.body);
      print(res);

    } else {
      print(404);

      final res = json.decode(req.body);


    }
  } on SocketException catch (_) {
    print(504);


  } catch (e) {
    print(604);


    print(":::: $e");
  }
}
void main(){
  loginUser(email: 'ramy@gmail.com', password: 'ramy123456');
}