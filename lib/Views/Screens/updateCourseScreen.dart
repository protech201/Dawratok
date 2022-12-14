import 'package:dawratok/Modle/Course.dart';
import 'package:dawratok/Views/Screens/HomeScreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../Provider/firestoreProvider.dart';
import '../Colors.dart';
import '../Widget/TextFieldAuth.dart';

class Update_Course_Screen extends StatelessWidget {
  // const Update_Course_Screen({Key? key}) : super(key: key);
  Course course;
  Update_Course_Screen(this.course);

  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreProvider>(
      builder: (context,provider,x) {
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
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: 360.w,
                  child: Form(
                    key: provider.CourseKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('updateCourse'.tr(),style: TextStyle(
                            fontSize: 25.h,
                            color:Colors_Ui.mainColor
                        )),
                        SizedBox(height: 10.h,),

                        SizedBox(height: 10.h,),
                        TextFieldAuthWidget(
                          hintText: 'اسم الدورة',
                          suffix: Icon(Icons.drive_file_rename_outline),
                          controller: provider.nameCourseController,
                          validator: provider.nullValidation,
                        ),
                        SizedBox(height: 10.h,),
                        TextFieldAuthWidget(
                          hintText: 'Course Name',
                          suffix: Icon(Icons.drive_file_rename_outline),
                          controller: provider.nameCourseEnController,
                          validator: provider.nullValidation,
                        ),
                        SizedBox(height: 10.h,),
                        TextFieldAuthWidget(
                          hintText: 'اسم المعلم',
                          suffix: Icon(Icons.perm_identity),
                          controller: provider.nameTeacherController,
                          validator: provider.nullValidation,
                        ),
                        SizedBox(height: 10.h,),
                        TextFieldAuthWidget(
                          hintText: 'Teacher Name',
                          suffix: Icon(Icons.perm_identity),
                          controller: provider.nameTeacherEnController,
                          validator: provider.nullValidation,
                        ),
                        SizedBox(height: 10.h,),
                        TextFieldAuthWidget(
                          hintText: 'العنوان',
                          suffix: Icon(Icons.location_on_outlined),
                          controller: provider.addressController,
                          validator: provider.nullValidation,
                        ),
                        SizedBox(height: 10.h,),
                        TextFieldAuthWidget(
                          hintText: 'Address',
                          suffix: Icon(Icons.location_on_outlined),
                          controller: provider.addressEnController,
                          validator: provider.nullValidation,
                        ),
                        SizedBox(height: 10.h,),
                        TextFieldAuthWidget(
                          hintText: 'التفاصيل',
                          controller: provider.contentController,
                          validator: provider.nullValidation,
                          maxLine: 3,
                        ),
                        SizedBox(height: 10.h,),
                        TextFieldAuthWidget(
                          hintText: 'Content',
                          controller: provider.contentEnController,
                          validator: provider.nullValidation,
                          maxLine: 3,
                        ),
                        SizedBox(height: 10.h,),
                        TextFieldAuthWidget(
                          textInputType: TextInputType.number,
                          hintText: 'Number of stars',
                          suffix: Icon(Icons.star_rounded),
                          controller: provider.starsController,
                          validator: provider.nullValidation,
                        ),
                        SizedBox(
                          width: 320.w,
                          child: Row(
                            children: [
                              Text('This course is Online?'.tr(),style: TextStyle(fontSize: 15.sp,color: Colors_Ui.mainColor),),
                              Checkbox(
                                activeColor: Colors_Ui.main2Color,
                                value: provider.isOnline,
                                onChanged: (value){
                                  provider.isOnlineFun(value!);
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        GestureDetector(
                          onTap: (){
                            provider.imagePickerProvider();

                          } ,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 150.h,
                              width: 360.w,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(7)),
                                color: Colors.grey,


                              ),
                              child: provider.selectedImage==null?
                              Image.network(course.imageUrl)
                                  :Image.file(provider.selectedImage!)
                              ,
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: (){
                            if(provider.CourseKey.currentState!.validate()) {
                              provider.updateCourse(course);
                              Navigator.of(context).pushReplacementNamed('home');
                            }
                          },
                          child: Container(
                            height: 35.h,
                            width: 250.w,
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
                        SizedBox(height: 10.h,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}

