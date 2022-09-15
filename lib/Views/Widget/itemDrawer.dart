import 'package:dawratok/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ItemDrawer extends StatelessWidget {
  final String title;
  final String? imagePath;
  Function? function;
  ItemDrawer({required this.title, this.imagePath, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: function as void Function()?,
      // onTap: ()=>AppRouter.NavigatorToWidget(widget),
      child: Row(
        children: [
          // SizedBox(width: 50.w,),
          SvgPicture.asset(imagePath!,height: 25.h,),
          SizedBox(width: 15.w,),
          Text(title,style: TextStyle(fontSize: 25.sp,color: Colors.white),),
        ],),
    );
  }
}
