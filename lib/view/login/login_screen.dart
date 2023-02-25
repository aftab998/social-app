import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../res/components/input_text_field.dart';
import '../../res/components/round_button.dart';
import '../../utils/routes/route_name.dart';
import '../../view_model/login/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height *1;
    return Scaffold(

      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:20,vertical:10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                SizedBox(height:height*  .01,),
               Text("Welcome to App", style: Theme.of(context).textTheme.headline3,),
                SizedBox(height:height*  .01,),

                Text("Enter your email address\nto connect to your account",
                textAlign:TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,),
                SizedBox(height:height*  .01,),

                Form(
                  key: _formKey,
                    child: Padding(
                      padding:  EdgeInsets.only(top:height * .06,bottom:height * 0.01),
                      child: Column(
                        children: [
                          InputTextField(
                            myController: emailController,
                            focusNode: emailFocusNode,
                            onFiledSubmittedValue: (value){},
                            onValidator: (value){
                              return value.isEmpty ? "enter email" : null;
                            },
                            keyBoardType: TextInputType.emailAddress,
                            obsureText: false,
                            hint: "Email",
                          ),
                          SizedBox(height:height * 0.01),
                          InputTextField(
                            myController: passwordController,
                            focusNode: passwordFocusNode,
                            onFiledSubmittedValue: (value){},
                            onValidator: (value){
                              return value.isEmpty ? "enter password" : null;
                            },
                            keyBoardType: TextInputType.emailAddress,
                            obsureText: true,
                            hint: "password",
                          ),
                        ],
                      ),
                    )),

                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(

                    onTap:(){
                      Navigator.pushNamed(context, RouteName.forgotScreen);
                    },
                    child: Text(
                      'Forgot Password',
                      style:Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize:15,
                          decoration:TextDecoration.underline),
                    ),
                  ),
                ),
                const SizedBox(height:40),
                ChangeNotifierProvider(
                    create:(_)=> LoginController(),
                  child: Consumer<LoginController>(
                    builder: (context, provider, child){
                      return RoundButton(
                        title:'Login',
                        loading: provider.loading,
                        onPress:(){
                          if(_formKey.currentState!.validate()){
                            provider.login(context, emailController.text, passwordController.text.toString());
                          }
                        },
                      );
                    },
                  ),

                ),
                SizedBox(height:height*  .03,),

                InkWell(
                  onTap:(){
                    Navigator.pushNamed(context, RouteName.signUpScreen);
                  },
                  child: Text.rich(
                    TextSpan(
                      text:"Don't have an account? ",
                        style:Theme.of(context).textTheme.subtitle1!.copyWith(fontSize:15),

                        children:[
                            TextSpan(
                        text:'Sign Up',
                      style:Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize:15,
                      decoration:TextDecoration.underline),
                    )
                        ]
                    )
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
