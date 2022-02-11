import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

BuildContext context = Get.context!;
TextTheme textTheme = Theme.of(context).textTheme;

TextStyle body1 = GoogleFonts.dongle(textStyle: textTheme.bodyText1!);
TextStyle body2 = body1.copyWith(color: grey);
TextStyle body3 = body1.copyWith(color: white);

TextStyle caption = body1.copyWith(fontSize: 12);
TextStyle caption1 = caption.copyWith(color: grey);
TextStyle caption2 = caption.copyWith(color: white);

TextStyle heading = GoogleFonts.dongle(textStyle: textTheme.headline4);
TextStyle heading1 = heading.copyWith(fontSize: 14);
TextStyle heading2 = heading1.copyWith(color: grey);
TextStyle heading3 = heading1.copyWith(color: white);
