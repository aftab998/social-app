import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_app_android/res/color.dart';
import 'package:social_app_android/res/fonts.dart';
import 'package:social_app_android/utils/routes/route_name.dart';
import 'package:social_app_android/utils/routes/routes.dart';



void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch:AppColors.primaryMaterialColor,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: AppColors.whiteColor,
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 22,fontFamily: AppFonts.sfProDisplayMedium,color:AppColors.primaryTextTextColor),
        ),
        textTheme:const TextTheme(
          headline1: TextStyle(fontSize: 40,fontFamily: AppFonts.sfProDisplayMedium,color:AppColors.primaryTextTextColor,fontWeight: FontWeight.w500,height:1.6),
          headline2: TextStyle(fontSize: 32,fontFamily: AppFonts.sfProDisplayMedium,color:AppColors.primaryTextTextColor,fontWeight: FontWeight.w500,height:1.6),
          headline3: TextStyle(fontSize: 28,fontFamily: AppFonts.sfProDisplayMedium,color:AppColors.primaryTextTextColor,fontWeight: FontWeight.w500,height:1.9),
          headline4: TextStyle(fontSize: 24,fontFamily: AppFonts.sfProDisplayMedium,color:AppColors.primaryTextTextColor,fontWeight: FontWeight.w500,height:1.6),
          headline5: TextStyle(fontSize: 20,fontFamily: AppFonts.sfProDisplayMedium,color:AppColors.primaryTextTextColor,fontWeight: FontWeight.w500,height:1.6),
          headline6: TextStyle(fontSize: 17,fontFamily: AppFonts.sfProDisplayBold,color:AppColors.primaryTextTextColor,fontWeight: FontWeight.w500,height:1.6),



          bodyText1: TextStyle(fontSize: 17,fontFamily: AppFonts.sfProDisplayBold,color:AppColors.primaryTextTextColor,fontWeight: FontWeight.w700,height:1.6),
          bodyText2: TextStyle(fontSize: 14,fontFamily: AppFonts.sfProDisplayRegular,color:AppColors.primaryTextTextColor,height:1.6),

          caption: TextStyle(fontSize: 12,fontFamily: AppFonts.sfProDisplayBold,color:AppColors.primaryTextTextColor,height:2.26),




        )
      ),
      initialRoute: RouteName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
