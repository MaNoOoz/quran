import 'package:get_storage/get_storage.dart';

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
    // Logger().e("remove : $visit");

    if (box.hasData("visit")) {
      box.erase();
    }
  }

  // Future<String> read() async {
  //   String qareeFromMem = await box2.read(Constants.QAREEID);
  //   Logger().d("start:  qareeFromMem :$qareeFromMem");
  //
  //   try {
  //     if (qareeFromMem == null) {
  //       Logger().d("if null : qareeFromMem is null :$qareeFromMem");
  //     } else {
  //       Logger().d("else : qareeFromMem :$qareeFromMem");
  //     }
  //   } catch (e) {
  //     Logger().d("onInit :$e");
  //   }
  //   return qareeFromMem;
  // }

  // write() async {
  //   var c = Get.put(HomeController());
  //   await box2.writeIfNull(Constants.QAREEID, c.selectedQareeId);
  // }
}
