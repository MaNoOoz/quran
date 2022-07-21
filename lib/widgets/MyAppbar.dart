import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quran_app/widgets/search.dart';

import '../configs/Constants.dart';
import '../controller/HomeController.dart';
import '../models/Qaree.dart';
import '../views/SpinKit.dart';

class MyAppbar extends StatelessWidget {
  const MyAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      //         // statusBarColor: Constants.mainColor,
      //         /* set Status bar color in Android devices. */
      //         statusBarIconBrightness: Brightness.dark,
      //         /* set Status bar icons color in Android devices.*/
      //         statusBarBrightness: Brightness.dark
    ));

    return SafeArea(child: GetBuilder<HomeController>(builder: (controller) {
      return AppBar(
        // backgroundColor: Colors.white70,
        // backgroundColor: Constants.mainColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          "القرآن الكريم",
          // style: Constants.mainColor,

          style: TextStyle(fontFamily: "Noor"),
        ),
        // centerTitle: true,
        actions: [
          /// search =============
          IconButton(
              onPressed: () async {
                await showSearch(context: context, delegate: SearchSura());
              },
              tooltip: "بحث",
              icon: const Icon(
                Icons.search,
                // color: Colors.black,
              )),
          IconButton(
            onPressed: () async {
              Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
              // Logger().e(" DARKK??  ${Get.isDarkMode}");
              // controller.update();
            },
            tooltip: "الوضع الليلي",
            icon: Get.isDarkMode ? Icon(Icons.dark_mode) : Icon(Icons.lightbulb),
          ),

          /// Qaree =============
          IconButton(
              tooltip: "تغير القارئ",
              onPressed: () {
                Get.defaultDialog(
                  barrierDismissible: true,
                  confirm: ElevatedButton(
                    onPressed: () async {
                      // await controller.storage.write();
                      // controller.storage.read();

                      await controller.getAllDATA();
                      Get.back();
                    },
                    child: Text("حفظ"),
                    style: Constants.mainStyleButton,
                  ),
                  title: "إختيار القارئ ",
                  // backgroundColor: Colors.green,
                  content: buildFutureBuilder(),
                );
              },
              icon: const Icon(
                Icons.record_voice_over,
                // color: Colors.black,
              )),
        ],
      );
    }));
  }

  Widget buildFutureBuilder() {
    var controller = Get.find<HomeController>();
    List<Qaree> testListQaree = controller.qareeList;
    // Logger().d("getAllQaree ${testListQaree.length}");
    List<bool> selections = List.generate(testListQaree.length, (index) => false);

    var textWidgets = testListQaree
        .map((Qaree e) => ListTile(
              title: Text(
                e.name,
                style: const TextStyle(fontFamily: "Noor", fontSize: 33),
              ),
              subtitle: Text(
                "${e.englishName} ",
                maxLines: 2,
              ),
            ))
        .toList();

    return Obx(() {
      if (controller.isLoading.value == true) {
        return Container(
          // color: Colors.red,
          margin: const EdgeInsets.all(8.0),
          width: 50.0,
          height: 50.0,
          child: Center(
              child: SpinKit(
            color: Colors.red,
          )),
        );
      } else {
        return buildContainer(testListQaree, selections, textWidgets);
      }
    });
  }

  Widget buildContainer(List<Qaree> testListQaree, List<bool> _selections, List<ListTile> textWidgets) {
    return Container(
      height: 300,
      width: 300,
      child: ListView(
        shrinkWrap: true,
        children: [
          GetBuilder<HomeController>(builder: (controller) {
            return ToggleButtons(
                onPressed: (index) async {
                  var e = testListQaree[index];
                  controller.buttonIndex = index;
                  controller.changeQaree(index, _selections);
                  controller.selectedQareeId = e.identifier;
                  controller.selectedQareeName = e.name;
                  // Logger().d("e:: ${controller.selectedQareeName}");
                  // Logger().e("e:: ${controller.selectedQareeId}");

                  // Logger().d("qareeName2 ${controller.selectedQareeName}");
                },
                fillColor: Colors.green,
                disabledColor: Colors.grey,
                direction: Axis.vertical,
                verticalDirection: VerticalDirection.down,
                isSelected: _selections,
                children: textWidgets);
          }),
        ],
      ),
    );
  }
}
