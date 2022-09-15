import 'package:dawratok/Provider/authProvider.dart';
import 'package:dawratok/Views/Screens/fotgetScreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../AppRouter.dart';
import '../../Provider/firestoreProvider.dart';
import '../Colors.dart';
import '../Widget/TextFieldAuth.dart';
import 'SignUpScreen.dart';

class SignIn_Screen extends StatelessWidget {
   SignIn_Screen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context,provider,x) {
          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: SizedBox(
                  width: 360.w,
                  child: Form(
                    key: provider.SignInKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Lottie.asset('assets/animation/login.json',height: 250.h),
                        Text('signIn'.tr(),style: TextStyle(
                            fontSize: 25.h,
                            color:Colors_Ui.mainColor
                        )),
                        SizedBox(height: 15.h,),
                        TextFieldAuthWidget(
                          hintText: 'email'.tr(),
                          suffix: Icon(Icons.alternate_email_rounded),
                          controller: provider.emailSignInController,
                          validator: provider.emailValidation,
                        ),
                        SizedBox(height: 10.h,),
                        TextFieldAuthWidget(
                          isPassword: true,
                          hintText: 'password'.tr(),
                          suffix: Icon(Icons.password),
                          controller: provider.passwordSignInController,
                          validator: provider.nullValidation,
                        ),
                        SizedBox(height: 10.h,),
                        SizedBox(
                          width: 300.w,
                            child: GestureDetector(
                              onTap: (){
                                AppRouter.NavigatorToWidget(Forget_Screen());
                              },
                              child: Text('forget'.tr(),style: TextStyle(fontSize: 15.sp,color: Colors_Ui.mainColor),))),
                        SizedBox(height: 15.h,),
                        InkWell(
                          onTap: (){
                            if(provider.SignInKey!.currentState!.validate())
                            provider.signIn();
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
                            child: Text('signIn'.tr(),style: TextStyle(fontSize: 25.sp,color: Colors.white),),
                          ),
                        ),
                        Divider(
                          color: Colors_Ui.mainColor,

                          height: 30.h,
                          thickness: 1,
                          indent: 20,
                          endIndent: 20,
                        ),

                        InkWell(
                          onTap: (){
                            AppRouter.NavigatorToWidget(SignUp_Screen());
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
                            child: Text('create'.tr(),style: TextStyle(fontSize: 25.sp,color: Colors.white),),
                          ),
                        ),

                        IconButton(onPressed: (){
                          if(context.locale.toString()=='ar')
                            context.setLocale(Locale('en'));
                          else
                            context.setLocale(Locale('ar'));
                        },
                          icon: Icon(Icons.language,color: Colors_Ui.mainColor,),)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
