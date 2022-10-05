import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_firebase/controller/auth_controller.dart';
import 'package:shop_firebase/pages/home/index.dart';
import 'package:shop_firebase/router/routers.dart';
import 'package:shop_firebase/utils/app_color.dart';
import 'package:shop_firebase/utils/dimensison.dart';
import 'package:shop_firebase/widgets/big_text_widget.dart';
import 'package:shop_firebase/widgets/button_widget.dart';
import 'package:shop_firebase/widgets/small_text_widget.dart';
import 'package:get/get.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {

  final auth = FirebaseAuth.instance;
  User?  user;
  Timer? timer;
  bool isEmailVerified = false;
  bool isResendEmail = false;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    isEmailVerified = user!.emailVerified;
    if(isEmailVerified==false){
      sendEmailVerification();
      timer = Timer.periodic(Duration(seconds: 3), (timer) {
        Get.find<AuthController>().checkEmailVerified(timer,
            (){
          Get.toNamed(RoutesHelper.getIndexPage());
            }
        );
      });

    }

  }

  Future<void> sendEmailVerification() async{
    try{
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      setState(() {
        isResendEmail = false;
      });
      await Future.delayed(Duration(seconds: 60));
      setState(() {
        isResendEmail = true;
      });
    }catch(e){
      print(e.toString());
      Get.snackbar("Error", e.toString());
    }
  }


  @override
  void dispose() {
    super.dispose();
    print("test dispose");
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified?Index():Scaffold(
      appBar: AppBar(
        title:BigTextWidget(name: "Email verify",),
        backgroundColor: AppColors.mainColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SmallTextWidget(name: "A verification email has been sent to your email.",),
            SizedBox(height: Dimensisons.size10,),
            SmallTextWidget(name: "Please check your email",),
            SizedBox(height: Dimensisons.size30,),
            isResendEmail?GestureDetector(
                            onTap: (){
                              sendEmailVerification();
                            },
                            child: ButtonWidget(name: "Resent Email"))
                          :Container(),
            SizedBox(height: Dimensisons.size20,),
            GestureDetector(
                onTap: (){
                  Get.find<AuthController>().signOut((){
                    timer!.cancel();
                    Get.toNamed(RoutesHelper.getLogin());
                  });
                },
                child: ButtonWidget(name: "Exit", color: Colors.red,))
          ],),
      ),
    );
  }


}
