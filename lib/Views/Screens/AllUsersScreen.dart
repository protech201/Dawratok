import 'package:dawratok/AppRouter.dart';
import 'package:dawratok/Provider/firestoreProvider.dart';
import 'package:dawratok/Views/Colors.dart';
import 'package:dawratok/Views/Screens/ProfileScreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
class AllUsres_Screen extends StatelessWidget {
  const AllUsres_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('users'.tr()),
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
          itemCount: Provider.of<FirestoreProvider>(context).Users.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(top: 10),
                height: 50.h,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25.r,
                      backgroundColor: Colors_Ui.mainColor,
                      child: Text(Provider.of<FirestoreProvider>(context).Users[index].userName.characters.first,
                      style: TextStyle(color: Colors.white,fontSize: 20.sp),),
                    ),
                    SizedBox(width: 10.w,),
                    Text(Provider.of<FirestoreProvider>(context).Users[index].userName,
                    style: TextStyle(fontSize: 20.sp),),
                    Spacer(),
                    IconButton(onPressed: (){
                      AppRouter.NavigatorToWidget(Profile_Screen(Provider.of<FirestoreProvider>(context,listen: false).Users[index]));

                    },
                        icon: Icon(Icons.chevron_right,size: 30.sp,))
                  ],
                ),
              );
            }),
      ));


  }
}
