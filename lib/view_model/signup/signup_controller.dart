import 'package:flutter/material.dart';
import 'package:social_app_android/utils/routes/route_name.dart';
import '../../utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';

import '../services/session_manager.dart';


class SignUpController with ChangeNotifier{

  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');

  bool _loading = false;
  bool get loading => _loading;


  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }
  void signup(BuildContext context,String username,String  email, String password) async{
    setLoading(true);
    try {
       auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      ).then((value) {
         SessionController().userid = value.user!.uid.toString();
         ref.child(value.user!.uid.toString()).set({
          'uid': value.user!.uid.toString(),
          'email': value.user!.email.toString(),
          'onlineStatus': 'noOne',
          'phone': '',
          'username': username,
          'profile': '',

        }).then((value){
          setLoading(false);
          Navigator.pushNamed(context, RouteName.dashboardScreen);
        }).onError((error, stackTrace) {
          setLoading(false);
          Utils.toastMessage(error.toString());
        });
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.toastMessage(error.toString());

      });
    }
    catch(e){
      setLoading(false);
      Utils.toastMessage(e.toString());
    }
    }

  }


