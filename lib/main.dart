import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran_app/Bindings/Bindings.dart';
import 'package:quran_app/routes/app_pages.dart';
import 'package:quran_app/routes/app_routes.dart';
import 'package:quran_app/views/HomeView.dart';

import 'configs/Constants.dart';

// flutter build web --web-renderer html --csp

Future<void> startService() async {
  // await JustAudioBackground.init(
  //   androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
  //   androidNotificationChannelName: 'Audio playback',
  //   androidNotificationOngoing: true,
  // );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await GetStorage.init();
  // await startService();
  //
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoutes.HOME,
      initialBinding: HomeBinding(),
      getPages: AppPages.list,
      debugShowCheckedModeBanner: false,
      theme: Constants.lightTheme,
      themeMode: ThemeMode.light,
      enableLog: true,
      home: HomeView(),
      // smartManagement: SmartManagement.full,
      // defaultTransition: Transition.fadeIn,
    );
  }
}
