import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quran_app/controller/HomeController.dart';

import '../configs/Constants.dart';
import '../models/Data1.dart';
import '../widgets/Item.dart';
import '../widgets/MyAppbar.dart';
import 'SpinKit.dart';
import 'SuraView.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        // statusBarColor: Colors.black,
        /* set Status bar color in Android devices. */
        statusBarIconBrightness: Brightness.dark,
        /* set Status bar icons color in Android devices.*/
        statusBarBrightness: Brightness.dark));
    /* set Status bar icon color in iOS. */
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // var savedData = Get.find<HomeController>().data.read(Constants.QAREEID);
            // LocalStorage storage = LocalStorage();
            // var savedData2 = storage.remove();
            // Logger().d("FFFF  $savedData");
          },
        ),
        appBar: const PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: EdgeInsets.all(1.0),
              child: const MyAppbar(),
              // child: AppBar(),
            )),
        body: _buildBody());
  }

  Widget _buildBody() {
    var controller = Get.put(HomeController());
    // var controller = Get.find<HomeController>();

    return Obx(() {
      if (controller.isLoading.value == true) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SpinKit(
                color: Colors.red,
              ),
            ),
            Text(Constants.LoadingMessage),
          ],
        );
      } else {
        return ListView.separated(
          separatorBuilder: (context, index) => const Divider(
              // color: Color(0xffee8f8b),
              ),

          shrinkWrap: true,
          // itemCount: controller.suraList.length,
          itemCount: controller.suraList2.length,
          itemBuilder: (ctx, i) {
            Surah sura = controller.suraList2[i];
            return MyItem(
                sura: sura,
                onTap: () async {
                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                    await Get.to(() => SuraView(), arguments: sura);
                    // Get.toNamed("/suraView", arguments: sura);
                  });
                  // Get.put<HomeController>(HomeController());
                });
          },
        );
      }
    });
  }
}
