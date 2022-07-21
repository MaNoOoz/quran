import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran_app/routes/app_pages.dart';
import 'package:quran_app/routes/app_routes.dart';

import 'Bindings/Bindings.dart';
import 'configs/Constants.dart';

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
    return GetMaterialApp(
      initialRoute: AppRoutes.HOME,
      initialBinding: InitialBinding(),
      getPages: AppPages.list,
      debugShowCheckedModeBanner: false,
      theme: Constants.lightTheme,
      themeMode: ThemeMode.system,
      enableLog: true,
    );
  }
}
