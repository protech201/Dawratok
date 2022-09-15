
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../Provider/firestoreProvider.dart';
import '../Colors.dart';
import '../Widget/CourseWidget.dart';

class AllCoursesScreen extends StatelessWidget {
  const AllCoursesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreProvider>(
      builder: (context,provider,x) {
        return Scaffold(
          appBar: AppBar(
            title: Text('كل الدورات'),
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
          body:
          provider.Courses.isNotEmpty?
          ListView.builder(
            itemCount: provider.Courses.length,
              itemBuilder: ((context, index) {
                return CourseWidget(
                  nameCourse: context.locale.toString()=='ar'?
                  provider.Courses[index].nameCourse
                      :provider.Courses[index].nameCourseEn,
                  content: context.locale.toString()=='ar'?
                  provider.Courses[index].content
                      :provider.Courses[index].contentEn,
                  imageUrl: provider.Courses[index].imageUrl,
                  course: provider.Courses[index],
                  stars: provider.Courses[index].stars,
                );
              }))
          :Center(child: Lottie.asset('assets/animation/courses.json'),),
        );
      }
    );
  }
}
