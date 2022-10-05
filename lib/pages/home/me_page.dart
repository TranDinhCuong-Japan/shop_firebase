import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_firebase/controller/auth_controller.dart';
import 'package:shop_firebase/router/routers.dart';
import 'package:shop_firebase/utils/app_color.dart';
import 'package:shop_firebase/utils/dimensison.dart';
import 'package:shop_firebase/widgets/icon_title.dart';
import 'package:get/get.dart';

import '../../controller/myuser_controller.dart';
import '../auth/register.dart';

class MePage extends StatelessWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController _auth = AuthController();
    // var list = Get
    //     .find<MyUserController>()
    //     .listMyUser[0];

    // var myUser = Get.find<MyUserController>().myUser;
    var user = FirebaseAuth.instance.currentUser;
    print(user);
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.only(top: Dimensisons.size100),
          child: Container(
            padding: EdgeInsets.only(
                left: Dimensisons.size30, right: Dimensisons.size30),
            child: Column(
              children: [
                Container(
                  width: Dimensisons.size150,
                  height: Dimensisons.size150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          Dimensisons.size150 / 2),
                      image: DecorationImage(
                        image: user!.photoURL!=null?NetworkImage(user.photoURL!):AssetImage("assets/images/user.png") as ImageProvider,
                        // image: AssetImage("assets/images/user.png"),
                        fit: BoxFit.cover
                      ),
                  ),
                ),
                SizedBox(height: Dimensisons.size50,),
                IconTitle(title: "Name",
                    icon: Icons.person,
                    name: user.displayName!),
                SizedBox(height: Dimensisons.size20,),
                IconTitle(title: "Email",
                    icon: Icons.email,
                    name: user.email!),
                SizedBox(height: Dimensisons.size20,),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RoutesHelper.getChangePassword());
                  },
                    child: IconTitle(title: "Change", icon: Icons.password, name: "Change password")),
                SizedBox(height: Dimensisons.size20,),
                GestureDetector(
                    onTap: () {
                      _auth.signOut((){
                        Get.toNamed(RoutesHelper.getLogin());
                      });
                    },
                    child: IconTitle(title: "Action",
                      icon: Icons.logout,
                      name: "Logout",
                      iconColor: AppColors.mainColor,
                      textColor: AppColors.mainColor,)),
              ],
            ),
          )
      ),
    );
  }
}
