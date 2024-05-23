import 'package:dio/dio.dart';
import 'package:alice/alice.dart';
import 'package:helpers/helpers.dart';

class HttpClient {
  HttpClient(this.appInfo) {
    _dio = Dio();

    if (!appInfo.isProd) {
      final alice = Alice();
      _dio.interceptors.add(alice.getDioInterceptor());
    }
  }

  final AppInfo appInfo;
  late final Dio _dio;

  Future<Object?> get(String url) async {
    try {
      final response = await _dio.get(url);
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  int get interceptorsCount => _dio.interceptors.length;

  void printInterceptors() {
    for (final interceptor in _dio.interceptors) {
      print(interceptor);
    }
  }
}
