import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import '../utils/dimensison.dart';
import 'big_text_widget.dart';

class ButtonWidget extends StatelessWidget {
  final String name;
  final Color? color;
  const ButtonWidget({Key? key,required this.name, this.color=const Color(0xFF33691E)}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Dimensisons.size10, bottom: Dimensisons.size10, left: Dimensisons.size20, right: Dimensisons.size20),
      child: BigTextWidget(name: name,color: Colors.white,),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensisons.size10),
          color: color
      ),
    );
  }
}
