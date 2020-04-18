import 'dart:convert';

class Question {
  final int question_id;
  final String question_english; 

  Question._({this.question_id, this.question_english});

  factory Question.fromJson(Map<String, dynamic> json) {
    return new Question._(
      question_id: json['question_id'],
      question_english: json['question_english'],
    );
  }

  /*Question(this.question_id, this.question_english);
  factory Question.fromJson(dynamic json) {
    return Question(json['question_id'] as int, json['question_english'] as String);
  }

  @override
  String toString() {
    return '{ ${this.question_id}, ${this.question_english} }';
  }*/
}

class Option {
  final int option_id;
  final String option_english;

  Option._({this.option_id, this.option_english});

  factory Option.fromJson(Map<String, dynamic> json) {
    return new Option._(
      option_id: json['option_id'],
      option_english: json['option_english'],
    );
  }

}