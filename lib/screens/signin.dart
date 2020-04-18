import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:nhsurveys_feedback/providers/auth.dart';
import 'package:nhsurveys_feedback/utils/validate.dart';
import 'package:nhsurveys_feedback/screens/home_material.dart';
import 'package:nhsurveys_feedback/screens/signin.dart';

class LoginMaterial extends StatefulWidget {
  @override
  _LoginMaterialState createState() => _LoginMaterialState();
}

class _LoginMaterialState extends State<LoginMaterial> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String message = '';

  Future<void> submit() async {
    final form = _formKey.currentState;
    if (form.validate()) {

      await Provider.of<AuthProvider>(context).login(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.pink, // navigation bar color
      statusBarColor: Colors.pink, // status bar color
    ));
    return Scaffold(
        appBar: AppBar(title: Text('Profile')),
        body: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Builder(
                builder: (context) => Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            child : TextFormField(
                              decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide: new BorderSide(color: Colors.teal)),
                              hintText: 'Username',
                              prefixText: ' ',
                              suffixStyle: const TextStyle(color: Colors.green)),
                              validator: (value) {
                                email = value.trim();
                                return Validate.validateEmail(value);
                              }
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            child : TextFormField(
                              decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide: new BorderSide(color: Colors.teal)),
                              hintText: 'Password',
                              prefixText: ' ',
                              suffixStyle: const TextStyle(color: Colors.green)),
                              validator: (value){
                                password = value.trim();
                                return Validate.requiredField(value, 'Password is required.');
                              }
                            ),

                          ),
                          
                          
                          Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            color: Color.fromRGBO(255,20,147, 1),
                            child: RaisedButton(
                              onPressed: () {
                                submit();
                                //navigateToSubPage(context);
                              },
                              textColor: Color.fromRGBO(255,255,255, 1),
                              color: Color.fromRGBO(255,20,147, 1),
                              child: Text('LOGIN')
                            )
                          ),
                        ]
                      )
                    )
                  )
                )
              );
  }

  Future navigateToSubPage(BuildContext context) async {
    Navigator.push(context, MaterialPageRoute<void>(builder: (context) => HomeMaterial()));
  }

  void _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Submitting form')));
  }
}
