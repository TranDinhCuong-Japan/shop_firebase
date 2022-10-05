import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_firebase/controller/auth_controller.dart';
import 'package:shop_firebase/pages/auth/login.dart';
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

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

String email = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = new RegExp(email);

class _ResetPasswordPageState extends State<ResetPasswordPage> {

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();

  String error ="";
  bool isError = false;

  validation(String email) {
    if(_globalKey.currentState!.validate()){
      _authController.resetPassword(email,
              () async{
        await AlertDialogWidget().showMyDialog(
            context,
            "Reset password",
            "A resetpassword email has been sent to your email. Please check your email",
            (){
              Navigator.of(context).pop();
            }
            , false);
        Get.toNamed(RoutesHelper.getLogin());
      },
          (msg){
        setState(() {
          error = msg;
          isError = true;
        });
          }
      );
    }else{
      setState(() {
        isError = false;
      });
    }
  }

  TextEditingController email = TextEditingController();

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
                    child: BigTextWidget(name: 'Reset password', fontSize: Dimensisons.size30,color: AppColors.mainColor,),
                  ),
                  isError?Container(
                    padding: EdgeInsets.only(top: Dimensisons.size20),
                    child: Text(error, style: TextStyle(color: Colors.red),),
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
                  SizedBox(height: Dimensisons.size30,),
                  GestureDetector(
                      onTap: (){
                        validation(email.text);
                      }
                      ,child: ButtonWidget(name: 'Reset password')),
                  SizedBox(height: Dimensisons.size10,),
                  GestureDetector(
                      onTap: (){
                        Get.toNamed(RoutesHelper.getLogin());
                      }
                      ,child: ButtonWidget(name: 'Cancel', color: Colors.red,)),
                ],
              ),
            ),
          ),
        )
    );
  }
}
