import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_calculator/controller/calculate_controller.dart';
import 'package:flutter_calculator/controller/theme_controller.dart';
import 'package:flutter_calculator/utils/colors.dart';
import 'package:flutter_calculator/widget/button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final List<List<String>> buttons = [
    ["C", "DEL", "%", "÷"],
    ["7", "8", "9", "x"],
    ["4", "5", "6", "-"],
    ["1", "2", "3", "+"],
    ["sin", "cos", "tan", "="],
    ["(", ")", "π", "ANS"],
    ["0", ".", "√", "^"],
  ];

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CalculateController>();
    var themeController = Get.find<ThemeController>();

    return GetBuilder<ThemeController>(builder: (context) {
      return Scaffold(
        backgroundColor: themeController.isDark
            ? DarkColors.scaffoldBgColor
            : LightColors.scaffoldBgColor,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: outputSection(themeController, controller),
              ),
              Expanded(
                flex: 3,
                child: inputSection(themeController, controller),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget inputSection(
      ThemeController themeController, CalculateController controller) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: themeController.isDark
            ? DarkColors.sheetBgColor
            : LightColors.sheetBgColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          // Angle mode toggle
          GetBuilder<CalculateController>(builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Angle Mode: ',
                    style: TextStyle(
                      color: themeController.isDark
                          ? DarkColors.textColor
                          : LightColors.textColor,
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.toggleAngleMode();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: themeController.isDark
                            ? DarkColors.btnBgColor
                            : LightColors.btnBgColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        controller.isRadians ? "RAD" : "DEG",
                        style: TextStyle(
                          color: themeController.isDark
                              ? DarkColors.textColor
                              : LightColors.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          // Theme switcher
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: AdvancedSwitch(
              controller: themeController.switcherController,
              activeColor: Colors.green,
              inactiveColor: Colors.grey.shade700,
              activeChild: const Text('Light', style: TextStyle(color: Colors.white)),
              inactiveChild: const Text('Dark', style: TextStyle(color: Colors.white)),
              borderRadius: const BorderRadius.all(Radius.circular(1000)),
              width: 100.0,
              height: 40.0,
            ),
          ),
          // Calculator buttons
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: buttons.length * buttons[0].length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (context, index) {
                int row = index ~/ 4;
                int col = index % 4;
                String buttonText = buttons[row][col];

                bool isOperator = ["÷", "x", "-", "+", "=", "^"].contains(buttonText);
                bool isLeftOperator = ["%", "√", "sin", "cos", "tan", "(", ")", "π"].contains(buttonText);
                bool isEqual = buttonText == "=";
                bool isSpecial = buttonText == "ANS";

                return CalculatorButton(
                  text: buttonText,
                  isOperator: isOperator,
                  isEqual: isEqual,
                  isLeftOperator: isLeftOperator,
                  isSpecial: isSpecial,
                  onTap: () {
                    if (buttonText == "C") {
                      controller.clearInputAndOutput();
                    } else if (buttonText == "DEL") {
                      controller.deleteBtnAction();
                    } else if (buttonText == "=") {
                      controller.equalPressed();
                    } else if (buttonText == "%") {
                      controller.calculatePercentage();
                    } else {
                      controller.onBtnTapped(buttonText);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget outputSection(
      ThemeController themeController, CalculateController controller) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // History text
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Text(
              controller.history,
              style: GoogleFonts.ubuntu(
                color: themeController.isDark
                    ? DarkColors.historyTextColor
                    : LightColors.historyTextColor,
                fontSize: 24,
              ),
              textAlign: TextAlign.end,
            ),
          ),
          const SizedBox(height: 10),
          // User input
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Text(
              controller.userInput,
              style: GoogleFonts.ubuntu(
                color: themeController.isDark
                    ? DarkColors.textColor
                    : LightColors.textColor,
                fontSize: 36,
              ),
              textAlign: TextAlign.end,
            ),
          ),
          const SizedBox(height: 20),
          // Result output
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Text(
              controller.userOutput,
              style: GoogleFonts.ubuntu(
                fontWeight: FontWeight.bold,
                color: themeController.isDark
                    ? DarkColors.textColor
                    : LightColors.textColor,
                fontSize: 48,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}