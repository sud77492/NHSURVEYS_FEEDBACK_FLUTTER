import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nhsurveys_feedback/screens/home_cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:nhsurveys_feedback/utils/validate.dart';
import 'package:nhsurveys_feedback/providers/auth.dart';
import 'package:nhsurveys_feedback/models/question.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeMaterial extends StatefulWidget {
  @override
  _HomeMaterialState createState() => _HomeMaterialState();
}

class _HomeMaterialState extends State<HomeMaterial> {
  final _formKey = GlobalKey<FormState>();
  List<Question> list = List();
  TextEditingController textFieldController = TextEditingController();
  TextEditingController textFieldController2 = TextEditingController();
  String name;
  String mobile;

  @override
  void initState() {
    super.initState();
    //_fetchData();
  }
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.pink, // navigation bar color
      statusBarColor: Colors.pink, // status bar color
    ));
    //Provider.of<AuthProvider>(context).initApplication();

    var isLoading = false;
    

    

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
                          /*TextFormField(
                            decoration:
                                InputDecoration(labelText: 'First name'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your first name';
                              }
                            },
                          ),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Last name'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your last name.';
                              }
                            }
                          ),*/
                          Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            child : TextFormField(
                              controller: textFieldController,
                              decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide: new BorderSide(color: Colors.teal)),
                              hintText: 'Name',
                              /*validator: (value) {
                                name = value.trim();
                                return Validate.requiredField(value, 'Password is required.');
                              }*/
                              //helperText: 'Keep it short, this is just a demo.',
                              //labelText: 'Life story',
                              /*prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.green,
                              ),*/
                              prefixText: ' ',
                              //suffixText: 'USD',
                              suffixStyle: const TextStyle(color: Colors.green)),
                              validator: (value){
                                name= value.trim();
                                print(name);
                                return "Please Enter Something";
                              },
                              onSaved: (value) => name = value,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            child : TextFormField(
                              controller: textFieldController2,
                              decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.teal)
                              ),
                              hintText: 'Mobile (optional)',
                              prefixText: ' ',
                              
                              suffixStyle: const TextStyle(color: Colors.green)),
                              validator: (value){
                                mobile= value.trim();
                                print(mobile);
                                return "Please Enter Something";
                              },
                              onSaved: (value) => mobile = value,
                            ),
                          ),
                          
                          
                          Container(
                              margin: const EdgeInsets.only(top: 20.0),
                              color: Color.fromRGBO(255,20,147, 1),
                              child: RaisedButton(
                                  onPressed: () {
                                    //_fetchData();
                                    navigateToSubPage(context);
                                  },
                                  textColor: Color.fromRGBO(255,255,255, 1),
                                  color: Color.fromRGBO(255,20,147, 1),
                                  child: Text('START SURVEY'))),
                        ])))));
  }

  Future navigateToSubPage(BuildContext context) async {
    name = textFieldController.text;
    mobile = textFieldController2.text;
    
    Navigator.push(context, MaterialPageRoute<void>(builder: (context) => HomeCupertino(name:name, mobile:mobile)));
  }

  void _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Submitting form')));
  }

  void _fetchData() async {
      
      final response = await http.get("http://10.0.2.2/nhsurveys/api/v1/init",headers: {
              'Accept': 'application/json',
              "api-key": "c5ebcee3af05a5ae1b6a09c668ba798c"});
      
      if (response.statusCode == 200) {
        Map<String, dynamic> apiResponse = json.decode(utf8.decode(response.bodyBytes));
        print(apiResponse['questions'][0]['options'][0]['option_english']);
        //setState(() {
          list = (apiResponse['questions'] as List)
          .map((data) => new Question.fromJson (data))
          .toList();
          print(list[0].options[0].option_english);
          //print('sudhanshu');
        //});
        
        
      } else {
        throw Exception('Failed to load photos');
      }
    }
}
