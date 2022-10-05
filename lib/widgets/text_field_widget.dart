import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_firebase/utils/dimensison.dart';

import '../utils/app_color.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final Function validator;
  final TextEditingController editingController;
  const TextFieldWidget({Key? key,required this.hintText, required this.icon,required this.validator,required this.editingController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: editingController,
      validator: validator(),
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'CormorantSC',
            fontSize: Dimensisons.size16,
            color: AppColors.smallTextColor,
          ),
          prefixIcon: Icon(icon, color: AppColors.iconColor,),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensisons.size20),
              borderSide: BorderSide(
                  color: AppColors.mainColor
              )
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensisons.size20)
          )
      ),
    );
  }
}
