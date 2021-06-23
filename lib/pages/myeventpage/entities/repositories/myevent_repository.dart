import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as sm;
import 'package:sebarin/shared/function/dio_function.dart';
import 'package:sebarin/shared/function/picker_function.dart';

class MyEventRequest {
  static getMyEvent(int page) async {
    LoginDetails loginDetails = await Picker.getLoginDetails();
    int? userId = loginDetails.userId;
    final url = "/api/events/my.php?page=$page&uid=$userId";
    Response response;
    var dio = initiateDio();
    dio.interceptors.add(InterceptorsWrapper(
      onError: (e, handler) {
        print(e);
        sm.Get.snackbar("Error", "${e.message}",
            snackPosition: sm.SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(.5),
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15));
        return handler.resolve(Response(
            requestOptions: RequestOptions(path: url),
            data: {'status': 010, 'message': "connection timed out"}));
      },
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onResponse: (e, handler) {
        return handler.next(e);
      },
    ));
    response = await dio.get(url);
    return response;
  }
}
