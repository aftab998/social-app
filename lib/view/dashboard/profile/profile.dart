import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app_android/res/color.dart';
import 'package:social_app_android/res/components/round_button.dart';
import 'package:social_app_android/view_model/profile/profile_controller.dart';
import 'package:social_app_android/view_model/services/session_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ref = FirebaseDatabase.instance.ref('Users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ChangeNotifierProvider(
        create: (_) => ProfileController(),
        child: Consumer<ProfileController>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: StreamBuilder(
                      stream: ref
                          .child(SessionController().userid.toString())
                          .onValue,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasData) {
                          Map<dynamic, dynamic> map =
                              snapshot.data.snapshot.value;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 13),
                                    child: Center(
                                      child: Container(
                                        height: 130,
                                        width: 130,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: AppColors
                                                    .primaryTextTextColor,
                                                width: 5)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),

                                          child: provider.image == null  ?
                                          map['profile'].toString() == ""
                                              ? const Icon(
                                                  Icons.person,
                                                  size: 35,
                                                )
                                              : Image(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    map['profile'].toString(),
                                                  ),
                                                  loadingBuilder: (context, child,
                                                      loadingProgress) {
                                                    if (loadingProgress == null)
                                                      return child;
                                                    return Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  },
                                                  errorBuilder:
                                                      (context, object, stack) {
                                                    return Container(
                                                      child: Icon(
                                                          Icons.error_outline,
                                                          color: AppColors
                                                              .alertColor),
                                                    );
                                                  }) :
                                              Image.file(
                                                File(provider.image!.path).absolute
                                              )
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      provider.pickImage(context);
                                    },
                                    child: CircleAvatar(
                                      radius: 14,
                                      backgroundColor: AppColors.primaryIconColor,
                                      child: Icon(
                                        Icons.add,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              GestureDetector(
                                onTap: (){
                                  provider.ShowUserNameDialogAlert(context, map['username']);
                                },
                                child: ReuseableRow(
                                    title: 'Username',
                                    value: map['username'],
                                    iconData: Icons.person),
                              ),
                              GestureDetector(
                                onTap: (){
                                  provider.ShowPhoneDialogAlert(context, map['phone']);
                                },
                                child: ReuseableRow(
                                    title: 'Phone',
                                    value: map['phone'] == ''
                                        ? 'xxx-xxx-xxx'
                                        : map['phone'],
                                    iconData: Icons.phone_outlined),
                              ),
                              ReuseableRow(
                                  title: 'Email',
                                  value: map['email'],
                                  iconData: Icons.email_outlined),
                              const SizedBox(
                                height: 24,
                              ),
                              RoundButton(title: 'Logout', onPress: () {
                                provider.logout(context);
                              })
                            ],
                          );
                        } else {
                          return Center(
                              child: Text(
                            'Something went wrong',
                            style: Theme.of(context).textTheme.subtitle1,
                          ));
                        }
                      }),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  final String title, value;
  final IconData iconData;
  const ReuseableRow(
      {Key? key,
      required this.title,
      required this.value,
      required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          leading: Icon(
            iconData,
            color: AppColors.primaryColor,
          ),
          trailing: Text(
            value,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        Divider(
          color: AppColors.dividedColor.withOpacity(0.5),
        )
      ],
    );
  }
}
