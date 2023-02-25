import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app_android/utils/routes/route_name.dart';
import 'package:social_app_android/view/dashboard/profile/profile.dart';
import 'package:social_app_android/view/dashboard/user/user_list_screen.dart';
import 'package:social_app_android/view_model/services/session_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:social_app_android/res/color.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final controller = PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreen(){
    return [
      SafeArea(child: Text('Home',style: Theme.of(context).textTheme.subtitle1,)),
      Text('Chat'),
      Text('Add'),
      UserListScreen(),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItem(){
    return[
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
      activeColorPrimary: AppColors.primaryIconColor,
      inactiveIcon:Icon(Icons.home, color:AppColors.textFieldDefaultBorderColor),),
      PersistentBottomNavBarItem(icon: Icon(Icons.message),
          activeColorPrimary: AppColors.primaryIconColor,
          inactiveIcon:Icon(Icons.message, color:Colors.grey.shade100)),
      PersistentBottomNavBarItem(icon: Icon(Icons.add),
          activeColorPrimary: AppColors.primaryIconColor,
          inactiveIcon:Icon(Icons.add, color:Colors.grey.shade100)),
      PersistentBottomNavBarItem(icon: Icon(Icons.message),
          activeColorPrimary: AppColors.primaryIconColor,
          inactiveIcon:Icon(Icons.add, color:Colors.grey.shade100)),
      PersistentBottomNavBarItem(icon: Icon(Icons.person),
          activeColorPrimary: AppColors.primaryIconColor,
          inactiveIcon:Icon(Icons.person, color:Colors.grey.shade100)),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
        context, screens: _buildScreen(),
      items: _navBarItem(),
      backgroundColor: AppColors.secondaryTextColor,
      decoration: NavBarDecoration(
        colorBehindNavBar: Colors.red,
        borderRadius: BorderRadius.circular(1)
    ),
      navBarStyle: NavBarStyle.style15,
    );
  }
}
