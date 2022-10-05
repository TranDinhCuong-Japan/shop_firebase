import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_firebase/controller/auth_controller.dart';
import 'package:shop_firebase/router/routers.dart';
import 'package:shop_firebase/utils/app_color.dart';
import 'package:shop_firebase/utils/dimensison.dart';
import 'package:get/get.dart';
import 'package:shop_firebase/widgets/big_text_widget.dart';
import 'package:shop_firebase/widgets/button_widget.dart';
import 'package:shop_firebase/widgets/password_text_field_widget.dart';
import 'package:shop_firebase/widgets/small_text_widget.dart';
import 'package:shop_firebase/widgets/text_field_widget.dart';
import 'package:shop_firebase/router/routers.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

 String e = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
 RegExp regExp = RegExp(e);

class _LoginPageState extends State<LoginPage> {

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  AuthController _authController = AuthController();

  String error="";
  bool isError = false;


  void validation(String email, String password){
    if(_globalKey.currentState!.validate()){
      _authController.signIn(email, password,
          (){
          Get.toNamed(RoutesHelper.getVerifiPage());
          },
          (mgs){
        setState(() {
          error = mgs;
          isError = true;
        });
          }
      );
    }else{
      setState(() {
        isError=false;
      });
    }
  }

  TextEditingController email = TextEditingController();
  TextEditingController passWord = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: Dimensisons.size100, left: Dimensisons.size20, right: Dimensisons.size20),
            child: Form(
              key: _globalKey,
              child: Column(
                children: [
                  Center(
                    child: BigTextWidget(name: 'Login', fontSize: Dimensisons.size30,color: AppColors.mainColor,),
                  ),
                  isError?Container(
                            padding: EdgeInsets.only(top: Dimensisons.size20),
                            child: Text(error, style: const TextStyle(color: Colors.red),),
                          )
                          :Container(),
                  SizedBox(height: Dimensisons.size20,),
                  TextFieldWidget(
                    editingController: email,
                      validator:()=> (value){
                        if(value==null || value.isEmpty){
                          return "Enter your email";
                        }else if(!regExp.hasMatch(value)){
                          return "Email is invaild";
                        }
                        return null;
                      },
                      hintText: 'Email', icon: Icons.email),
                  SizedBox(height: Dimensisons.size10,),
                  PasswordTextFieldWidget(
                      textEditingController: passWord,
                      validator:()=> (value){
                        if(value==null || value.isEmpty){
                          return "Enter your password";
                        }else if(value.length <6){
                          return "Password is too short";
                        }
                        return null;
                      },
                      hintText: 'Password', icon: Icons.lock),
                  SizedBox(height: Dimensisons.size20,),
                  GestureDetector(
                      onTap: (){
                        validation(email.text, passWord.text);
                      }
                      ,child: ButtonWidget(name: 'Login')),
                  SizedBox(height: Dimensisons.size20,),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RoutesHelper.getResetPassword());
                    },
                      child: SmallTextWidget(name: "Forgot password", textColor: Colors.blue,)),
                  SizedBox(height: Dimensisons.size20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SmallTextWidget(name: 'Creat an account: '),
                      SizedBox(width: Dimensisons.size10,),
                      GestureDetector(
                          onTap: (){
                            Get.toNamed(RoutesHelper.getSignup());
                          },
                          child: BigTextWidget(name: "SignUp", color: Colors.blue,))
                    ],
                  ),
                  SizedBox(height: Dimensisons.size30,),
                  GestureDetector(
                    onTap: (){
                      Get.find<AuthController>().signInWithGoogle(()=>Get.toNamed(RoutesHelper.getVerifiPage()));
                    },
                      child: ButtonWidget(name: "Sign in whith Google"))
                ],
              ),
            ),
          ),
        )
    );
  }
}
