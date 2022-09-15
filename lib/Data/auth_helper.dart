
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dawratok/Modle/UserApp.dart';
import 'package:dawratok/Views/Widget/Dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../AppRouter.dart';
import '../Views/Screens/HomeScreen.dart';
import '../Views/Screens/SignInScreen.dart';
import 'Firestore_helper.dart';


class AuthHelper{
  AuthHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static AuthHelper authHelper = AuthHelper._();

  late AppUser appUser;

  Future<UserCredential?> signIn (String email,String password)async{
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showDialog(
            context: AppRouter.navKey.currentContext!,
            builder: (context){
              return DialogWidget(
                  content: 'EmailOrPasswordError'.tr()
                  , textButton: 'cancel'.tr());
            });

      }
    }
  }
  Future<UserCredential?> signUp(String email,String password)async{
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      AppRouter.popFromWidget();
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showDialog(
            context: AppRouter.navKey.currentContext!,
            builder: (context){
              return DialogWidget(
                  content: 'account already exists'.tr()
                  , textButton: 'cancel'.tr());
            });
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return null;

  }
  checkUser()async{
    User? user = firebaseAuth.currentUser;
    if(user==null){
      AppRouter.NavigatorToWidgetWithReplacement(SignIn_Screen());

    }
    else {
      AppRouter.NavigatorToWidgetWithReplacement(Home_Screen());
      StoreHelper.storeHelper.getUserFromFirestore(user.uid);
    }

  }
  signOut()async{
    firebaseAuth.signOut();
  }
  forgetPassword(String email)async{
    await firebaseAuth.sendPasswordResetEmail(email: email);

    // showDialog(
    //     context: AppRouter.navKey.currentContext!,
    //     builder: (context){
    //       return DialogWidget(
    //           content: 'checkEmail'.tr()
    //           , textButton: 'cancel'.tr());
    //     });
  }



}