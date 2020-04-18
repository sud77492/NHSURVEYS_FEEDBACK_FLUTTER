import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'app.dart';
import 'package:flutter/material.dart';
import 'package:nhsurveys_feedback/providers/auth.dart';
import 'package:nhsurveys_feedback/providers/todo.dart';
import 'package:nhsurveys_feedback/screens/signin.dart';
import 'package:nhsurveys_feedback/views/loading.dart';
import 'package:nhsurveys_feedback/views/login.dart';
import 'package:nhsurveys_feedback/views/register.dart';
import 'package:nhsurveys_feedback/views/password_reset.dart';
import 'package:nhsurveys_feedback/views/todos.dart';
import 'package:nhsurveys_feedback/screens/home_material.dart';
import 'package:flutter/material.dart';
import 'screens/home_cupertino.dart';
import 'screens/home_material.dart';
import 'screens/signin.dart';
import 'screens/login.dart';
import 'views/register.dart';
import 'package:flutter/services.dart';

void main() {

  runApp(
    ChangeNotifierProvider(
      builder: (context) => AuthProvider(),
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Router(),
          '/login': (context) => LoginMaterial(),
          '/register': (context) => Register(),
          '/password-reset': (context) => PasswordReset(),
        },
      ),
    ),
  );
}

class Router extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.pink, // navigation bar color
      statusBarColor: Colors.pink, // status bar color
    ));  

    final authProvider = Provider.of<AuthProvider>(context);

    return Consumer<AuthProvider>(
      builder: (context, user, child) {
        switch (user.status) {
          case Status.Uninitialized:
            print("Loading");
            return Loading();
          case Status.Unauthenticated:
            print("Login");
            return LoginMaterial();
          case Status.Authenticated:
            print("Main");
            return HomeMaterial();
            // return ChangeNotifierProvider(
            //   builder: (context) => TodoProvider(authProvider),
            //   child: Todos(),
            // );
          default:
            print("default");
            return LoginMaterial();
        }
      },
    );
  }
}
