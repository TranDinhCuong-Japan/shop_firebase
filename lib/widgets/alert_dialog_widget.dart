import 'package:flutter/material.dart';
import 'package:shop_firebase/utils/app_color.dart';
import 'package:shop_firebase/widgets/big_text_widget.dart';
import 'package:shop_firebase/widgets/small_text_widget.dart';
class AlertDialogWidget{

  Future<void> showMyDialog(BuildContext context, String title, String content, Function ok, bool isCancel) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: BigTextWidget(name: title,color: AppColors.mainColor,),
          content: SmallTextWidget(name: content,),
          actions: <Widget>[
            isCancel?TextButton(
              child: const BigTextWidget(name: 'Cancel', color: Colors.red,),
              onPressed: (){
                Navigator.of(context).pop();
              }
            ):Container(),
            TextButton(
              child: BigTextWidget(name: 'OK', color: AppColors.buttonColor,),
              onPressed: (){
                ok();
                Navigator.of(context).pop();
        }
            ),
          ],
        );
      },
    );
  }
}
