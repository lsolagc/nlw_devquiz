import 'package:flutter/material.dart';

import 'package:dev_quiz/challenge/challenge_page.dart';
import 'package:dev_quiz/core/app_colors.dart';
import 'package:dev_quiz/home/home_state.dart';
import 'package:dev_quiz/home/widgets/app_bar/app_bar_widget.dart';
import 'package:dev_quiz/home/widgets/home_controller.dart';
import 'package:dev_quiz/home/widgets/level_button/level_button_widget.dart';
import 'package:dev_quiz/home/widgets/quiz_card/quiz_card_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
  // State<HomePage> createState() => HomePageState();

}

class _HomePageState extends State<HomePage> {
  // with RouteAware {
  final controller = HomeController();

  // @override
  // void didPopNext() {
  //   print("Next Popped");
  //   setState(() {});
  // }

  @override
  void initState() {
    super.initState();
    controller.getUser();
    controller.getQuizzes();
    controller.stateNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (controller.state == HomeState.success) {
      return Scaffold(
        appBar: AppBarWidget(
          user: controller.user!,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LevelButtonWidget(label: "Fácil"),
                  LevelButtonWidget(label: "Médio"),
                  LevelButtonWidget(label: "Difícil"),
                  LevelButtonWidget(label: "Perito"),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Builder(builder: (context) {
                if (controller.quizzes != null) {
                  return Expanded(
                    child: GridView.count(
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 8,
                        crossAxisCount: 2,
                        children: controller.quizzes!
                            .map((e) => ValueListenableBuilder<int>(
                                valueListenable: e.answeredQuestionsNotifier,
                                builder: (context, value, _) => QuizCardWidget(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChallengePage(
                                                    quiz: e,
                                                  )),
                                        );
                                      },
                                      quiz: e,
                                      completed:
                                          "${e.answeredQuestions}/${e.questions.length}",
                                      percent: e.answeredQuestions /
                                          e.questions.length,
                                    )))
                            .toList()),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
                    ),
                  );
                }
              })
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
          ),
        ),
      );
    }
  }
}
