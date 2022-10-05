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

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

    String email = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(email);

class _RegisterPageState extends State<RegisterPage> {

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();

  String error ="";
  bool isError = false;


  validation(String name, String email, String pass) {
    if(_globalKey.currentState!.validate()){
      _authController.signUp(name, email, pass,
              (){
                  Get.toNamed(RoutesHelper.getVerifiPage());
              },
              (mgs){
                  setState(() {
                    isError = true;
                    error = mgs;
                    print("error signup: $error");
            });
              }
          );
    }else{
      setState(() {
        isError = false;
      });
    }
  }

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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
                  child: BigTextWidget(name: 'Register', fontSize: Dimensisons.size30,color: AppColors.mainColor,),
                ),
                isError?Container(
                  padding: EdgeInsets.only(top: Dimensisons.size20),
                  child: Text(error, style: TextStyle(color: Colors.red),),
                )
                        :Container(),
                SizedBox(height: Dimensisons.size20,),
                TextFieldWidget(
                  editingController: name,
                    validator: ()=>(value){
                      if(value==null || value.isEmpty){
                        return "Enter your name";
                      }
                      return null;
                    },
                    hintText: 'Name', icon: Icons.person),
                SizedBox(height: Dimensisons.size10,),
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
                    textEditingController: password,
                    validator:()=> (value){
                      if(value==null || value.isEmpty){
                        return "Enter your password";
                      }else if(value.length <6){
                        return "Password is too short";
                      }
                      return null;
                    },
                    hintText: 'Password', icon: Icons.lock),
                SizedBox(height: Dimensisons.size10,),
                PasswordTextFieldWidget(
                    validator:()=> (value){
                      if(value!=password.text){
                        return "Incorrect password";
                      }
                      return null;
                    },
                    hintText: 'Confirm password', icon: Icons.lock),
                SizedBox(height: Dimensisons.size30,),
                GestureDetector(
                onTap: (){
                  validation(name.text, email.text, password.text);
                }
                ,child: ButtonWidget(name: 'Sign up')),
                SizedBox(height: Dimensisons.size20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmallTextWidget(name: 'You have a account: '),
                    SizedBox(width: Dimensisons.size10,),
                    GestureDetector(
                        onTap: (){
                          Get.toNamed(RoutesHelper.getLogin());
                        },
                        child: BigTextWidget(name: "Login", color: Colors.blue,))
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
