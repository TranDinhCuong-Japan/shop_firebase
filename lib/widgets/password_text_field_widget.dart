import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/app_color.dart';
import '../utils/dimensison.dart';

class PasswordTextFieldWidget extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final Function validator;
  final TextEditingController? textEditingController;
  const PasswordTextFieldWidget({Key? key, required this.hintText, required this.icon, required this.validator, this.textEditingController}) : super(key: key);

  @override
  State<PasswordTextFieldWidget> createState() => _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  bool _isObs = true;
  bool _isSunffixIcon = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      validator: widget.validator(),
      obscureText: _isObs,
      decoration: InputDecoration(
          suffixIcon: _isSunffixIcon?
                                    GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            _isObs = !_isObs;
                                            _isSunffixIcon = false;
                                            FocusScope.of(context).unfocus();
                                          });
                                        },
                                        child: Icon(Icons.visibility))
                                    :GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            _isObs = !_isObs;
                                            _isSunffixIcon = true;
                                            FocusScope.of(context).unfocus();
                                          });
                                        },
                                        child: Icon(Icons.visibility_off)),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontFamily: 'CormorantSC',
            fontSize: Dimensisons.size16,
            color: AppColors.smallTextColor,
          ),
          prefixIcon: Icon(widget.icon, color: AppColors.iconColor,),
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
