import 'package:flutter/material.dart';
import 'screens/home_cupertino.dart';
import 'screens/home_material.dart';
import 'screens/signin.dart';
import 'screens/login.dart';
import 'views/register.dart';
import 'package:flutter/services.dart';

class App extends StatelessWidget {
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
    return MaterialApp(
      home: Register(),
    );
  }
}
