import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nhsurveys_feedback/screens/home_cupertino.dart';
import 'package:provider/provider.dart';
import 'package:nhsurveys_feedback/providers/auth.dart';
import 'package:nhsurveys_feedback/models/question.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart'; 
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeStar extends StatefulWidget {
  @override
  _HomeStarState createState() => _HomeStarState();
}

class _HomeStarState extends State<HomeStar> {
  final _formKey = GlobalKey<FormState>();
  List<Question> list = List();
  double rating = 0.0;

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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(20.0),
                            child: SmoothStarRating(
                              allowHalfRating: false,
                              onRatingChanged: (v) {
                                rating = v;
                                setState(() {});
                              },
                              starCount: 5,
                              rating: rating,
                              size: 40.0,
                              color: Colors.green,
                              borderColor: Colors.green,
                              spacing:0.0
                            )
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            child : TextFormField(
                              decoration: new InputDecoration(
                              contentPadding: new EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
                              border: new OutlineInputBorder(
                                  borderSide: new BorderSide(color: Colors.teal)),
                              hintText: 'Comment',
                              prefixText: ' ',
                              //suffixText: 'USD',
                              suffixStyle: const TextStyle(color: Colors.green)),
                            ),
                          ),
                          
                          
                          Container(
                              margin: const EdgeInsets.only(top: 20.0),
                              color: Color.fromRGBO(255,20,147, 1),
                              child: RaisedButton(
                                  onPressed: () {
                                    //_fetchData();
                                    //navigateToSubPage(context);
                                  },
                                  textColor: Color.fromRGBO(255,255,255, 1),
                                  color: Color.fromRGBO(255,20,147, 1),
                                  child: Text('START SURVEY'))),
                        ])))));
  }

  Future navigateToSubPage(BuildContext context) async {
    Navigator.push(context, MaterialPageRoute<void>(builder: (context) => HomeCupertino()));
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
