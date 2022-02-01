import 'package:crs/routes/routes.dart';
import 'package:crs/screens/auth/auth.binding.dart';
import 'package:crs/screens/auth/auth.dart';
import 'package:crs/screens/splash/splash.binding.dart';
import 'package:crs/screens/splash/splash.dart';
import 'package:get/get.dart';

class CrsPages {
  static final pages = [
    GetPage(
      name: Routes.SPLASH,
      binding: SplashBinding(),
      page: () => const Splash(),
    ),
    GetPage(
      name: Routes.AUTH,
      binding: AuthBinding(),
      page: () => const Auth(),
    )
  ];
}
