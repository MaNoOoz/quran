import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:quran_app/widgets/search.dart';

import '../configs/Constants.dart';
import '../controller/HomeController.dart';
import '../models/Qaree.dart';

class MyAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.white,
            /* set Status bar color in Android devices. */
            statusBarIconBrightness: Brightness.dark,
            /* set Status bar icons color in Android devices.*/
            statusBarBrightness:
                Brightness.dark) /* set Status bar icon color in iOS. */
        );

    return SafeArea(child: GetBuilder<HomeController>(builder: (controller) {
      return AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
        title: const Text(
          "القرآن الكريم",
          // style: Constants.mainColor,

          style: TextStyle(color: Colors.black, fontFamily: "Noor"),
        ),
        centerTitle: true,
        actions: [
          /// search =============
          IconButton(
              onPressed: () async {
                await showSearch(context: context, delegate: SearchSura());
              },
              tooltip: "بحث",
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              )),

          /// Qaree =============
          IconButton(
              tooltip: "تغير القارئ",
              onPressed: () {
                Get.defaultDialog(
                  barrierDismissible: true,
                  confirm: ElevatedButton(
                      onPressed: () async {
                        controller.data.write(
                            Constants.QAREEID, controller.selectedQareeId);
                        Get.back();
                        await controller.getAllSurah();
                      },
                      child: const Text("save")),
                  title: "إختيار القارئ ",
                  content: buildFutureBuilder(),
                );
              },
              icon: const Icon(
                Icons.record_voice_over,
                color: Colors.black,
              )),
        ],
      );
    }));
  }

  Widget buildFutureBuilder() {
    // todo fix bug --> qaree list = 0

    var controller = Get.find<HomeController>();
    List<Qaree> testListQaree = controller.qareeList;
    Logger().d("getAllQaree ${testListQaree.length}");
    List<bool> _selections =
        List.generate(testListQaree.length, (index) => false);

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
        return Center(child: CircularProgressIndicator());
      } else {
        return buildContainer(testListQaree, _selections, textWidgets);
      }
    });
  }

  Widget buildContainer(List<Qaree> testListQaree, List<bool> _selections,
      List<ListTile> textWidgets) {
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
                  Logger().d("e:: ${controller.selectedQareeName}");

                  // Logger().d("qareeName2 ${controller.selectedQareeName}");
                },
                fillColor: Colors.blue,
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
