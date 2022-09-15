import 'package:dawratok/Views/Screens/SignUpScreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

import '../AppRouter.dart';
import '../Data/Firestore_helper.dart';
import '../Data/auth_helper.dart';
import '../Modle/UserApp.dart';
import '../Views/Screens/HomeScreen.dart';
import '../Views/Screens/SignInScreen.dart';
import '../Views/Screens/doneSignIn.dart';
import 'firestoreProvider.dart';

class AuthProvider extends ChangeNotifier{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController emailSignInController = TextEditingController();
  TextEditingController passwordSignInController = TextEditingController();

  TextEditingController forgetPasswordController = TextEditingController();

  GlobalKey<FormState> SignUpKey = GlobalKey();
  GlobalKey<FormState>? SignInKey = GlobalKey();
  GlobalKey<FormState> ForgetKey = GlobalKey();

   AppUser? appUser;

  nullValidation(String v){
    if(v.isEmpty) {
      return 'required'.tr();
    }}
  emailValidation(String v){
     if(v.isEmpty) {
      return 'required'.tr();
    }
     else if(!isEmail(v)) {
    return 'emailRequired'.tr();
    }
  }
  passwordValidation(String v){
    if(v.length < 6) {
      return 'passwordRequired'.tr();
    }}
  signIn()async{
    UserCredential? userCredential =    await AuthHelper.authHelper.signIn(emailSignInController.text, passwordSignInController.text);
     appUser = await StoreHelper.storeHelper.getUserFromFirestore(userCredential!.user!.uid);
     appUser!.id = userCredential.user!.uid;
    if(userCredential != null){
      SignInKey = null;
      AppRouter.NavigatorToWidgetWithReplacement(DoneSignIn_Screen());
      emailSignInController.clear();
      passwordSignInController.clear();

    }

  }

  register()async{
    UserCredential? userCredential = await AuthHelper.authHelper.signUp(emailController.text, passwordController.text);
    AppUser appUser = AppUser(
        userName: userNameController.text,
        email: emailController.text,
        phone: phoneController.text,
        id: userCredential!.user!.uid,
        isTeacher: false
    );
    await StoreHelper.storeHelper.addUserToFirestore(appUser);
  }

  checkUser()async{
    User? user = AuthHelper.authHelper.firebaseAuth.currentUser;
    if(user == null){
      AppRouter.NavigatorToWidgetWithReplacement(SignIn_Screen());

    }
    else{
      appUser = await StoreHelper.storeHelper.getUserFromFirestore(user.uid);
      appUser!.id = user.uid;
      AppRouter.NavigatorToWidgetWithReplacement(Home_Screen());

    }
  }

  signOut()async{
    AuthHelper.authHelper.signOut();
    SignInKey = GlobalKey();
    AppRouter.NavigatorToWidgetWithReplacement(SignIn_Screen());

  }

  forGetPassword()async{
    AuthHelper.authHelper.forgetPassword(forgetPasswordController.text);
    forgetPasswordController.clear();
  }



  // getAllData()async{
  //   StoreHelper.storeHelper.getAllData();
  // }




}