import 'package:flutter/material.dart';

import '../data/LocalStorage.dart';
import '../views/HomeView.dart';
import '../views/splash.dart';

class StarterView extends StatefulWidget {
  @override
  _StarterViewState createState() => _StarterViewState();
}

class _StarterViewState extends State<StarterView> {
  final LocalStorage storage = LocalStorage();
  late bool isNew;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initValues();
  }

  @override
  Widget build(BuildContext context) {
    return isNew ? SplashScren() : HomeView();
  }

  void initValues() async {
    isNew = storage.init();
    // Logger().e("$isNew");
  }
}
