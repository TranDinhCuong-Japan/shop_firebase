import 'package:get/get.dart';
import 'package:shop_firebase/pages/auth/change_password_page.dart';
import 'package:shop_firebase/pages/auth/login.dart';
import 'package:shop_firebase/pages/auth/register.dart';
import 'package:shop_firebase/pages/auth/reset_password_page.dart';
import 'package:shop_firebase/pages/auth/verify_email_page.dart';
import 'package:shop_firebase/pages/home/index.dart';

class RoutesHelper{
  static String login='/login';
  static String signup = '/register';
  static String indexPage = '/index-page';
  static String verifyPage = '/verify-page';
  static String resetPassword = '/resetpassword-page';
  static String changePassword = '/changepassword-page';

  static String getLogin() =>"$login";
  static String getSignup() =>"$signup";
  static String getIndexPage() =>"$indexPage";
  static String getVerifiPage() =>"$verifyPage";
  static String getResetPassword() =>"$resetPassword";
  static String getChangePassword() =>"$changePassword";

  static List<GetPage> routers=[
    GetPage(name: login, page: ()=>LoginPage()),
    GetPage(name: signup, page: ()=>RegisterPage()),
    GetPage(name: indexPage, page: ()=>Index()),
    GetPage(name: verifyPage, page: ()=>VerifyEmailPage()),
    GetPage(name: resetPassword, page: ()=>ResetPasswordPage()),
    GetPage(name: changePassword, page: ()=>ChangePasswordPage()),
  ];

}