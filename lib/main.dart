import 'package:dawratok/AppRouter.dart';
import 'package:dawratok/Provider/Chat_Provider.dart';
import 'package:dawratok/Views/Screens/HomeScreen.dart';
import 'package:dawratok/Views/Screens/SignUpScreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'Provider/authProvider.dart';
import 'Provider/firestoreProvider.dart';
import 'Views/Screens/splashScreen.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp( EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/langs', // <-- change the path of the translation files
      fallbackLocale: Locale('en'),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
   const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) {
            return AuthProvider();
          },),
        ChangeNotifierProvider<FirestoreProvider>(
          create: (context) {
            return FirestoreProvider();
          },),
        ChangeNotifierProvider<ChatProvider>(
          create: (context) {
            return ChatProvider();
          },),

      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 640),
          minTextAdapt: true,
          splitScreenMode: true,
        builder: (context,child) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            navigatorKey: AppRouter.navKey,
            debugShowCheckedModeBanner: false,
            home: Splash_Screen(),

            theme: ThemeData(
              fontFamily: 'arabic',
            ),
            routes: <String, WidgetBuilder> {
              'home': (BuildContext context) => new Home_Screen()
            },
          );
        }
      ),
    );
  }
}
