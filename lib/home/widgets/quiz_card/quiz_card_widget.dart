import 'package:dev_quiz/core/app_colors.dart';
import 'package:dev_quiz/core/app_images.dart';
import 'package:dev_quiz/core/app_text_styles.dart';
import 'package:dev_quiz/shared/models/quiz_model.dart';
import 'package:dev_quiz/shared/widgets/progress_indicator/progress_indicator_widget.dart';
import 'package:flutter/material.dart';

class QuizCardWidget extends StatelessWidget {
  final QuizModel quiz;
  final String completed;
  final double percent;
  final VoidCallback onTap;

  const QuizCardWidget({
    Key? key,
    required this.quiz,
    required this.completed,
    required this.percent,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.fromBorderSide(
                BorderSide(color: AppColors.border),
              ),
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  child: Image.asset(AppImages.data),
                ),
                SizedBox(height: 16),
                Text(
                  quiz.title,
                  style: AppTextStyles.heading15,
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        completed,
                        style: AppTextStyles.body11,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: ProgressIndicatorWidget(
                        value: percent,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
