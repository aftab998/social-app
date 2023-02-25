import 'package:flutter/material.dart';
import '../../res/color.dart';


class InputTextField extends StatelessWidget {
  const InputTextField({
    Key? key,
    required this.myController,
    required this.focusNode,
    required this.onFiledSubmittedValue,
    required this.onValidator,
    required this.keyBoardType,
    required this.obsureText,
    required this.hint,
     this.autoFocus=false,
     this.enable = true,

  }) : super(key: key);
  final TextEditingController myController;
  final FocusNode focusNode;
  final FormFieldSetter onFiledSubmittedValue;
  final FormFieldValidator onValidator;

  final TextInputType keyBoardType;
  final String hint;
  final bool obsureText;
  final bool enable,autoFocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:8),
      child: TextFormField(
          controller: myController,
          focusNode: focusNode,
          onFieldSubmitted: onFiledSubmittedValue ,
          validator: onValidator,
          keyboardType: keyBoardType,
        obscureText: obsureText,
        cursorColor: AppColors.primaryTextTextColor,
        style:Theme.of(context).textTheme.bodyText2!.copyWith(height:0,fontSize: 19),
        decoration: InputDecoration(
          hintText:hint,
          enabled: enable,
          contentPadding: const EdgeInsets.all(20),
          hintStyle:Theme.of(context).textTheme.bodyText2!.copyWith(height:0,color:AppColors.primaryTextTextColor.withOpacity(0.8),),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textFieldDefaultFocus,),
            borderRadius:BorderRadius.all(Radius.circular(8)),
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondaryColor,),
              borderRadius:BorderRadius.all(Radius.circular(8))
        ),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.alertColor,),
              borderRadius:BorderRadius.all(Radius.circular(8))
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.textFieldDefaultBorderColor,),
              borderRadius:BorderRadius.all(Radius.circular(8))
          ),
        ),
      ),
    );
  }
}
