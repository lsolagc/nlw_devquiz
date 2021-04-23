import 'package:dev_quiz/splash/splash_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  // final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "DevQuiz",
      home: SplashPage(),
      // navigatorObservers: [routeObserver],
    );
  }
}
