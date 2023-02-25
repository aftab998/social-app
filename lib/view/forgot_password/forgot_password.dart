import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../res/components/input_text_field.dart';
import '../../res/components/round_button.dart';
import '../../utils/routes/route_name.dart';
import '../../view_model/forgot_password/forgot_password_controller.dart';
import '../../view_model/login/login_controller.dart';



class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {


  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    emailFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height *1;
    return Scaffold(
      appBar:AppBar(
        elevation:0,
      ),
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:20,vertical:10),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  SizedBox(height:height*  .01,),
                  Text("Forgot Password", style: Theme.of(context).textTheme.headline3,),
                  SizedBox(height:height*  .01,),

                  Text("Enter your email address\nto recover your password",
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
                          ],
                        ),
                      )),

                  const SizedBox(height:40),
                  ChangeNotifierProvider(
                    create:(_)=> ForgotPasswordController(),
                    child: Consumer<ForgotPasswordController>(
                      builder: (context, provider, child){
                        return RoundButton(
                          title:'Recover',
                          loading: provider.loading,
                          onPress:(){
                            if(_formKey.currentState!.validate()){
                             provider.forgotPassword(context, emailController.text);
                            }
                          },
                        );
                      },
                    ),

                  ),
                  SizedBox(height:height*  .03,),
                ]
            ),
          ),
        ),
      ),
    );
  }
}
