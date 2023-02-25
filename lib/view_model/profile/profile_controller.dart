

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social_app_android/res/components/input_text_field.dart';
import 'package:social_app_android/utils/utils.dart';
import 'package:social_app_android/view_model/services/session_manager.dart';

import 'package:social_app_android/res/color.dart';

import '../../res/color.dart';
import '../../utils/routes/route_name.dart';
import '../../utils/routes/routes.dart';


class ProfileController with ChangeNotifier{

  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final nameFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();

  FirebaseAuth auth = FirebaseAuth.instance;

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;




  final picker = ImagePicker();
  XFile? _image ;
  XFile? get image => _image;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }


  Future pickGalleryImage(BuildContext context) async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if(pickedFile != null){
      _image= XFile(pickedFile.path);
      uploadImage(context);
      notifyListeners();
    }
  }

  Future pickCameraImage(BuildContext context) async{
    final pickedFile = await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if(pickedFile != null){
      _image= XFile(pickedFile.path);
      uploadImage(context);
      notifyListeners();
    }
  }
  
  void pickImage(context){
    showDialog(context: context,
        builder: (BuildContext context){
        return AlertDialog(
          content: Container(
            height: 120,
            child:Column(
              children: [
                ListTile(
                  onTap: (){
                    pickCameraImage(context);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.camera,color: AppColors.primaryIconColor,),
                  title: Text('Camera'),
                ),
                ListTile(
                  onTap: (){
                    pickGalleryImage(context);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.image, color: AppColors.primaryIconColor,),
                  title: Text('Gallery'),
                ),
              ],
            ) ,
          ),
        );
        }
        );
  }
  
  
  void uploadImage(BuildContext context)async{

    setLoading(true);
    firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance.ref('/profileImage'+SessionController().userid.toString());
    firebase_storage.UploadTask uploadTask = storageRef.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);
    final newUrl = await storageRef.getDownloadURL();

    ref.child(SessionController().userid.toString()).update({
      'profile' : newUrl.toString()
    }).then((value){
      Utils.toastMessage('profile updated');
      setLoading(false);
      _image = null;
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage(error.toString());
    });

  }




  Future<void> ShowUserNameDialogAlert(BuildContext context,String name){
    nameController.text = name;
    return showDialog(context: context,
        builder: (context){
      return AlertDialog(
        title: Center(child: Text('Update usernme')),
        content: SingleChildScrollView(
          child: Column(
            children: [
              InputTextField(
                  myController: nameController,
                  focusNode: nameFocusNode,
                  onFiledSubmittedValue: (value){},
                  onValidator: (value){},
                  keyBoardType: TextInputType.text,
                  obsureText: false,
                  hint: 'Enter name'
              )
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('Cancel',style: Theme.of(context).textTheme.subtitle2!.copyWith(color:AppColors.alertColor),)),
          TextButton(onPressed: (){
            Navigator.pop(context);
            ref.child(SessionController().userid.toString()).update({
            'username': nameController.text.toString()
          }).then((value){
            nameController.clear();
            });
          }, child: Text('Ok',style: Theme.of(context).textTheme.subtitle2))
        ],
      );
        }
    );
  }



  Future<void> ShowPhoneDialogAlert(BuildContext context,String phoneNumber){
    phoneController.text = phoneNumber;
    return showDialog(context: context,
        builder: (context){
      return AlertDialog(
        title: Center(child: Text('Update phone')),
        content: SingleChildScrollView(
          child: Column(
            children: [
              InputTextField(
                  myController: phoneController,
                  focusNode: phoneFocusNode,
                  onFiledSubmittedValue: (value){},
                  onValidator: (value){},
                  keyBoardType: TextInputType.phone,
                  obsureText: false,
                  hint: 'Enter phone'
              )
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('Cancel',style: Theme.of(context).textTheme.subtitle2!.copyWith(color:AppColors.alertColor),)),
          TextButton(onPressed: (){
            Navigator.pop(context);
            ref.child(SessionController().userid.toString()).update({
            'phone': phoneController.text.toString()
          }).then((value){
            phoneController.clear();
            });
          }, child: Text('Ok',style: Theme.of(context).textTheme.subtitle2))
        ],
      );
        }
    );
  }


  void logout(BuildContext context){
    auth.signOut().then((value){
      SessionController().userid = '';
      Navigator.pushNamed(context, RouteName.loginview);

    }).onError((error, stackTrace){
      Utils.toastMessage(error.toString());
    });
  }




}