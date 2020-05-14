import 'package:covid19tracker/core/models/all_models.dart';
import 'package:dio/dio.dart';

class Api {
  static String baseUrl = 'https://api.covid19api.com';
  static String newsApiKey = '767a38fb75e34d04914246027f2c3782';
  static BaseOptions _baseOptions = BaseOptions(
    baseUrl: baseUrl,
  );

  Dio dio = Dio(_baseOptions);

  Future getSummary(String target) async {
    try {
      Response response = await dio.get('/summary');
      return Result.success('Summary fetched successfully', response.data);
    } on DioError catch (e) {
      print(e.response.data);
      return Result.fromError(e);
    }
  }

  Future getCountries() async {
    try {
      Response response = await dio.get('/countries');

      List<Country> countries =
          List<Country>.from(response.data.map((x) => Country.fromJson(x)));
      countries.sort((a, b) => a.country.compareTo(b.country));

      return Result.success('Countries fetched successfully', countries);
    } on DioError catch (e) {
      print(e.response.data);
      return Result.fromError(e);
    }
  }

  Future getDayOneReport(String country, String status) async {
    try {
      Response response =
          await dio.get('/dayone/country/$country/status/$status');

      List<DailyReport> dailyReports = List<DailyReport>.from(
          response.data.map((x) => DailyReport.fromJson(x)));

      return Result.success(
          'Reports since day-one fetched successfully', dailyReports);
    } on DioError catch (e) {
      print(e.response.data);
      return Result.fromError(e);
    }
  }
}
