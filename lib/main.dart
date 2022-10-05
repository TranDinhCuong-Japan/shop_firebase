import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_firebase/controller/myuser_controller.dart';
import 'package:shop_firebase/pages/auth/login.dart';
import 'package:shop_firebase/pages/auth/register.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shop_firebase/pages/auth/verify_email_page.dart';
import 'package:shop_firebase/pages/home/history_page.dart';
import 'package:shop_firebase/pages/home/home_page.dart';
import 'package:shop_firebase/pages/home/index.dart';
import 'firebase_options.dart';
import 'package:shop_firebase/router/routers.dart';
import 'package:shop_firebase/helper/denpendencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    name: "shop-firebase-f0336-default-rtdb",
  );
  await dep.init();
  runApp(const ShopApp());
}

class ShopApp extends StatefulWidget {
  const ShopApp({Key? key}) : super(key: key);

  @override
  State<ShopApp> createState() => _ShopAppState();
}

class _ShopAppState extends State<ShopApp> {

  @override
  Widget build(BuildContext context) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: FirebaseAuth.instance.currentUser==null?LoginPage():VerifyEmailPage(),
          getPages: RoutesHelper.routers,
        );
  }
}

