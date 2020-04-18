import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:nhsurveys_feedback/providers/auth.dart';

class Loading extends StatelessWidget {

  initAuthProvider(context) async {
    Provider.of<AuthProvider>(context).initAuthProvider();
  }

  @override
  Widget build(BuildContext context) {

    initAuthProvider(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('To Do App'),
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
            child: new CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}