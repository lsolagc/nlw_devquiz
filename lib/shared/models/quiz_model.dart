import 'dart:convert';

import 'package:dev_quiz/shared/models/question_model.dart';
import 'package:flutter/cupertino.dart';

enum Level {
  facil,
  medio,
  dificil,
  perito,
}

extension LevelStringExt on String {
  Level get levelParse => {
        "facil": Level.facil,
        "medio": Level.medio,
        "dificil": Level.dificil,
        "perito": Level.perito,
      }[this]!;
}

extension LevelExt on Level {
  String get parse => {
        Level.facil: "facil",
        Level.medio: "medio",
        Level.dificil: "dificil",
        Level.perito: "perito",
      }[this]!;
}

class QuizModel {
  final String title;
  final List<QuestionModel> questions;
  final ValueNotifier<int> answeredQuestionsNotifier = ValueNotifier(0);
  final String image;
  final Level level;

  set answeredQuestions(int value) => {
        if (value > questions.length)
          {value = questions.length}
        else
          {answeredQuestionsNotifier.value = value}
      };
  int get answeredQuestions => answeredQuestionsNotifier.value;

  QuizModel({
    required this.title,
    required this.questions,
    answeredQuestions = 0,
    required this.image,
    required this.level,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'questions': questions.map((x) => x.toMap()).toList(),
      'answeredQuestions': answeredQuestions,
      'image': image,
      'level': level.parse,
    };
  }

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      title: map['title'] ?? '',
      questions: List<QuestionModel>.from(
          map['questions']?.map((x) => QuestionModel.fromMap(x))),
      answeredQuestions: map['answeredQuestions'] ?? 0,
      image: map['image'] ?? '',
      level: map['level'].toString().levelParse,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizModel.fromJson(String source) =>
      QuizModel.fromMap(json.decode(source));
}
