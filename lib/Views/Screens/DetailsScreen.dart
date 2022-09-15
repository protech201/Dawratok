import 'package:dawratok/AppRouter.dart';
import 'package:dawratok/Modle/Course.dart';
import 'package:dawratok/Provider/authProvider.dart';
import 'package:dawratok/Provider/firestoreProvider.dart';
import 'package:dawratok/Views/Screens/AllStudentsScreen.dart';
import 'package:dawratok/Views/Screens/updateCourseScreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../Colors.dart';
import '../Widget/Dialog.dart';

class Details_Screen extends StatelessWidget {
  // const Details_Screen({Key? key}) : super(key: key);
  Course course ;
  Details_Screen(this.course);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('detailsCourse'.tr()),
        centerTitle: true,
        backgroundColor: Colors_Ui.mainColor,
        actions: [
          Provider.of<AuthProvider>(context).appUser!.isTeacher!?
          IconButton(onPressed: (){
            Provider.of<FirestoreProvider>(context,listen: false).getAllStudents(course.IdCourse);
            AppRouter.NavigatorToWidget(AllStudents_Screen(course));
          },
            icon: Icon(Icons.supervisor_account),) : SizedBox(),

          IconButton(onPressed: (){
          if(context.locale.toString()=='ar')
            context.setLocale(Locale('en'));
          else
            context.setLocale(Locale('ar'));
        },
          icon: Icon(Icons.language),),



        ],
      ),
      body: Consumer<FirestoreProvider>(
        builder: (context,provider,x) {
          return SafeArea(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                  child: Image.network(course.imageUrl,height: 150.h,fit: BoxFit.fill,),
                ),
                RatingBar.builder(
                  glowColor: Colors_Ui.mainColor,
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star_rounded,
                    color: Colors_Ui.mainColor,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(
                  width: 360.w,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('course'.tr() + (context.locale.toString()=='ar'?
                          course.nameCourse
                          :course.nameCourseEn),
                          style: TextStyle(fontSize: 25.sp,color: Colors_Ui.mainColor),),
                        SizedBox(height: 5.h,),
                        Text('teacher'.tr() + (context.locale.toString()=='ar'?
                        course.nameTeacher
                            :course.nameTeacherEn),
                          style: TextStyle(fontSize: 16.sp,color: Colors_Ui.mainColor),),
                        Text('address'.tr() + (context.locale.toString()=='ar'?
                        course.address
                            :course.addressEn),
                          style: TextStyle(fontSize: 16.sp,color: Colors_Ui.mainColor),),
                        Text(course.isOnline?'online'.tr():'offline'.tr(),
                          style: TextStyle(fontSize: 16.sp,color: Colors_Ui.mainColor),),
                        SizedBox(height: 20.h,),
                        Text('detailsCourse'.tr(),
                          style: TextStyle(fontSize: 18.sp,color: Colors_Ui.mainColor),),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 100.h,
                  width: 300.w,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 5,right: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x26000000),
                        offset: Offset(0, 3),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Text((context.locale.toString()=='ar'?
                  course.content
                      :course.contentEn),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors_Ui.main2Color),
                  ),
                ),
                SizedBox(height: 15.h,),
                InkWell(
                  onTap: (){
                    showDialog(
                        context: AppRouter.navKey.currentContext!,
                        builder: (context){
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Lottie.asset('assets/animation/question.json',height: 150.h),
                                Text('Are you sure to enroll in the course?'.tr()),
                                SizedBox(height: 20.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    FlatButton(
                                      color: Colors.green,
                                      textColor: Colors.white,
                                      child: Text('yes'.tr(),style: TextStyle(fontSize: 15.sp),),
                                      onPressed: () {
                                        Provider.of<FirestoreProvider>(context,listen: false).addNewStudent(Provider.of<AuthProvider>(context,listen: false).appUser!, course.IdCourse);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    FlatButton(
                                      color: Colors.red,
                                      textColor: Colors.white,
                                      child: Text('no'.tr(),style: TextStyle(fontSize: 15.sp),),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),

                                  ],
                                ),
                                SizedBox(height: 20.h,),
                              ],
                            ),
                          );
                        });

                  },
                  child: Container(
                    height: 40.h,
                    width: 300.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xff652b54),
                      borderRadius: BorderRadius.circular(7.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x26000000),
                          offset: Offset(0, 3),
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: Text('register'.tr(),style: TextStyle(fontSize: 25.sp,color: Colors.white),),
                  ),
                ),
                SizedBox(height: 5.h,),

                Provider.of<AuthProvider>(context).appUser!.isTeacher!?
                SizedBox(
                  width: 300.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          provider.nameCourseController.text = course.nameCourse;
                          provider.nameCourseEnController.text = course.nameCourseEn;
                          provider.nameTeacherController.text = course.nameTeacher;
                          provider.nameTeacherEnController.text = course.nameTeacherEn;
                          provider.addressController.text = course.address;
                          provider.addressEnController.text = course.addressEn;
                          provider.contentController.text = course.content;
                          provider.contentEnController.text = course.contentEn;
                          provider.starsController.text = course.stars;
                          provider.isOnline = course.isOnline;

                          AppRouter.NavigatorToWidget(Update_Course_Screen(course));
                        },
                        child: Container(
                          height: 40.h,
                          width: 145.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xff652b54),
                            borderRadius: BorderRadius.circular(7.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x26000000),
                                offset: Offset(0, 3),
                                blurRadius: 15,
                              ),
                            ],
                          ),
                          child: Text('edit'.tr(),style: TextStyle(fontSize: 25.sp,color: Colors.white),),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          provider.deleteCourse(course);
                          AppRouter.popFromWidget();
                        },
                        child: Container(
                          height: 40.h,
                          width: 145.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xff652b54),
                            borderRadius: BorderRadius.circular(7.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x26000000),
                                offset: Offset(0, 3),
                                blurRadius: 15,
                              ),
                            ],
                          ),
                          child: Text('delete'.tr(),style: TextStyle(fontSize: 25.sp,color: Colors.white),),
                        ),
                      ),
                    ],
                  ),
                ) :SizedBox(),






              ],
            ),
          );
        }
      ),
    );
  }
}
