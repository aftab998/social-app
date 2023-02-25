import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app_android/view_model/services/session_manager.dart';
import '../../res/fonts.dart';
import 'package:social_app_android/utils/routes/route_name.dart';





class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {




  islogin(){

    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;


    if(user!= null){
      SessionController().userid= user.uid.toString();
      Future.delayed(Duration(seconds:4),()=> Navigator.pushReplacementNamed(context, RouteName.dashboardScreen));

    }else{
      Future.delayed(Duration(seconds:4),()=> Navigator.pushReplacementNamed(context, RouteName.loginview));

    }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    islogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       //backgroundColor: whiteColor,
       body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Center(child: Text('SocialApp',style:TextStyle(fontSize: 28.0,color:Colors.black,fontFamily: AppFonts.sfProDisplayBold,fontWeight: FontWeight.bold),))
            ]
        ),
    );
  }
}
