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
        primary: black,
        onPrimary: white,
        minimumSize: Size(double.infinity, Get.height * .06),
        shape: const RoundedRectangleBorder(borderRadius: fullRadius),
      ),
    );
  }

  TextSelectionThemeData textSelectionTheme = const TextSelectionThemeData(
    cursorColor: black,
    selectionColor: grey,
    selectionHandleColor: black,
  );

  InputDecorationTheme inputDecorationTheme(InputDecorationTheme base) {
    return base.copyWith(
      contentPadding: largeInsets,
      border: getInputBorder(color: black),
      errorBorder: getInputBorder(color: red),
      enabledBorder: getInputBorder(color: grey),
      focusedBorder: getInputBorder(color: black),
      floatingLabelBehavior: FloatingLabelBehavior.never,
    );
  }

  FloatingActionButtonThemeData fabTheme = const FloatingActionButtonThemeData(
    backgroundColor: black,
  );

  ColorScheme colorScheme = ColorScheme.fromSwatch().copyWith(
    error: red,
    primary: black,
    onSurface: black,
  );

  return base.copyWith(
    colorScheme: colorScheme,
    floatingActionButtonTheme: fabTheme,
    textTheme: textTheme(base.textTheme),
    textSelectionTheme: textSelectionTheme,
    elevatedButtonTheme: buttonThemeData(),
    inputDecorationTheme: inputDecorationTheme(base.inputDecorationTheme),
  );
}
