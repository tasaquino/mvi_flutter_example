import 'package:dio/dio.dart';

class NetworkingConfig {
  static final NetworkingConfig _singleton = NetworkingConfig._init();

  Dio dio;

  factory NetworkingConfig() {
    return _singleton;
  }

  NetworkingConfig._init() {
    dio = Dio();
    _addInterceptors(dio);
  }

  static _addInterceptors(Dio dio) {
    dio.interceptors.add(LogInterceptor());
  }
}
