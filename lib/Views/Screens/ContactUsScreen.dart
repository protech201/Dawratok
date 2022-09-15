import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Colors.dart';

class ContactUs_screen extends StatelessWidget {
  const ContactUs_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('contactUs'.tr()),
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
      body: Stack(
        children: [
          SvgPicture.asset('assets/images/Scroll Group 1.svg',width: 360.w,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 120.h,),
                ListTileWidget(title: 'الموقع',
                  subTitle: 'Palestine - Gaza - Tal Alhawa',
                  icon: Icon(Icons.my_location_rounded,color: Colors_Ui.mainColor,size: 30.sp,),),
                SizedBox(height: 10.h,),
                ListTileWidget(title: 'رقم الجوال',
                  subTitle: '00972594301380',
                  icon: Icon(Icons.phone_enabled_rounded,color: Colors_Ui.mainColor,size: 30.sp,),),
                SizedBox(height: 10.h,),
                ListTileWidget(title: 'الإيميل',
                  subTitle: 'abd3gh@gmail.com',
                  icon: Icon(Icons.alternate_email_rounded,color: Colors_Ui.mainColor,size: 30.sp,),),
              ],
            ),
          )
        ],
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

