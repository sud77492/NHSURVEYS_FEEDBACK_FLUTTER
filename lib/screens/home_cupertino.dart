import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nhsurveys_feedback/models/question.dart';
import 'package:nhsurveys_feedback/models/response_data.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:nhsurveys_feedback/screens/home_star.dart';

class HomeCupertino extends StatefulWidget {
  final String name;
  final String mobile;

  // receive data from the FirstScreen as a parameter
  HomeCupertino({Key key, @required this.name, @required this.mobile}) : super(key: key);
  @override
  _HomeCupertinoState createState() => _HomeCupertinoState();
}

class _HomeCupertinoState extends State<HomeCupertino> {
  final _formKey = GlobalKey<FormState>();
  List<Question> list = List();
  int count = 0;
  List<ResponseData>response_list = List();
  ResponseData responseData;

  

  void _fetchData() async {
      
    final response = await http.get("http://10.0.2.2/nhsurveys/api/v1/init",headers: {
            'Accept': 'application/json',
            "api-key": "c5ebcee3af05a5ae1b6a09c668ba798c"});
    
    if (response.statusCode == 200) {
      Map<String, dynamic> apiResponse = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        list = (apiResponse['questions'] as List)
        .map((data) => new Question.fromJson (data))
        .toList();
        //print(list[0].options[0].option_english);
        print('sudhanshu');
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();

    print(count);
    print(list.length);
  }

  @override
  Widget build(BuildContext context) {
    if (list == null) {
      return new CupertinoPageScaffold(
      );
    } else {

    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(middle: Text('Form Demo')),
        child:
            // NOTE by default, iOS uses 'extended layout' and therefore content can appear
            // underneath the navigation bar. typically iOS controls such as UIScrollView
            // and UITableView take the navigation bar into consideration to prevent this, but
            // in Flutter, a SafeArea widget is required.
            SafeArea(
                child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30.0),
                  child:Text(
                    list[count].question_english,
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                
              ),
              Container(
                margin: const EdgeInsets.only(top: 30.0),
                height: 200.0,
                width: 100.0,
                child: new Column(
                  
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                        Container(
                            child : ButtonTheme( 
                            minWidth: 150.0,
                            height: 100.0,
                          
                            child: RaisedButton(
                              color: Color.fromRGBO(255,20,147, 1),
                              onPressed: () {
                                //if(count < list.length){
                                  setState(() {  
                                    if(count < 7){
                                      responseData = ResponseData(list[count].question_id, 5, list[count].options[0].option_id);
                                      response_list.add(responseData);
                                      print(response_list[0].question_id);
                                      //responseData = ResponseData(question_id, response, response_id)
                                      count = count + 1;
                                    }else{
                                      navigateToSubPage(context);
                                    }
                                  });
                              },
                              child: Text(list[count].options[0].option_english),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child : ButtonTheme(
                            minWidth: 150.0,
                            height: 100.0,
                            
                            child: RaisedButton(
                              padding: const EdgeInsets.all(20),
                              color: Color.fromRGBO(127,255,0, 1),
                              onPressed: () {
                                setState(() {  
                                  if(count < 7){
                                    responseData = ResponseData(list[count].question_id, 4, list[count].options[1].option_id);
                                    response_list.add(responseData);
                                    print(response_list[0].question_id);
                                    count = count + 1;
                                  }else{
                                    navigateToSubPage(context);
                                  }
                                  
                                });
                              },
                              child: Text(list[count].options[1].option_english),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child : ButtonTheme(
                            minWidth: 150.0,
                            height: 100.0,
                            
                            child: RaisedButton(
                              padding: const EdgeInsets.all(20),
                              color: Color.fromRGBO(255, 255, 0, 1),
                              onPressed: () {
                                setState(() {  
                                  if(count < 7){
                                    responseData = ResponseData(list[count].question_id, 3, list[count].options[2].option_id);
                                    response_list.add(responseData);
                                    print(response_list[2].question_id);
                                    print(response_list.length);
                                    count = count + 1;
                                  }else{
                                    navigateToSubPage(context);
                                  }
                                });
                              },
                              child: Text(list[count].options[2].option_english),
                            ),
                          ),
                        ),
                        /*Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child : ButtonTheme(
                            minWidth: 150.0,
                            height: 100.0,
                            child: RaisedButton(
                              padding: const EdgeInsets.all(20),
                              color: Color.fromRGBO(255,165,0, 1),
                              onPressed: () {
                                setState(() {  
                                  if(count < 5){
                                    count = count + 1;
                                  }else{
                                    navigateToSubPage(context);
                                  }
                                });
                              },
                              child: Text("test"),
                            ),
                          ),
                        )*/
                        
                       
                        ],
                      ),
                  ]
                ),
              ),
              Container(
                
                //color: Colors.red,
                
                
              ),
              
              /*Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 100.0, horizontal: 100.0),
                child: CupertinoButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _showDialog();
                    }
                  },
                  child: Text('Test'),
                  color: Theme.of(context).primaryColor,
                ),
              ),*/

            ],
          ),
        )));
    }
  }

  Future navigateToSubPage(BuildContext context) async {
    Navigator.push(context, MaterialPageRoute<void>(builder: (context) => HomeStar()));
  }

  void _showDialog() {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: const Text('Hello'),
              content: const Text('Submitting form'),
              actions: [
                CupertinoDialogAction(
                  child: const Text('Dismiss'),
                  onPressed: () {
                    Navigator.pop(context, 'Dismiss');
                  },
                )
              ],
            ));
  }

  /*void _fetchData() async {
      
    final response = await http.get("http://10.0.2.2/nhsurveys/api/v1/init",headers: {
            'Accept': 'application/json',
            "api-key": "c5ebcee3af05a5ae1b6a09c668ba798c"});
    
    if (response.statusCode == 200) {
      Map<String, dynamic> apiResponse = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        list = (apiResponse['questions'] as List)
        .map((data) => new Question.fromJson (data))
        .toList();
        //print(list[0].options[0].option_english);
        print('sudhanshu');
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }*/
}
