import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:quran_app/routes/app_pages.dart';
import 'package:quran_app/views/HomeView.dart';
import 'package:quran_app/views/splash.dart';

import 'configs/Constants.dart';
import 'data/LocalStorage.dart';

// flutter build web --web-renderer html --csp

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await GetStorage.init('App');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LocalStorage storage = LocalStorage();
    bool isNew = storage.init();

    Logger().e("$isNew");

    return GetMaterialApp(
        // initialRoute: AppRoutes.HOME,
        // initialBinding: HomeBinding(),
        getPages: AppPages.list,
        debugShowCheckedModeBanner: false,
        theme: Constants.lightTheme,
        themeMode: ThemeMode.light,
        enableLog: true,
        home: isNew ? SplashScren() : HomeView());
  }
}
