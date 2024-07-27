import 'package:flutter/material.dart';


import 'Utils/routers.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: FlutterLogo()),
    );
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 3), () { //wait 3 sec & execute
  //     DatabaseProvider().getToken().then((value) {
  //       if (value == '') {
           //PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
  //       } else {
  //         PageNavigator(ctx: context).nextPageOnly(page: const HomePage());
  //       }
  //     });
    });
  }
}