import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/Screens/Authentication/login.dart';
import '../../Provider/AuthProvider/auth_provider.dart';
///////// ctrl+f : to replace all words one time like alt+j
import '../../Utils/routers.dart';
import '../../Utils/snack_message.dart';
import '../../Widgets/button.dart';
import '../../Widgets/text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();

  //In Flutter, the dispose method is used to clean up resources
  //when a widget is removed from the widget tree.
  @override
  void dispose() {
    _email.clear();
    _password.clear();
    _firstName.clear();
    _lastName.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    customTextField(
                      title: 'First Name',
                      controller: _firstName,
                      hint: 'Enter you valid first name',
                    ),
                    customTextField(
                      title: 'last Name',
                      controller: _lastName,
                      hint: 'Enter you valid last name',
                    ),
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
                            text: 'Register',
                            tap: () {
                              if (_email.text.isEmpty || _password.text.isEmpty || _lastName.text.isEmpty || _firstName.text.isEmpty) {
                                showMessage(
                                    message: "All fields are required",
                                    context: context);
                              } else {
                                auth.registerUser(
                                    context: context,
                                    email: _email.text.trim(),
                                    password: _password.text.trim(),
                                    firstName: _firstName.text.trim(),
                                    lastName: _lastName.text.trim()
                                );
                              }
                            },
                            context: context,
                            status: auth.isLoading,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        PageNavigator(ctx: context)
                            .nextPage(page: const loginPage());
                      },
                      child: const Text('Login Instead'),
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
