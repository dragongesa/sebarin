import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as sm;
import 'package:sebarin/shared/function/dio_function.dart';

class SearchRequest {
  static querySearch(String query) async {
    Response response;
    final url = '/api/events/search.php?q=$query';
    Dio dio = initiateDio();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (e, handler) {
          return handler.next(e);
        },
        onError: (e, handler) {
          sm.Get.snackbar("Error", "${e.message}",
              snackPosition: sm.SnackPosition.BOTTOM,
              backgroundColor: Colors.red.withOpacity(.5),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15));
          return handler.resolve(Response(
              requestOptions: RequestOptions(path: url),
              data: {'status': 010, 'message': "connection timed out"}));
        },
      ),
    );
    response = await dio.get(url);
    return response;
  }
}
