import 'package:dawratok/AppRouter.dart';
import 'package:dawratok/Provider/authProvider.dart';
import 'package:dawratok/Provider/firestoreProvider.dart';
import 'package:dawratok/Views/Colors.dart';
import 'package:dawratok/Views/Screens/ChatApp/Users_Chat.dart';
import 'package:dawratok/Views/Screens/DetailsScreen.dart';
import 'package:dawratok/Views/Widget/itemDrawer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fading_images_slider/fading_images_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../Widget/CourseWidget.dart';
import 'AllCoursesScreen.dart';
import 'ContactUsScreen.dart';
import 'ControlScreen.dart';


class Home_Screen extends StatelessWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreProvider>(
      builder: (context,provider,x) {
        return Scaffold(
          appBar: AppBar(
            title: Text('home'.tr()),
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
          drawer: Drawer(
            backgroundColor: Colors_Ui.mainColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50.h,),
                  // SvgPicture.asset('assets/images/Layer_5_59_.svg',height: 80.h,),
                  // Text('دوراتك',style: TextStyle(fontSize: 32.sp,color: Colors.white),),

                  UserAccountsDrawerHeader(
                      accountName: Text(Provider.of<AuthProvider>(context).appUser!.userName),
                      currentAccountPicture: CircleAvatar(backgroundColor: Colors_Ui.main2Color,child: Text('A',style: TextStyle(color: Colors.white),),),
                      accountEmail: Text(Provider.of<AuthProvider>(context).appUser!.email),
                      decoration: BoxDecoration(
                        color: Colors_Ui.mainColor,
                      ),
                  ),
                  const Spacer(),
                  // ItemDrawer(
                  //   title: 'home'.tr(),
                  //   imagePath: 'assets/images/House_1_.svg',
                  //   // widget: Control_Screen(),
                  // ),
                  // ItemDrawer(
                  //   title: 'notifications'.tr(),
                  //   imagePath: 'assets/images/notfictoin.svg',
                  //   // widget: Control_Screen(),
                  // ),
                  ItemDrawer(
                    title: 'contactUs'.tr(),
                    imagePath: 'assets/images/phone-2.svg',
                    function:(){
                      AppRouter.NavigatorToWidget(ContactUs_screen());
                    },
                  ),
                  ItemDrawer(
                    title: 'about'.tr(),
                    imagePath: 'assets/images/about.svg',
                    // widget: Control_Screen(),
                  ),

                  Provider.of<AuthProvider>(context).appUser!.isTeacher!?
                  ItemDrawer(
                    title: 'controlBoard'.tr(),
                    imagePath: 'assets/images/about.svg',
                    // widget: Control_Screen(),
                    function: (){
                      AppRouter.NavigatorToWidget(Control_Screen());
                    },
                  )
                  :SizedBox(),
                  ItemDrawer(
                    title: 'Messenger',
                    imagePath: 'assets/images/about.svg',
                    // widget: Control_Screen(),
                    function: (){
                      AppRouter.NavigatorToWidget(ChatUsersScreen());
                    },
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: (){
                      Provider.of<AuthProvider>(context,listen: false).signOut();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.exit_to_app_rounded,size: 30.sp,color: Colors.white),
                        SizedBox(width: 5.h,),
                        Text('signOut'.tr(),style: TextStyle(fontSize: 25.sp,color: Colors.white),)
                      ],
                    ),
                  ),



                  // ItemDrawer(
                  //   title: 'SginOut'.tr(),
                  //   imagePath: 'assets/images/about.svg',
                  //   // widget: Control_Screen(),
                  //   function: (){
                  //     Provider.of<AuthProvider>(context,listen: false).signOut();
                  //   },
                  // ),
                  SizedBox(height: 30.h,)
                ],
              ),
            ),
          ),
          body: provider.Courses.isEmpty?
              Center(child: CircularProgressIndicator(),)
          :provider.Courses.length<3?
          Center(child: Column(
            children: [
              SizedBox(height: 50.h,),
            Lottie.asset('assets/animation/courses.json'),
            const Spacer(),
            InkWell(
                onTap: ()=>AppRouter.NavigatorToWidget(AllCoursesScreen()),
                child: Text('courses'.tr(),style: TextStyle(fontSize: 25.sp,color: Colors.grey),)),
              const Spacer(),
          ],),)
          :Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('courses'.tr(),style: TextStyle(fontSize: 25.sp,color: Colors_Ui.mainColor),),
                    InkWell(
                      onTap: ()=>AppRouter.NavigatorToWidget(AllCoursesScreen()),
                        child: Text('allCourses'.tr(),style: TextStyle(fontSize: 18.sp,color: Colors.grey),)),
                  ],
                ),
              ),
              CourseWidget(
                nameCourse: context.locale.toString()=='ar'?
                provider.Courses.first.nameCourse
                :provider.Courses.first.nameCourseEn,
                content: context.locale.toString()=='ar'?
                provider.Courses.first.content
                :provider.Courses.first.contentEn,
                imageUrl: provider.Courses.first.imageUrl,
                course: provider.Courses.first,
                stars: provider.Courses.first.stars,
              ),
              CourseWidget(
                nameCourse: context.locale.toString()=='ar'?
                provider.Courses[1].nameCourse
                    :provider.Courses[1].nameCourseEn,
                content: context.locale.toString()=='ar'?
                provider.Courses[1].content
                    :provider.Courses[1].contentEn,
                imageUrl: provider.Courses[1].imageUrl,
                course: provider.Courses[1],
                stars: provider.Courses[1].stars,
              ),
              CourseWidget(
                nameCourse: context.locale.toString()=='ar'?
                provider.Courses[2].nameCourse
                    :provider.Courses[2].nameCourseEn,
                content: context.locale.toString()=='ar'?
                provider.Courses[2].content
                    :provider.Courses[2].contentEn,
                imageUrl: provider.Courses[2].imageUrl,
                course: provider.Courses[2],
                stars: provider.Courses[2].stars,
              ),
              // SizedBox(height: 10.h,),
          Expanded(
          child: ImageSlideshow(
            width: double.infinity,
            initialPage: 0,
            indicatorColor: Colors_Ui.mainColor,
            indicatorBackgroundColor: Colors_Ui.main2Color,
            children: [
              Image.network(provider.Courses[0].imageUrl,width: 360.w,height: 140.h,fit:BoxFit.fill,),
              Image.network(provider.Courses[1].imageUrl,width: 360.w,height: 140.h,fit:BoxFit.fill,),
              Image.network(provider.Courses[2].imageUrl,width: 360.w,height: 140.h,fit:BoxFit.fill,),
            ],
            onPageChanged: (value) {
              // AppRouter.NavigatorToWidget(Details_Screen(provider.Courses[value]));
            },

            autoPlayInterval: 4000,

            /// Loops back to first slide.
            isLoop: true,
          ),
          ),


              // SizedBox(
              //   width: 360.w,
              //   height: 140.h,
              //   child: FadingImagesSlider(
              //     textAlignment: Alignment.center,
              //     images:  [
              //     Image.network(provider.Courses.first.imageUrl,width: 360.w,height: 140.h,fit:BoxFit.fill,),
              //     Image.network(provider.Courses[1].imageUrl,width: 360.w,height: 140.h,fit:BoxFit.fill,),
              //     Image.network(provider.Courses[2].imageUrl,width: 360.w,height: 140.h,fit:BoxFit.fill,),
              //   ],
              //     texts: const [
              //       Text(' '),
              //       Text(' '),
              //       Text(' '),
              //     ],
              //
              //   ),
              // )



            ],
          ),
        );
      }
    );
  }
}
