import 'package:dawratok/AppRouter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../Provider/firestoreProvider.dart';
import '../Colors.dart';
import 'AddCourseScreen.dart';
import 'AllUsersScreen.dart';

class Control_Screen extends StatelessWidget {
  const Control_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('controlBoard'.tr()),
        centerTitle: true,
        backgroundColor: Colors_Ui.mainColor,
        actions: [IconButton(onPressed: (){
          if(context.locale.toString()=='ar')
            context.setLocale(Locale('en'));
          else
            context.setLocale(Locale('ar'));
        },
          icon: Icon(Icons.language),),],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
          InkWell(
            onTap: (){
              AppRouter.NavigatorToWidget(AddCourse_Screen());
      } ,
            child: Container(
              alignment: Alignment.center,
              height: 60.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors_Ui.mainColor,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Text('addCourse'.tr(),style: TextStyle(fontSize: 25.sp,color: Colors.white),),
            ),
          ),
          SizedBox(height: 10.h,),
          InkWell(
              onTap: (){
                AppRouter.NavigatorToWidget(AllUsres_Screen());
              } ,
              child: Container(
                alignment: Alignment.center,
                height: 60.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors_Ui.mainColor,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Text('users'.tr(),style: TextStyle(fontSize: 25.sp,color: Colors.white),),
              ),
            ),
        ],),
      ),
    );
  }
}


