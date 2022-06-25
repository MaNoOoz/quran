import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:quran_app/models/Data1.dart';

import '../models/Qaree.dart';

class SurasDataProvider {
  static Dio ins = Dio();

  /// REMOTE
  Future<List<Surah>> getAllSurahFromApi(String qareeName) async {
    var baseUrl = 'http://api.alquran.cloud/v1/quran/${qareeName}';
    // var baseUrl = 'http://api.alquran.cloud/v1/quran/${qareeName}';

    final resp = await ins.get(
      baseUrl,
    );
    Logger().d("$baseUrl ${resp.statusCode}");

    if (resp.statusCode == 200) {
      final Map<String, dynamic> data = resp.data['data'];
      final List raw = data['surahs'];
      Logger().d("getAllSurahFromApi : \n ${raw.length}");
      // final List data = raw['surahs'];
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

  Future<List<dynamic>> getAllSurahFromApi2(String qareeName) async {
    var baseUrl = 'http://api.alquran.cloud/v1/quran/${qareeName}';
    // var baseUrl = 'http://api.alquran.cloud/v1/quran/${qareeName}';

    final resp = await ins.get(
      baseUrl,
    );

    Logger().d("$baseUrl ${resp.statusCode}");

    if (resp.statusCode == 200) {
      final Map<String, dynamic> data = resp.data['data'];
      final List raw = data['surahs'];
      Logger().d("getAllSurahFromApi2 : \n ${raw.length}");

      // // final List data = raw['surahs'];
      // final List<Surah> chapters = List.generate(
      //   raw.length,
      //   (index) => Surah.fromJson(raw[index]),
      // );
      //
      return raw;
    } else {
      print("Failed to load");
      throw Exception("Failed  to Load Post");
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

  /// LOCAL
  /// ======================================================================
// static var httpClient = new HttpClient();

// Future<File> downloadQuran() async {
//   String fileName = "test.json";
//
//   var request = await httpClient.getUrl(Uri.parse(BaseUrl));
//   var response = await request.close();
//   var bytes = await consolidateHttpClientResponseBytes(response);
//   String dir = (await getApplicationDocumentsDirectory()).path;
//   File file = File('$dir/$fileName');
//   await file.writeAsBytes(bytes);
//   Logger().d(file.path);
//
//   return file;
// }

// Future<String> get _localPath async {
//   final directory = await getApplicationDocumentsDirectory();
//
//   return directory.path;
// }

// Future<File> get _localFile async {
//   final path = await _localPath;
//   return File('$path/test.json');
//   // return path
// }

// Future<List<Surah>> LoadFromLocal() async {
//   Logger().d("LoadFromLocal ${LoadFromLocal}");
//
//   var load = await _localFile;
//   Logger().d("_localFile ${load.path}");
//
//   // Read the file
//   final contents = await load.readAsString();
//   Logger().d("contents ${contents.length}");
//
//   final data = await json.decode(contents);
//   Logger().d("data  json.decode ${data}");
//
//   final Map<String, dynamic> raw = data['data'];
//   Logger().d("raw  raw ${raw}");
//
//   final List data2 = raw['surahs'];
//
//   final List<Surah> chapters = List.generate(
//     data.length,
//     (index) => Surah.fromJson(data2[index]),
//   );
//   Logger().d("${chapters.length}");
//   return chapters;
// }

  /// ======================================================================

}
