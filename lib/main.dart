import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/Styles/colors.dart';

import 'Provider/AuthProvider/auth_provider.dart';
import 'Provider/DataBase/db_provider.dart';
import 'Screens/Authentication/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (contexto){ return AuthenticationProvider(); }),
        ChangeNotifierProvider(create: (contexto){ return DatabaseProvider(); })
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: primaryColor
          ),
          primaryColor: primaryColor
        ),
        home: const loginPage(),
      ),
    );
  }
}
