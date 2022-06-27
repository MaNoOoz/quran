import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quran_app/controller/HomeController.dart';

import '../models/Data1.dart';
import '../widgets/Item.dart';
import '../widgets/MyAppbar.dart';
import 'SuraView.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.black,
        /* set Status bar color in Android devices. */
        statusBarIconBrightness: Brightness.dark,
        /* set Status bar icons color in Android devices.*/
        statusBarBrightness: Brightness.dark));
    /* set Status bar icon color in iOS. */
    return Scaffold(
      floatingActionButton: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return FloatingActionButton(
            onPressed: () async {
              // await controller.saveToDevice();
              // await controller.readFromDevice();
              await controller.getAllSurah();
              // await controller.getAllSurah();
              // controller.isLoading.value = !controller.isLoading.value;
              // print(controller.isLoading.value);
              // await controller.read(controller.selectedQareeName);
              // var savedData = controller.data.read(Constants.QAREEID);
              // print(savedData);
              // print((controller.read(controller.selectedQareeName)));
            },
            child: IconButton(
              onPressed: () async => await controller.getAllSurah(),
              icon: Icon(Icons.download),
            ),
          );
        },
      ),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: EdgeInsets.all(1.0),
            child: MyAppbar(),
            // child: AppBar(),
          )),
      body: Builder(builder: (context) {
        return GetBuilder<HomeController>(builder: (logic) {
          return _buildBody(logic);
        });
      }),
    );
  }

  Widget _buildBody(HomeController controller) {
    return Obx(() {
      if (controller.isLoading.value == true) {
        return const Center(child: CircularProgressIndicator());
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
                  // Get.put<HomeController>(HomeController());
                  Get.to(() => SuraView(), arguments: sura);
                });
          },
        );
      }
    });
  }
}
