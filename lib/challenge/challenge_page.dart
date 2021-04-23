import 'package:dev_quiz/challenge/challenge_controller.dart';
import 'package:dev_quiz/challenge/widgets/next_button/next_button_widget.dart';
import 'package:dev_quiz/challenge/widgets/question_indicator/question_indicator_widget.dart';
import 'package:dev_quiz/challenge/widgets/quiz/quiz_widget.dart';
import 'package:dev_quiz/result/result_page.dart';
import 'package:dev_quiz/shared/models/quiz_model.dart';
import 'package:flutter/material.dart';

class ChallengePage extends StatefulWidget {
  final QuizModel quiz;
  // final List<QuestionModel> questions;
  // final String quizTitle;
  ChallengePage({Key? key, required this.quiz}) : super(key: key);

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final controller = ChallengeController();
  final pageController = PageController();

  @override
  void initState() {
    pageController.addListener(() {
      controller.currentPage = pageController.page!.toInt() + 1;
    });
    super.initState();
  }

  void nextPage() {
    if (controller.currentPage < widget.quiz.questions.length) {
      pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.linear);
    }
  }

  void onSelected(bool value) {
    if (value) {
      controller.rightAnswers++;
    }
    nextPage();
    widget.quiz.answeredQuestions++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(102),
        child: SafeArea(
          top: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButton(),
              ValueListenableBuilder<int>(
                valueListenable: controller.currentPageNotifier,
                builder: (context, value, _) => QuestionIndicatorWidget(
                  currentPage: value,
                  quizSize: widget.quiz.questions.length,
                ),
              )
            ],
          ),
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        children: widget.quiz.questions
            .map((e) => QuizWidget(
                  question: e,
                  onSelected: (value) {
                    onSelected(value);
                  },
                ))
            .toList(),
        controller: pageController,
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ValueListenableBuilder<int>(
              valueListenable: controller.currentPageNotifier,
              builder: (context, value, _) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (value < widget.quiz.questions.length)
                    Expanded(
                      child: NextButtonWidget.white(
                          label: "Pular",
                          onTap: () {
                            nextPage();
                          }),
                    ),
                  if (value == widget.quiz.questions.length)
                    SizedBox(
                      width: 7,
                    ),
                  if (value == widget.quiz.questions.length)
                    Expanded(
                      child: NextButtonWidget.green(
                          label: "Confirmar",
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultPage(
                                  quiz: widget.quiz,
                                  result: controller.rightAnswers,
                                ),
                              ),
                            );
                          }),
                    )
                ],
              ),
            )),
      ),
    );
  }
}
