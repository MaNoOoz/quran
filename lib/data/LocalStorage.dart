import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

import '../configs/Constants.dart';
import '../controller/HomeController.dart';

class LocalStorage {
  GetStorage box = GetStorage('App');
  GetStorage box2 = GetStorage('Data');

  int _first = 0;

  int get checkVisit => _first;

  bool init() {
    int? visit = box.read('visit');

    if (visit == null || visit == 0) {
      box.write('visit', 1);

      return true;
    }
    return false;
  }

  void remove() {
    int? visit = box.read('visit');
    Logger().e("remove : $visit");

    if (box.hasData("visit")) {
      box.erase();
    }
  }

  read() async {
    var qareeFromMem = await box2.read(Constants.QAREEID);

    try {
      if (qareeFromMem == null) {
        Logger().d("qareeFromMem is null :$qareeFromMem");
      } else {
        Logger().d("qareeFromMem :$qareeFromMem");
      }
    } catch (e) {
      Logger().d("onInit :$e");
    }
  }

  write() async {
    await box2.write(Constants.QAREEID, Get.find<HomeController>().selectedQareeId);
  }
}
