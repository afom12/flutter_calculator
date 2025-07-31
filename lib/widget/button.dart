import 'package:flutter/material.dart';
import 'package:flutter_calculator/controller/theme_controller.dart';
import 'package:flutter_calculator/utils/colors.dart';
import 'package:get/get.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isOperator;
  final bool isEqual;
  final bool isLeftOperator;
  final bool isSpecial;

  const CalculatorButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.isOperator = false,
    this.isEqual = false,
    this.isLeftOperator = false,
    this.isSpecial = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.isDark;

    Color getButtonColor() {
      if (isLeftOperator) {
        return isDark ? DarkColors.leftOperatorColor : LightColors.leftOperatorColor;
      }
      if (isOperator) {
        return isDark ? DarkColors.operatorColor : LightColors.operatorColor;
      }
      if (isEqual) {
        return isDark ? DarkColors.equalColor : LightColors.equalColor;
      }
      return isDark ? DarkColors.btnBgColor : LightColors.btnBgColor;
    }

    Color getTextColor() {
      if (isLeftOperator || isOperator || isEqual) {
        return Colors.white;
      }
      return isDark ? DarkColors.textColor : LightColors.textColor;
    }

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Material(
        color: getButtonColor(),
        borderRadius: BorderRadius.circular(50),
        elevation: 0,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: getTextColor(),
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}