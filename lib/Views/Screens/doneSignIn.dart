import 'package:dawratok/Views/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../AppRouter.dart';

class DoneSignIn_Screen extends StatelessWidget {
  const DoneSignIn_Screen({Key? key}) : super(key: key);
  initFun()async{
    // Provider.of<FirestoreProvider>(AppRouter.navKey.currentContext!).getAllCourses();
    await Future.delayed(Duration(seconds: 2));
    AppRouter.NavigatorToWidgetWithReplacement(Home_Screen());

  }
  @override
  Widget build(BuildContext context) {
    initFun();
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/animation/done.json'),

      ),
    );
  }
}
