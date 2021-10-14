import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_library/templates/app_color.dart';

class CustomButton extends StatelessWidget {
  String buttonText = "";
  Function() onTap;

  CustomButton({
    Key key,
    @required this.buttonText,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            buttonText.toUpperCase(),
            style: TextStyle(
              fontSize: 18,
              color: AppColor.whiteColor,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
