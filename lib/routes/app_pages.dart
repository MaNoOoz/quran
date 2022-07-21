import 'package:get/get.dart';
import 'package:quran_app/views/HomeView.dart';
import 'package:quran_app/views/SuraView.dart';

import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomeView(),
    ),
    GetPage(
      name: AppRoutes.SURAVIEW,
      page: () => SuraView(),
      // binding: HomeBinding(),
    ),
  ];
}
