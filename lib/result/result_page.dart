import 'package:dev_quiz/challenge/widgets/next_button/next_button_widget.dart';
import 'package:dev_quiz/core/app_images.dart';
import 'package:dev_quiz/core/app_text_styles.dart';
import 'package:dev_quiz/shared/models/quiz_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final QuizModel quiz;
  final int result;
  // final int rightAnswers;

  const ResultPage({
    Key? key,
    required this.quiz,
    required this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 100),
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImages.trophy),
            Column(
              children: [
                Text(
                  "Parabéns!",
                  style: AppTextStyles.heading40,
                ),
                SizedBox(
                  height: 16,
                ),
                Text.rich(
                  TextSpan(
                    text: "Você concluiu ",
                    style: AppTextStyles.body,
                    children: [
                      TextSpan(
                        text: "\n ${quiz.title}",
                        style: AppTextStyles.bodyBold,
                        children: [
                          TextSpan(
                            text:
                                "\ncom $result de ${quiz.questions.length} acertos!",
                            style: AppTextStyles.body,
                          ),
                        ],
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 68),
                        child: NextButtonWidget.purple(
                            label: "Compartilhar",
                            onTap: () {
                              Share.share(
                                  "Compartilhando através do share_plus");
                            }),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 68.0),
                        child: NextButtonWidget.transparent(
                            label: "Voltar ao início",
                            onTap: () {
                              Navigator.pop(context);
                            }),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
