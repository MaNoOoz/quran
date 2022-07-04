import 'package:get/get.dart';
import 'package:quran_app/controller/HomeController.dart';

import '../data/LocalStorage.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<LocalStorage>(() => LocalStorage());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
