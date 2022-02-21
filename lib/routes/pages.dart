import 'package:crs/routes/routes.dart';
import 'package:crs/screens/auth/auth.binding.dart';
import 'package:crs/screens/auth/auth.dart';
import 'package:crs/screens/auth/auth.middleware.dart';
import 'package:crs/screens/details/details.binding.dart';
import 'package:crs/screens/details/details.dart';
import 'package:crs/screens/navigation/navigation.binding.dart';
import 'package:crs/screens/navigation/navigation.dart';
import 'package:crs/screens/splash/splash.binding.dart';
import 'package:crs/screens/splash/splash.dart';
import 'package:crs/screens/vehicle/vehicle.binding..dart';
import 'package:crs/screens/vehicle/vehicle.dart';
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
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.NAV,
      binding: NavigationBinding(),
      page: () => const Navigation(),
    ),
    GetPage(
      name: Routes.VEHICLE,
      binding: VehicleBinding(),
      page: () => const Vehicle(),
    ),
    GetPage(
      name: Routes.DETAILS,
      binding: DetailsBinding(),
      page: () => const Details(),
    ),
  ];
}
