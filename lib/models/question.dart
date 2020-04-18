import 'dart:convert';

class Question {
  final int question_id;
  final String question_english; 
  List<Option> options;

  Question._({this.question_id, this.question_english, this.options});

  factory Question.fromJson(Map<String, dynamic> json) {
    return new Question._(
      question_id: json['question_id'],
      question_english: json['question_english'],
      options: List.from(json['options'])
            .map((data) => Option.fromJson(data))
            .toList()
    );
  }
}

class Option {
  int option_id;
  String option_english;
  Option.fromJson(Map<String, dynamic> optionJson)
      : option_id = optionJson['option_id'],
      option_english = optionJson['option_english'];

}



