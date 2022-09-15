import 'package:dawratok/Views/Screens/HomeScreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import '../../AppRouter.dart';
import '../../Provider/firestoreProvider.dart';
import '../Colors.dart';
import '../Widget/TextFieldAuth.dart';
class AddCourse_Screen extends StatelessWidget {
  const AddCourse_Screen({Key? key}) : super(key: key);
  clearTextField(){
    Provider.of<FirestoreProvider>(AppRouter.navKey.currentContext!,listen: false).nameCourseController.clear();
    Provider.of<FirestoreProvider>(AppRouter.navKey.currentContext!,listen: false).nameCourseEnController.clear();
    Provider.of<FirestoreProvider>(AppRouter.navKey.currentContext!,listen: false).nameTeacherController.clear();
    Provider.of<FirestoreProvider>(AppRouter.navKey.currentContext!,listen: false).nameTeacherEnController.clear();
    Provider.of<FirestoreProvider>(AppRouter.navKey.currentContext!,listen: false).addressController.clear();
    Provider.of<FirestoreProvider>(AppRouter.navKey.currentContext!,listen: false).addressEnController.clear();
    Provider.of<FirestoreProvider>(AppRouter.navKey.currentContext!,listen: false).contentController.clear();
    Provider.of<FirestoreProvider>(AppRouter.navKey.currentContext!,listen: false).contentEnController.clear();
    Provider.of<FirestoreProvider>(AppRouter.navKey.currentContext!,listen: false).starsController.clear();
    Provider.of<FirestoreProvider>(AppRouter.navKey.currentContext!,listen: false).isOnline=false;
    Provider.of<FirestoreProvider>(AppRouter.navKey.currentContext!,listen: false).selectedImage=null;
  }

  @override
  Widget build(BuildContext context) {
    clearTextField();
    return Consumer<FirestoreProvider>(
        builder: (context,provider,x) {
          return Scaffold(
            appBar: AppBar(
              title: Text('addCourse'.tr()),
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
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: SizedBox(
                    width: 360.w,
                    child: Form(
                      key: provider.CourseKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('addCourse'.tr(),style: TextStyle(
                              fontSize: 25.h,
                              color:Colors_Ui.mainColor
                          )),
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
                                Icon(Icons.add_a_photo_outlined,size: 25.sp,)
                                    :Image.file(provider.selectedImage!)
                                ,
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: (){
                              if(provider.CourseKey.currentState!.validate()) {
                                provider.addNewCourse();
                                AppRouter.NavigatorToWidgetWithReplacement(Home_Screen());
                                // clearTextField();
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
                              child: Text('addCourse'.tr(),style: TextStyle(fontSize: 25.sp,color: Colors.white),),
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



