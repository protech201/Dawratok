import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogWidget extends StatelessWidget {
  final String content;
  final String textButton;

  DialogWidget({required this.content,required this.textButton});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(content),
          FlatButton(
            color: Colors.red,
            textColor: Colors.white,
            child: Text(textButton,style: TextStyle(fontSize: 15.sp),),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
