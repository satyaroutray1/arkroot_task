import 'package:dio/dio.dart';

class NetWorkHelper {
  Dio _dio;
  String url = "https://api.nasa.gov/planetary/apod?api_key=aWPhODExHc5j48m59viPzCysv1jkoaN7ID2dchPw&date=";

  NetWorkHelper() {
    _dio = Dio(BaseOptions(baseUrl: url));
  }

  Future<Response> fetchData(String date) async {
    Response response;
    try {
      response = await _dio.get(date);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
    return response;
  }
}
