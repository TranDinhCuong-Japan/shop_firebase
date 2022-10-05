import 'package:flutter/cupertino.dart';
import 'package:shop_firebase/utils/app_color.dart';
import 'package:shop_firebase/utils/dimensison.dart';

class BigTextWidget extends StatelessWidget {
  final String name;
  final double fontSize;
  final Color color;
  final TextOverflow overflow;
  const BigTextWidget({Key? key, required this.name, this.fontSize=0, this.color = const Color(0xFF332d2b), this.overflow = TextOverflow.ellipsis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
          fontFamily: 'CormorantSC',
          fontSize: fontSize==0?Dimensisons.size20:fontSize,
          fontWeight: FontWeight.bold,
          color: color,
          overflow: overflow
      ),
    );
  }
}
