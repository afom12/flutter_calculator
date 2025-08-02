import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math';

class CalculateController extends GetxController {
  var userInput = "";
  var userOutput = "0";
  var history = "";
  bool isRadians = false;

  String _previousAnswer = "0";

  equalPressed() {
    if (userInput.isEmpty) return;

    try {
      history = userInput;
      String userInputFC = userInput;
      userInputFC = userInputFC.replaceAll("x", "*");
      userInputFC = userInputFC.replaceAll("÷", "/");
      userInputFC = userInputFC.replaceAll("π", "pi");

      // Convert trig functions to radians if
      if (!isRadians) {
        userInputFC = convertTrigToRadians(userInputFC);
      }

      Parser p = Parser();
      Expression exp = p.parse(userInputFC);
      ContextModel ctx = ContextModel();

      double eval = exp.evaluate(EvaluationType.REAL, ctx);

      // Format output to remove trailing .0 if it's an integer
      if (eval % 1 == 0) {
        userOutput = eval.toInt().toString();
      } else {
        userOutput = eval.toStringAsFixed(6)
          .replaceAll(RegExp(r"0+$"), "")
          .replaceAll(RegExp(r"\.$"), "");
      }

      _previousAnswer = userOutput;
      update();
    } catch (e) {
      userOutput = "Error";
      update();
    }
  }

  /// Helper: Convert trigonometric expressions to radians
  String convertTrigToRadians(String expression) {
    final pattern = RegExp(r'(sin|cos|tan)\(([^)]+)\)');
    return expression.replaceAllMapped(pattern, (match) {
      final func = match.group(1)!;
      final angle = match.group(2)!;
      return "$func(($angle)*pi/180)";
    });
  }

  /// Clear Button Pressed Func
  clearInputAndOutput() {
    userInput = "";
    userOutput = "0";
    history = "";
    update();
  }

  /// Delete Button Pressed Func
  deleteBtnAction() {
    if (userInput.isNotEmpty) {
      userInput = userInput.substring(0, userInput.length - 1);
      update();
    }
  }

  /// on Button Tapped
  onBtnTapped(String buttonText) {
    if (buttonText == "ANS") {
      userInput += _previousAnswer;
    } else {
      userInput += buttonText;
    }
    update();
  }

  /// Toggle between radians and degrees
  toggleAngleMode() {
    isRadians = !isRadians;
    update();
  }

  /// Calculate percentage
  calculatePercentage() {
    if (userInput.isEmpty) return;

    try {
      String expression = userInput;
      expression = expression.replaceAll("%", "/100");

      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel ctx = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, ctx);

      userOutput = eval.toString();
      userInput = eval.toString();
      update();
    } catch (e) {
      userOutput = "Error";
      update();
    }
  }
}
