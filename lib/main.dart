import 'package:flutter/material.dart';
import 'package:flutter_calculator/bindings/my_bindings.dart';
import 'package:flutter_calculator/screen/main_screen.dart';
import 'package:flutter_calculator/utils/colors.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: MyBindings(),
      title: "Modern Calculator",
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: LightColors.scaffoldBgColor,
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: DarkColors.scaffoldBgColor,
      ),
      themeMode: ThemeMode.system,
      home: MainScreen(),
    );
  }
}