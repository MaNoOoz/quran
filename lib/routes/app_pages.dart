import 'package:get/get.dart';
import 'package:quran_app/Bindings/Bindings.dart';
import 'package:quran_app/views/HomeView.dart';

import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
