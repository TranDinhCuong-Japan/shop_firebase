import 'package:flutter/cupertino.dart';

import '../utils/app_color.dart';
import '../utils/dimensison.dart';

class SmallTextWidget extends StatelessWidget {
  final String name;
  final double fontSize;
  final Color textColor;
  const SmallTextWidget({Key? key, required this.name, this.fontSize=0, this.textColor = const Color(0xFFa9a29f)}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
          fontFamily: 'CormorantSC',
          fontSize: fontSize==0?Dimensisons.size16:fontSize,
          color: textColor,
      )
    );
  }
}
