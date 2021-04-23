import 'package:dev_quiz/core/app_colors.dart';
import 'package:dev_quiz/core/app_text_styles.dart';
import 'package:flutter/material.dart';

class ChartWidget extends StatefulWidget {
  final double percent;
  const ChartWidget({Key? key, required this.percent}) : super(key: key);

  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  void initAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animation = Tween<double>(
      begin: 0.0,
      end: widget.percent,
    ).animate(controller);
    controller.forward();
  }

  @override
  void initState() {
    initAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, _) => Stack(
          children: [
            Center(
              child: Container(
                height: 80,
                width: 80,
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                  value: animation.value,
                  backgroundColor: AppColors.chartSecondary,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.chartPrimary),
                ),
              ),
            ),
            Center(
              child: Text(
                "${(animation.value * 100).toInt()} %",
                style: AppTextStyles.heading,
              ),
            )
          ],
        ),
      ),
    );
  }
}
