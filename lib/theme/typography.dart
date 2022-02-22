import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

BuildContext context = Get.context!;
TextTheme textTheme = Theme.of(context).textTheme;

TextStyle body1 = GoogleFonts.nunito(textStyle: textTheme.bodyText1);
TextStyle body2 = body1.copyWith(color: white);
TextStyle body3 = body1.copyWith(color: grey);
TextStyle body4 = body1.copyWith(color: green);
TextStyle body5 = body1.copyWith(color: red);

TextStyle caption1 = body1.copyWith(fontSize: 12);
TextStyle caption2 = caption1.copyWith(color: white);
TextStyle caption3 = caption1.copyWith(color: grey);

TextStyle heading1 = GoogleFonts.nunito(textStyle: textTheme.headline4);
TextStyle heading2 = heading1.copyWith(color: white);
TextStyle heading3 = heading1.copyWith(color: grey);
TextStyle heading4 = heading1.copyWith(color: green);
