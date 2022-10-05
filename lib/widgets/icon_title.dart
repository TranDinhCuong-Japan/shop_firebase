import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_firebase/widgets/big_text_widget.dart';
import 'package:shop_firebase/widgets/small_text_widget.dart';

import '../utils/dimensison.dart';

class IconTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  final String name;
  final Color iconColor;
  final Color textColor;
  const IconTitle({Key? key, required this.title, required this.icon, required this.name, this.iconColor = const Color(0xFF689F38), this.textColor = const Color(0xFF332d2b)}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          children: [
            Container(
              child: Icon(icon, color: iconColor,),
            ),
            SizedBox(width: Dimensisons.size10,),
            SmallTextWidget(name: title + ":"),
            SizedBox(width: Dimensisons.size10,),
            Expanded(child: BigTextWidget(name: name, color: textColor,))
          ],
        ),
    );
  }
}
