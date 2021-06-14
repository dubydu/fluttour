import 'package:flutter/material.dart';
import 'package:fluttour/app_define/app_color.dart';
import 'package:fluttour/app_define/app_style.dart';
import 'package:fluttour/utils/extension/app_extension.dart';

class WAuthTextField extends StatelessWidget {
  const WAuthTextField(
      {Key? key,
      required this.controller,
      required this.labelText,
      required this.obscureText,
      required this.isSecurityTextField,
      this.onPress,
      required this.onChange})
      : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final bool isSecurityTextField;
  final Function(bool)? onPress;
  final Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.H,
      child: TextFormField(
        onChanged: (text) async {
          onChange(text);
        },
        controller: controller,
        autofocus: false,
        obscureText: obscureText,
        decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(),
            labelStyle: boldTextStyle(17.SP,
                color: AppColors.darkBlue.withOpacity(0.7)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.darkBlue, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.greyBlue, width: 1.3),
            ),
            suffixIcon: (isSecurityTextField == true)
                ? IconButton(
                    icon: Icon((obscureText == true)
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () async {
                      if (onPress != null) {
                        await onPress!(!obscureText);
                      }
                    })
                : null),
      ),
    );
  }
}
