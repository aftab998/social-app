import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:social_app_android/res/color.dart';
import 'package:social_app_android/utils/utils.dart';
import 'package:social_app_android/view_model/services/session_manager.dart';


class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key,
    required this.name,
    required this.image,
    required this.email,
    required this.reciverId
  }) : super(key: key);

  final String image,name,email, reciverId;


  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final DatabaseReference ref = FirebaseDatabase.instance.ref().child('chat');
  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name.toString()),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index){
                  return Text(index.toString());
                })),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom:8),
                        child: TextFormField(
                          controller: messageController,
                          cursorColor: AppColors.primaryTextTextColor,
                          style:Theme.of(context).textTheme.bodyText2!.copyWith(height:0,fontSize: 19),
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: (){
                                sendMessage();
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: CircleAvatar(
                                  backgroundColor: AppColors.primaryIconColor,
                                  child: Icon(Icons.send,color: Colors.white,),
                                ),
                              ),
                            ),
                            hintText: 'Enter Message',
                            enabled: true,
                            contentPadding: const EdgeInsets.all(20),
                            hintStyle:Theme.of(context).textTheme.bodyText2!.copyWith(height:0,color:AppColors.primaryTextTextColor.withOpacity(0.8),),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.textFieldDefaultFocus,),
                              borderRadius:BorderRadius.all(Radius.circular(50)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.secondaryColor,),
                                borderRadius:BorderRadius.all(Radius.circular(50))
                            ),
                            errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.alertColor,),
                                borderRadius:BorderRadius.all(Radius.circular(50))
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.textFieldDefaultBorderColor,),
                                borderRadius:BorderRadius.all(Radius.circular(50))
                            ),
                          ),
                        ),
                      ),
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
  sendMessage(){
    if(messageController.text.isEmpty){
      Utils.toastMessage('Enter Message');
    }else{
     final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
      ref.child(timeStamp).set({
        'isSeen' : false,
        'message' :messageController.text.toString(),
        'sender' : SessionController().userid.toString(),
        'reciver' : widget.reciverId,
        'type' : 'text',
        'time' : timeStamp.toString()
      }).then((value){
        messageController.clear();
      });

    }
  }

}
