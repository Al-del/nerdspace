import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nerdspace/nerdfire.dart';

import 'package:nerdspace/widgets/image_bg_scaffold.dart';

class LoginRoute extends StatefulWidget {
  const LoginRoute({super.key});

  @override
  State<LoginRoute> createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  late FocusNode userFocus, passwordFocus, enterFocus;
  @override
  void initState() {
    super.initState();
    userFocus = FocusNode();
    passwordFocus = FocusNode();
    enterFocus = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final pass = TextEditingController();

    ThemeData theme = Theme.of(context);
    return ImageBgScaffold(
      image: Image.asset('assets/fireplace-bg2k.jpg'),
      scaffold: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Text(
                      "Login",
                      style: theme.textTheme.headlineLarge,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                                width: 5.0, color: theme.colorScheme.primary),
                          ),
                        ),
                        focusNode: userFocus,
                      ),
                      TextField(
                        controller: pass,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(
                                  width: 5.0,
                                  color: theme.colorScheme.primary)),
                        ),
                        focusNode: passwordFocus,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          var email = emailController.text;
                          final password = pass.text;
                          NerdFire()
                              .login(email, password)
                              .then((value) =>
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/', (route) => false))
                              .catchError(
                            (error, stackTrace) {
                              print("caught error");
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(error.toString())));
                            },
                          );
                        },
                        child: Text("Login"),
                        focusNode: enterFocus,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text("Register instead?")),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
