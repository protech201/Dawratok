import 'package:dawratok/Provider/authProvider.dart';
import 'package:dawratok/Views/Widget/TextFieldAuth.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../AppRouter.dart';
import '../Colors.dart';
import 'SignInScreen.dart';

class Forget_Screen extends StatelessWidget {
  const Forget_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('forgetPassword'.tr()),
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
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          child: SizedBox(
            width: 360.w,
            child: Column(
              children: [
                SizedBox(height: 30.h,),
                Lottie.asset('assets/animation/forgetPassword.json',width: 300.w),
                SizedBox(height: 50.h,),
                Form(
                  key: Provider.of<AuthProvider>(context).ForgetKey,
                  child: TextFieldAuthWidget(
                      hintText: 'email'.tr(),
                      controller: Provider.of<AuthProvider>(context).forgetPasswordController,
                      suffix: Icon(Icons.alternate_email_rounded),
                    validator: Provider.of<AuthProvider>(context).nullValidation,
                  ),
                ),
                SizedBox(height: 10.h,),
                InkWell(
                  onTap: (){
                    if(Provider.of<AuthProvider>(context,listen: false).ForgetKey.currentState!.validate()){
                    Provider.of<AuthProvider>(context,listen: false).forGetPassword();
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
                                Lottie.asset('assets/animation/forgetDoalog.json',width: 150.w),
                                Text('checkEmail'.tr()),
                                FlatButton(
                                  color: Colors.red,
                                  textColor: Colors.white,
                                  child: Text('cancel'.tr(),style: TextStyle(fontSize: 15.sp),),
                                  onPressed: () {
                                    AppRouter.NavigatorToWidgetWithReplacement(SignIn_Screen());
                                  },
                                ),
                              ],
                            ),
                          );
                        });}

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
                    child: Text('getPassword'.tr(),style: TextStyle(fontSize: 20.sp,color: Colors.white),),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
