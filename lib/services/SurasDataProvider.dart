import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:quran_app/models/Data1.dart';

import '../models/Qaree.dart';

class SurasDataProvider {
  final fileName = "suras";

  Future<List<Surah>> getData(String qareeId) async {
    var base = await rootBundle.loadString('assets/jsons/suras$qareeId.json');

    return await _loadFromLocal(qareeId);
  }

  Future<List<Qaree>> getAllQaree() async {
    var base = await rootBundle.loadString('assets/jsons/qaree.json');
    // Logger().e("getAllQareeq ${base.toString()} \n ");

    final data = await json.decode(base);

    // final Map<String, dynamic> raw = resp.data['data'];
    final List data2 = data['data'];
    // Logger().d("RES ${data} \n ");

    // final List data = raw['surahs'];
    final List<Qaree> chapters = List.generate(
      data2.length,
      (index) => Qaree.fromJson(data2[index]),
    );
    return chapters;
  }

  Future<List<Surah>> _loadFromLocal(qareeId) async {
    // Logger().d("_loadFromLocal2 ${_loadFromLocal}");

    var load = await rootBundle.loadString('assets/jsons/suras$qareeId.json');

    final data = await json.decode(load);
    // Logger().d("data  json.decode ${data}");

    final Map<String, dynamic> raw = data['data'];
    // Logger().d("raw  raw ${raw}");

    final List data2 = raw['surahs'];
    // Logger().d("data2: \n  ${data2}");

    final List<Surah> chapters = List.generate(
      data2.length,
      (index) => Surah.fromJson(data2[index]),
    );

    // Logger().d("chapters List :  ${chapters.length}");

    return chapters;
  }
}

/// ======================================================================
