import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:quran_app/routes/app_routes.dart';

class routingMiddileWare extends GetMiddleware {
  bool isLogged = false;

  @override
  // TODO: implement priority
  int? get priority => 2;

  @override
  RouteSettings? redirect(String? route) {
    if (isLogged) {
      return RouteSettings(name: AppRoutes.HOME);
    }
  }

  @override
  void onPageDispose() {
    return super.onPageDispose();
  }

  @override
  Widget onPageBuilt(Widget page) {
    return super.onPageBuilt(page);
  }

  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    return super.onPageBuildStart(page);
  }

  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    return super.onBindingsStart(bindings);
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    return super.onPageCalled(page);
  }
}
