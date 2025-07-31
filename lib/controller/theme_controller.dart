import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_calculator/utils/colors.dart';

class ThemeController extends GetxController {
  bool isDark = true;
  final switcherController = ValueNotifier<bool>(false);

  lightTheme() {
    isDark = false;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: LightColors.sheetBgColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    update();
  }

  darkTheme() {
    isDark = true;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: DarkColors.sheetBgColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    update();
  }

  @override
  void onInit() {
    // Initialize based on system theme
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    isDark = brightness == Brightness.dark;
    switcherController.value = !isDark;
    
    switcherController.addListener(() {
      if (switcherController.value) {
        lightTheme();
      } else {
        darkTheme();
      }
    });
    super.onInit();
  }
}