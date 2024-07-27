import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/Provider/AuthProvider/auth_provider.dart';
import 'package:provider_api/Screens/Authentication/register.dart';

import '../../Utils/routers.dart';
import '../../Utils/snack_message.dart';
import '../../Widgets/button.dart';
import '../../Widgets/text_field.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  //In Flutter, the dispose method is used to clean up resources
  //when a widget is removed from the widget tree.
  @override
  void dispose() {
    _email.clear();
    _password.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login ')),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    customTextField(
                      title: 'Email',
                      controller: _email,
                      hint: 'Enter you valid email address',
                    ),
                    customTextField(
                      title: 'Password',
                      controller: _password,
                      hint: 'Enter your secured password',
                    ),
                    Consumer<AuthenticationProvider>(
                      builder: (context, auth, child) {
                        WidgetsBinding.instance!.addPostFrameCallback((_) {
                          if (auth.resMessage != '') {
                            showMessage(
                                message: auth.resMessage, context: context);

                            ///Clear the response message to avoid duplicate
                            auth.clear();
                          }
                        });
                        return customButton(
                            text: 'Login',
                            tap: () {
                              if (_email.text.isEmpty || _password.text.isEmpty) {
                                showMessage(
                                    message: "All fields are required",
                                    context: context);
                              } else {
                                auth.loginUser(
                                    context: context,
                                    //trim is used to remove spaces before & after String
                                    email: _email.text.trim(),
                                    password: _password.text.trim());
                              }
                            },
                            context: context,
                            status: auth.isLoading,
                        );
                      }

                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        PageNavigator(ctx: context)
                            .nextPage(page: const RegisterPage());
                      },
                      child: const Text('Register Instead'),
                    )
                  ],
                )
            ),
          )
        ],
      ),
    );
  }
}
