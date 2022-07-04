import 'package:get/get.dart';
import 'package:quran_app/Bindings/Bindings.dart';
import 'package:quran_app/views/HomeView.dart';
import 'package:quran_app/views/SuraView.dart';
import 'package:quran_app/views/splash.dart';

import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashScren(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.SURAVIEW,
      page: () => SuraView(),
      // binding: HomeBinding(),
    ),
  ];
}
