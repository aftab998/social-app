import 'package:flutter/material.dart';
import 'package:social_app_android/utils/routes/route_name.dart';
import 'package:social_app_android/view/forgot_password/forgot_password.dart';

import '../../view/login/login_screen.dart';
import '../../view/signup/sign__up_screen.dart';
import '../../view/splash/splash_screen.dart';
import '../../view/dashboard//dashboard_screen.dart';



class Routes {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const splashScreen());
      case RouteName.loginview:
        return MaterialPageRoute(builder: (_)=> const LoginScreen() );
      case RouteName.signUpScreen:
        return MaterialPageRoute(builder: (_)=> const SignUpScreen() );
      case RouteName.dashboardScreen:
        return MaterialPageRoute(builder: (_)=> const DashboardScreen() );
      case RouteName.forgotScreen:
        return MaterialPageRoute(builder: (_)=> const ForgotPasswordScreen() );


      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}