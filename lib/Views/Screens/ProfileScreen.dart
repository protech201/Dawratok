import 'package:dawratok/Views/Colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Modle/UserApp.dart';

class Profile_Screen extends StatelessWidget {
  AppUser appUser;
  Profile_Screen(this.appUser);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('profile'.tr()),
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
        child: Stack(
          children: [
            Container(color: Colors_Ui.mainColor,width: 360.w,height: 150.h,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 105.h,),
                  Container(
                    width: 360.w,
                    alignment: Alignment.centerRight,
                    child: CircleAvatar(
                      radius: 50.r,
                      backgroundColor: Colors.white,
                      child: Text(appUser.userName.characters.first,
                        style: TextStyle(color: Colors_Ui.mainColor,fontSize: 60.sp),),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  ListTileWidget(title: 'userName'.tr(),
                    subTitle: appUser.userName,
                    icon: Icon(Icons.my_location_rounded,color: Colors_Ui.mainColor,size: 30.sp,),),
                  SizedBox(height: 10.h,),
                  ListTileWidget(title: 'phone'.tr(),
                    subTitle: appUser.phone,
                    icon: Icon(Icons.phone_enabled_rounded,color: Colors_Ui.mainColor,size: 30.sp,),),
                  SizedBox(height: 10.h,),
                  ListTileWidget(title: 'email'.tr(),
                    subTitle: appUser.email,
                    icon: Icon(Icons.alternate_email_rounded,color: Colors_Ui.mainColor,size: 30.sp,),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ListTileWidget extends StatelessWidget {
  // const ListTileWidget({Key? key}) : super(key: key);
  String title;
  String subTitle;
  Widget icon;
  ListTileWidget({required this.title,required this.subTitle,required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(3,3),
                blurRadius: 10
            )
          ]

      ),
      child: ListTile(
        minLeadingWidth: 10.w,
        leading: icon,
        title: Text(title),
        subtitle: Text(subTitle),
      ),
    );
  }
}
