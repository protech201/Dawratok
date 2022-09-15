import 'package:dawratok/Modle/Course.dart';
import 'package:dawratok/Provider/firestoreProvider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../AppRouter.dart';
import '../../Provider/authProvider.dart';
import '../Colors.dart';
import '../Screens/DetailsScreen.dart';

class CourseWidget extends StatelessWidget {
  Course course;

  String imageUrl;
  String nameCourse;
  String content;
  String stars;
  CourseWidget({required this.nameCourse,required this.content,required this.imageUrl,required this.course,required this.stars});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30.r),

            child: Stack(
              children: [
                Image.network(imageUrl,
                  fit: BoxFit.cover,width: 130.w,height: 110.h,),
                Column(
                  children: [
                    Container(

                      height: 26.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                          color: Colors_Ui.mainColor.withOpacity(.5),
                          borderRadius:
                          (context.locale.toString()=='ar')?    
                          BorderRadius.only(topRight: Radius.circular(30.r),bottomLeft: Radius.circular(30.r))
                              : BorderRadius.only(topLeft: Radius.circular(30.r),bottomRight: Radius.circular(30.r))
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        Text(stars,style: TextStyle(color: Colors.white,fontSize: 18.sp),),
                        Icon(Icons.star_rounded,color: Colors.white,size: 18.sp,)
                      ],),
                    ),
                  ],
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(nameCourse,style: TextStyle(fontSize: 20.sp,color: Colors_Ui.mainColor),),
              SizedBox(height: 4.h,),
              Container(
                height: 40.h,
                width: 200.w,
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
                child: Text(content,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors_Ui.main2Color),
                ),
              ),
              SizedBox(height: 8.h,),
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      AppRouter.NavigatorToWidget(Details_Screen(course));
                    },
                    child: Container(
                      height: 30.h,
                      width: 95.w,
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
                      child: Text('details'.tr(),style: TextStyle(fontSize: 15.sp,color: Colors.white),),
                    ),
                  ),
                  SizedBox(width: 10.w,),
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
                      height: 30.h,
                      width: 95.w,
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
                      child: Text('register'.tr(),style: TextStyle(fontSize: 15.sp,color: Colors.white),),
                    ),
                  ),
                ],
              )
            ],)
        ],
      ),
    );
  }
}
