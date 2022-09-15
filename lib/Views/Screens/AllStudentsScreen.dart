import 'package:dawratok/Data/Firestore_helper.dart';
import 'package:dawratok/Modle/Course.dart';
import 'package:dawratok/Provider/firestoreProvider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../Colors.dart';

class AllStudents_Screen extends StatelessWidget {
  Course course;
  AllStudents_Screen(this.course);
  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreProvider>(
      builder: (context,provider,x) {
        return Scaffold(
          appBar: AppBar(
            title: Text('students'.tr()),
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
            child: ListView.builder(
                itemCount: provider.Students.length,
                itemBuilder: ((context, index) {
                  return Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                      borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20.r,
                          child: Text(provider.Students[index].userName.characters.first,style: TextStyle(fontSize: 20.sp,color: Colors.white)),
                          backgroundColor: Colors_Ui.mainColor,
                        ),
                        SizedBox(width: 10.w,),
                        Text(provider.Students[index].userName,style: TextStyle(fontSize: 20.sp),),
                        Spacer(),
                        IconButton(onPressed: (){
                          provider.deleteStudent(provider.Students[index].id!, course.IdCourse);

                        },
                          icon: Icon(Icons.delete,color: Colors.red,),)
                      ],
                    ),
                  );
                })),
          ),
        );
      }
    );
  }
}
