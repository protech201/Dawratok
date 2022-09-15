import 'package:dawratok/Provider/authProvider.dart';
import 'package:dawratok/Views/Colors.dart';
import 'package:dawratok/Views/Screens/SignInScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../AppRouter.dart';
import '../../Provider/firestoreProvider.dart';

class Splash_Screen extends StatelessWidget {
  initFun()async{
    // Provider.of<FirestoreProvider>(AppRouter.navKey.currentContext!).getAllCourses();
    await Future.delayed(Duration(seconds: 2));
    Provider.of<AuthProvider>(AppRouter.navKey.currentContext!,listen: false).checkUser();
    // AppRouter.NavigatorToWidgetWithReplacement(SignIn_Screen());

  }

  @override
  Widget build(BuildContext context) {
    initFun();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset('assets/images/college-graduation.svg',width: 120.w,),
            Text('دوراتك',style: TextStyle(
              fontSize: 35.h,
              color: Colors_Ui.mainColor
            ),),


          ],
        ),
      ),
    );
  }
}
