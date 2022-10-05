import 'package:flutter/cupertino.dart';
import 'package:shop_firebase/utils/app_color.dart';
import 'package:shop_firebase/widgets/small_text_widget.dart';

import 'big_text_widget.dart';

class TitleAndDetail extends StatelessWidget {
  final String title;
  final String detail;
  const TitleAndDetail({Key? key,required this.title,required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SmallTextWidget(name: title + ": ", textColor: AppColors.mainColor,),
        SmallTextWidget(name: detail,fontSize: 20,)
      ],
    );
  }
}
