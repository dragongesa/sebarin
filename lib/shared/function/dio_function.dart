import 'package:dio/dio.dart';
import 'package:sebarin/utils/constants.dart';

initiateDio() {
  var dio = Dio();
  dio.options.baseUrl = Constants.baseUrl;
  dio.options.connectTimeout = 5000;
  dio.options.receiveTimeout = 3000;
  return dio;
}
