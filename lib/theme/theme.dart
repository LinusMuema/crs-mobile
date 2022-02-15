import 'package:crs/theme/colors.dart';
import 'package:crs/theme/dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

ThemeData lightTheme() {
  final ThemeData base = ThemeData.light();

  TextTheme textTheme(TextTheme base) {
    return base.copyWith(
      headline4: base.headline4!.copyWith(
        color: black,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      bodyText1: base.bodyText1!.copyWith(color: black),
    );
  }

  ElevatedButtonThemeData buttonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        primary: white,
        onPrimary: black,
        minimumSize: Size(double.infinity, Get.height * .06),
        shape: const RoundedRectangleBorder(borderRadius: smallRadius),
      ),
    );
  }

  TextSelectionThemeData textSelectionTheme = const TextSelectionThemeData(
    cursorColor: white,
  );

  InputDecorationTheme inputDecorationTheme(InputDecorationTheme base) {
    return base.copyWith(
      filled: true,
      errorBorder: inputBorder,
      enabledBorder: inputBorder,
      focusedBorder: inputBorder,
      fillColor: grey.withOpacity(.2),
      focusColor: grey.withOpacity(.2),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      errorStyle: const TextStyle(color: red, fontFamily: 'Poppins'),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
    );
  }

  return base.copyWith(
    errorColor: red,
    primaryColor: white,
    textTheme: textTheme(base.textTheme),
    textSelectionTheme: textSelectionTheme,
    elevatedButtonTheme: buttonThemeData(),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: white,
      onSurface: black,
    ),
    inputDecorationTheme: inputDecorationTheme(base.inputDecorationTheme),
  );
}
