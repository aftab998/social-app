import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:social_app_android/res/color.dart';
import 'package:social_app_android/view_model/services/session_manager.dart';

import '../chat/messageScreen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FirebaseAnimatedList(
          query: ref,
          itemBuilder: (context, snapshot, animation, index){
            if(SessionController().userid.toString() == snapshot.child('uid').value.toString()){
              return Container();
            }else{
              return Card(
                child: ListTile(
                  onTap: (){
                    PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: MessageScreen(
                          name: snapshot.child('username').value.toString(),
                          image: snapshot.child('profile').value.toString(),
                          email: snapshot.child('email').value.toString(),
                          reciverId: snapshot.child('uid').value.toString(),
                        ),
                      withNavBar: false
                    );
                  },
                  leading: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primaryButtonColor)
                    ),
                    child:snapshot.child('profile').value.toString() == "" ? Icon(Icons.person_outline) :
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image( fit:BoxFit.cover,image: NetworkImage(snapshot.child('profile').value.toString(), ),
                      ),
                    ),
                  ),
                  title:  Text(snapshot.child('username').value.toString()),
                  subtitle: Text(snapshot.child('email').value.toString()),
                ),
              );

            }
          },
        ),
      ),
    );
  }
}
