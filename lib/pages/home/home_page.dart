import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_firebase/controller/status_controller.dart';
import 'package:shop_firebase/models/myuser_model.dart';
import 'package:shop_firebase/utils/app_color.dart';
import 'package:shop_firebase/utils/dimensison.dart';
import 'package:shop_firebase/widgets/alert_dialog_widget.dart';
import 'package:shop_firebase/widgets/big_text_widget.dart';
import 'package:shop_firebase/widgets/button_widget.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../controller/history_controller.dart';
import '../../controller/myuser_controller.dart';
import '../../widgets/small_text_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  final auth = FirebaseAuth.instance.currentUser;
  MyUserModel? myUser;
  String? now;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    Get.find<StatusController>().getStatusReal();
    getUser();
    now = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
  }

  Future<void> getUser() async{
    await Get.find<MyUserController>().getMyUser();
    myUser = Get.find<MyUserController>().myUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<StatusController>(
        builder: (status) {
          return status.isLoaded?Column(
              children: [
                Container(
                      padding: EdgeInsets.only(top: Dimensisons.size100, left: Dimensisons.size20, right: Dimensisons.size20, bottom: Dimensisons.size20),
                      decoration: BoxDecoration(
                          color: status.status!.status??false?AppColors.mainColor:AppColors.buttonColor,
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(Dimensisons.size30))
                      ),
                      child: status.status!.status??false?Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SmallTextWidget(name: "Tình trạng", textColor: Colors.black,),
                          SizedBox(height: Dimensisons.size20,),
                          Center(child: BigTextWidget(name: "Đang sử dụng", fontSize: 30,color: Colors.white)),
                          SizedBox(height: Dimensisons.size20,),
                          SmallTextWidget(name: "Người sử dụng:", textColor: Colors.black,),
                          Center(child: BigTextWidget(name: status.status!.person.toString(), fontSize: 30,color: Colors.white)),
                          SizedBox(height: Dimensisons.size20,),
                          SmallTextWidget(name: "Thời gian bắt đầu:", textColor: Colors.black,),
                          Center(child: BigTextWidget(name:status.status!.startTime.toString(), fontSize: 30,color: Colors.white)),
                        ],
                      )
                                              :Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SmallTextWidget(name: "Tình trạng", textColor: AppColors.mainColor,),
                          SizedBox(height: Dimensisons.size20,),
                          Center(child: BigTextWidget(name: "Rảnh", fontSize: 30,color: Colors.white)),
                        ],
                      ),
                    ),
                SizedBox(height: Dimensisons.size30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    status.status!.status??false?GestureDetector(
                        onTap: (){
                          if(status.status!.personId == auth!.uid){
                            AlertDialogWidget()
                                .showMyDialog(
                              context,
                              "Thông báo",
                              "Bạn muốn kết thúc hành trình của mình?",
                                (){
                                  status.updateStatusReal(false,"","","");
                                  Get.find<HistoryController>().addHistory(now!);
                                },
                              true
                            );
                          }else{
                            AlertDialogWidget()
                                .showMyDialog(
                                context,
                                "Xin lỗi!",
                                "Bạn không thể kết thúc hành trình của người khác",
                                (){}, false
                            );
                          }
                        },
                        child: ButtonWidget(name: "End", color: AppColors.mainColor,))
                        :GestureDetector(
                      onTap: (){
                        setState(() {
                          // status.updateStatusReal(true, myUser!.name!, myUser!.id!, now!);
                          status.updateStatusReal(true, auth!.displayName!, auth!.uid, now!);
                          // Get.find<HistoryController>().addStartTime(
                          //     myUser!.id!, myUser!.name!,
                          //     now!,
                          //     DateFormat('yyy-MM-dd').format(DateTime.now())
                          // );
                          Get.find<HistoryController>().addStartTime(
                              auth!.uid, auth!.displayName!,
                              now!,
                              DateFormat('yyy-MM-dd').format(DateTime.now())
                          );
                        });
                      },
                        child: ButtonWidget(name: "Start"))
                  ],
                )
              ],
            )
              :Center(child: CircularProgressIndicator(color: AppColors.mainColor,));
        }
      ),
    );
  }
}
