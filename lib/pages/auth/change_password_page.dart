import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_firebase/controller/auth_controller.dart';
import 'package:shop_firebase/router/routers.dart';
import 'package:shop_firebase/utils/app_color.dart';
import 'package:shop_firebase/utils/dimensison.dart';
import 'package:get/get.dart';
import 'package:shop_firebase/widgets/alert_dialog_widget.dart';
import 'package:shop_firebase/widgets/big_text_widget.dart';
import 'package:shop_firebase/widgets/button_widget.dart';
import 'package:shop_firebase/widgets/password_text_field_widget.dart';
import 'package:shop_firebase/widgets/small_text_widget.dart';
import 'package:shop_firebase/widgets/text_field_widget.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();

  String error ="";
  bool isError = false;


  validation(String oldPassword, String newPassword) {
    if(_globalKey.currentState!.validate()){
      _authController.changePassword(oldPassword, newPassword,
          (msg){
        setState(() {
          error = msg;
          isError = true;
        });
          },

          (){
        AlertDialogWidget().showMyDialog(context, "Change password", "Change password success!", (){
          Get.find<AuthController>().signOut(()=>Get.toNamed(RoutesHelper.getLogin()));
        }, false);
          }
      );
    }else{
      setState(() {
        isError = false;
      });
    }
  }

  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();

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
                    child: BigTextWidget(name: 'Change password', fontSize: Dimensisons.size30,color: AppColors.mainColor,),
                  ),
                  isError?Container(
                    padding: EdgeInsets.only(top: Dimensisons.size20),
                    child: Text(error, style: TextStyle(color: Colors.red),),
                  )
                      :Container(),
                  SizedBox(height: Dimensisons.size10,),
                  PasswordTextFieldWidget(
                      textEditingController: oldPassword,
                      validator:()=> (value){
                        if(value==null || value.isEmpty){
                          return "Enter your password";
                        }
                        return null;
                      },
                      hintText: 'Old password', icon: Icons.lock),
                  SizedBox(height: Dimensisons.size10,),
                  PasswordTextFieldWidget(
                      textEditingController: newPassword,
                      validator:()=> (value){
                        if(value==null || value.isEmpty){
                          return "Enter your password";
                        }else if(value.length <6){
                          return "Password is too short";
                        }
                        return null;
                      },
                      hintText: 'New password', icon: Icons.lock),
                  SizedBox(height: Dimensisons.size10,),
                  PasswordTextFieldWidget(
                      validator:()=> (value){
                        if(value!=newPassword.text){
                          return "Incorrect password";
                        }
                        return null;
                      },
                      hintText: 'Confirm new password', icon: Icons.lock),
                  SizedBox(height: Dimensisons.size30,),
                  GestureDetector(
                      onTap: (){
                        validation(oldPassword.text, newPassword.text);
                      }
                      ,child: ButtonWidget(name: 'Change password')),
                  SizedBox(height: Dimensisons.size20,),
                  GestureDetector(
                      onTap: (){
                        Navigator.of(context).pop();
                      }
                      ,child: ButtonWidget(name: 'exit', color: Colors.red,))

                ],
              ),
            ),
          ),
        )
    );
  }
}
