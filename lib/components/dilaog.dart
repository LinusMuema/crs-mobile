import 'package:crs/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void fadeInDialog(Widget child) {
  var color = black.withOpacity(0.5);
  const duration = Duration(milliseconds: 300);

  showGeneralDialog(
    barrierLabel: '',
    barrierColor: color,
    context: Get.context!,
    barrierDismissible: true,
    transitionDuration: duration,
    pageBuilder: (context, a1, a2) => child,
    transitionBuilder: (context, a1, a2, widget) {
      return Transform.scale(
        scale: a1.value,
        child: Opacity(opacity: a1.value, child: child),
      );
    },
  );
}
