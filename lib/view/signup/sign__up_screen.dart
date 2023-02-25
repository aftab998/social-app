import 'package:flutter/material.dart';
import '../../res/components/input_text_field.dart';
import '../../res/components/round_button.dart';
import '../../utils/routes/route_name.dart';
import '../../utils/utils.dart';
import 'package:provider/provider.dart';

import '../../view_model/signup/signup_controller.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {



  final _formKey = GlobalKey<FormState>();

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final userNameFocusNode = FocusNode();
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
      appBar:AppBar(
        automaticallyImplyLeading: false,

        elevation:0,
      ),
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:20,vertical:10),
          child: ChangeNotifierProvider(
            create: (_)=> SignUpController(),
            child: Consumer<SignUpController>(
              builder:(context, provider, child){
                return SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[
                        SizedBox(height:height*  .01,),
                        Text("Welcome to App", style: Theme.of(context).textTheme.headline3,),
                        SizedBox(height:height*  .01,),

                        Text("Enter your email address\nto register to your account",
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
                                    myController: userNameController,
                                    focusNode: userNameFocusNode,
                                    onFiledSubmittedValue: (value){},
                                    onValidator: (value){
                                      return value.isEmpty ? "enter username" : null;
                                    },
                                    keyBoardType: TextInputType.text,
                                    obsureText: false,
                                    hint: "Username",
                                  ),
                                  SizedBox(height:height * 0.01),
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
                                    onFiledSubmittedValue: (value){
                                      Utils.fieldFocus(context, emailFocusNode, passwordFocusNode);
                                    },
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


                        const SizedBox(height:40),
                        RoundButton(
                          title:'Sign Up',
                          loading: provider.loading,
                          onPress:(){
                            if(_formKey.currentState!.validate()){
                              provider.signup(context,userNameController.text, emailController.text, passwordController.text);
                            }

                          },
                        ),
                        SizedBox(height:height*  .03,),

                        InkWell(
                          onTap:(){
                            Navigator.pushNamed(context, RouteName.loginview);
                          },
                          child: Text.rich(
                              TextSpan(
                                  text:"Already have an account? ",
                                  style:Theme.of(context).textTheme.subtitle1!.copyWith(fontSize:15),

                                  children:[
                                    TextSpan(
                                      text:'Login',
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
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}
