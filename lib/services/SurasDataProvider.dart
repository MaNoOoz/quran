import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran_app/models/Data1.dart';

import '../models/Qaree.dart';

class SurasDataProvider {
  static Dio ins = Dio();
  final fileName = "suras.json";

  Future<List<Surah>> getData(String qareeId) async {
    var baseUrl = 'http://api.alquran.cloud/v1/quran/${qareeId}';
    // var baseUrl = 'http://api.alquran.cloud/v1/quran/${qareeName}';

    var file = await _localFile;
    Logger().d("from ${file.toString()} \n ");

    if (file.existsSync()) {
      return await _loadFromLocal();

      //
      // Logger().d("from ${file.toString()} \n ");
      // final data = file.readAsStringSync();
      // final res = json.decode(data);
      // Logger().d("data  json.decode ${data}");
      //
      // final Map<String, dynamic> raw = res['data'];
      // Logger().d("raw  raw ${raw}");
      //
      // final List data2 = raw['surahs'];
      //
      // final List<Surah> chapters = List.generate(
      //   data.length,
      //   (index) => Surah.fromJson(data2[index]),
      // );
      // Logger().d("${chapters.length}");
      // return chapters;

    } else {
      return await _loadFromRemote(baseUrl: baseUrl);
    }
  }


  Future<List<Qaree>> getAllQareeFromApi() async {
    try {
      final resp = await ins.get(
        'http://api.alquran.cloud/v1/edition?format=audio&language=ar&type=versebyverse',
      );

      // final Map<String, dynamic> raw = resp.data['data'];
      final List data = resp.data['data'];
      // Logger().d("RES ${data} \n ");

      // final List data = raw['surahs'];
      final List<Qaree> chapters = List.generate(
        data.length,
        (index) => Qaree.fromJson(data[index]),
      );
      return chapters;
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        throw Exception('Problem with internet connection');
      } else {
        throw Exception('Problem on our side, Please try again');
      }
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }

  Future<void> downloadQuran(qareeName) async {
    var path = 'http://api.alquran.cloud/v1/quran/${qareeName}';

    var response = await http.get(Uri.parse(path));
    if (response.statusCode == 200) {
      var body = response.body;
      Logger().d(response.runtimeType);

      String dir = await _localPath;
      File file = File('$dir/$fileName');
      Logger().d(file.path);

      file.writeAsStringSync(body, flush: true, mode: FileMode.write);

      final data = file.readAsStringSync();
      final res = json.decode(data);
      Logger().d(res);
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$fileName');
    // return path
  }

  Future<List<Surah>> _loadFromLocal() async {
    Logger().d("_loadFromLocal ${_loadFromLocal}");

    var load = await _localFile;
    // Logger().d("_localFile ${load.path}");

    // Read the file
    final contents = load.readAsStringSync();
    // Logger().d("contents ${contents.length}");

    final data = await json.decode(contents);
    // Logger().d("data  json.decode ${data}");

    final Map<String, dynamic> raw = data['data'];
    // Logger().d("raw  raw ${raw}");

    final List data2 = raw['surahs'];
    // Logger().d("data2: \n  ${data2}");

    final List<Surah> chapters = List.generate(
      data2.length,
      (index) => Surah.fromJson(data2[index]),
    );

    Logger().d("chapters List :  ${chapters.length}");

    return chapters;
  }

  Future<List<Surah>> _loadFromRemote({required String baseUrl}) async {
    final resp = await ins.get(
      baseUrl,
    );

    Logger().d("$baseUrl ${resp.statusCode}");

    if (resp.statusCode == 200) {
      final Map<String, dynamic> data = resp.data['data'];
      final List raw = data['surahs'];
      Logger().d("_loadFromRemote : \n ${raw.length}");

      final List<Surah> chapters = List.generate(
        raw.length,
        (index) => Surah.fromJson(raw[index]),
      );

      return chapters;
    } else {
      print("Failed to load");
      throw Exception("Failed  to Load Post");
    }
  }

  /// ======================================================================

}
