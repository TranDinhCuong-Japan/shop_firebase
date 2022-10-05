import 'package:get/get.dart';
import 'package:shop_firebase/controller/history_controller.dart';
import 'package:shop_firebase/controller/myuser_controller.dart';
import 'package:shop_firebase/controller/status_controller.dart';

import '../controller/auth_controller.dart';

Future<void> init() async{

  // controller
  Get.lazyPut(() => MyUserController());
  Get.lazyPut(() => StatusController());
  Get.lazyPut(() => HistoryController());
  Get.lazyPut(() => AuthController());

}