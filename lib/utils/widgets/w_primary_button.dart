import 'package:flutter/material.dart';
import 'package:fluttour/app_define/app_color.dart';
import 'package:fluttour/utils/extension/app_extension.dart';
import 'package:fluttour/app_define/app_style.dart';
import 'package:flutter/cupertino.dart';

class WPrimaryButton extends StatelessWidget {
  WPrimaryButton({required this.title,
    required this.isSelected,
    required this.onPress,
    this.isLoading});

  final String title;
  final Function onPress;
  final bool isSelected;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isSelected == true && isLoading == false) {
          onPress();
        }
      },
      child: Container(
        height: 60.H,
        decoration: BoxDecoration(
          color: backgroundColors(),
          border: Border.all(color: borderColors(), width: 1.5),
          borderRadius: BorderRadius.circular(6.H)
        ),
        child: Center(
          child: (isLoading == false)
              ? Text(title, style: boldTextStyle(16, color: titleColors()))
              : CupertinoActivityIndicator(radius: 15.SP, animating: (isLoading == true))
        )
      ),
    );
  }

  Color borderColors() {
    return isSelected ? Colors.transparent : Colors.transparent;
  }

  Color backgroundColors() {
    return isSelected ? AppColors.salmon : AppColors.gray;
  }

  Color titleColors() {
    return isSelected ? Colors.white : AppColors.black.withOpacity(0.4);
  }
}
