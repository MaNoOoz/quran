import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quran_app/configs/Constants.dart';
import 'package:quran_app/views/SpinKit.dart';

import '../configs/assets.dart';
import 'HomeView.dart';

class SplashScren extends StatefulWidget {
  const SplashScren({Key? key}) : super(key: key);

  @override
  State<SplashScren> createState() => _SplashScrenState();
}

class _SplashScrenState extends State<SplashScren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.yellow.shade200,
        width: Get.width,
        child: Column(
          children: [
            Image.asset(
              StaticAssets.logo,
              height: Get.height / 2,
              width: Get.width / 2,
            ),
            Container(
              // color: Colors.red,
              margin: const EdgeInsets.all(8.0),
              width: 50.0,
              height: 50.0,
              child: Center(
                  child: SpinKit(
                color: Colors.green,
              )),
            ),
            Text(
              Constants.LoadingMessage,
              // style: Constants.mainStyle,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    initData();
  }

  void initData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.delayed(const Duration(seconds: 3), () async {
        if (mounted) {
          await Get.to(() => HomeView());
          // Logger().e("initData : .....");
        }
      });
    });
  }
}
