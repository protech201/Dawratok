import 'package:dawratok/Provider/authProvider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../Colors.dart';
import '../Widget/TextFieldAuth.dart';

class SignUp_Screen extends StatelessWidget {
  TextEditingController controller = TextEditingController();
   SignUp_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context,provider,x) {
          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: 360.w,
                  child: Form(
                    key: provider.SignUpKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/images/pin-code.png',width: 150.w,),
                        Text('signUp'.tr(),style: TextStyle(
                            fontSize: 25.h,
                            color:Colors_Ui.mainColor
                        )),
                        SizedBox(height: 30.h,),

                        TextFieldAuthWidget(
                          hintText: 'userName'.tr(),
                          suffix: Icon(Icons.perm_identity),
                          controller: provider.userNameController,
                          validator: provider.nullValidation,
                        ),
                        SizedBox(height: 10.h,),
                        TextFieldAuthWidget(
                          hintText: 'email'.tr(),
                          suffix: Icon(Icons.email),
                          controller: provider.emailController,
                          validator: provider.emailValidation,
                        ),
                        SizedBox(height: 10.h,),
                        TextFieldAuthWidget(
                          hintText: 'password'.tr(),
                          suffix: Icon(Icons.password),
                          controller: provider.passwordController,
                          validator: provider.passwordValidation,
                        ),
                        SizedBox(height: 10.h,),
                        TextFieldAuthWidget(
                          hintText: 'phone'.tr(),
                          suffix: Icon(Icons.phone),
                          controller: provider.phoneController,
                          validator: provider.nullValidation,
                        ),
                        SizedBox(height: 10.h,),

                        SizedBox(height: 30.h,),
                        InkWell(
                          onTap: (){
                            if(provider.SignUpKey.currentState!.validate()) {
                              provider.register();
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
                            child: Text('create'.tr(),style: TextStyle(fontSize: 25.sp,color: Colors.white),),
                          ),
                        ),

                        IconButton(onPressed: (){
                          if(context.locale.toString()=='ar')
                            context.setLocale(Locale('en'));
                          else
                            context.setLocale(Locale('ar'));
                        },
                          icon: Icon(Icons.language),)

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
