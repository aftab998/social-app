import 'package:flutter/material.dart ';

import '../color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final Color color, textColor;
  final bool loading;
  const RoundButton({Key? key,
    required this.title,
    required this.onPress,
             this.textColor= AppColors.whiteColor,
             this.color=AppColors.primaryColor,
             this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:loading ? null : onPress,
      child: Container(
        height:50,
        width:double.infinity,
        decoration: BoxDecoration(
          color:AppColors.primaryButtonColor,
          borderRadius: BorderRadius.circular(50)
        ),
        child:loading ? Center(child: CircularProgressIndicator(color:Colors.white)) : Center(child: Text(title,style:Theme.of(context).textTheme.headline2!.copyWith(fontSize: 16,color:textColor))),
      ),
    );
  }
}
