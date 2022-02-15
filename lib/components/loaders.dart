import 'package:crs/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget threeBounce({Color color = white, double size = 25}) {
  return SpinKitThreeBounce(color: color, size: size);
}

Widget pulse({Color color = white, double size = 25}) {
  return SpinKitPulse(color: color, size: size);
}
