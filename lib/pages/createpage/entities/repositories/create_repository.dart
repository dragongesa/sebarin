import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as sm;
import 'package:sebarin/shared/function/dio_function.dart';

class CreateRequest {
  static createEvent(FormData data) async {
    Response response;
    final url = '/api/events/create.php';
    Dio dio = initiateDio();
    dio.interceptors.add(InterceptorsWrapper(
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
      onRequest: (options, handler) {
        return handler.next(options);
      },
    ));
    response = await dio.post(url, data: data);
    return response;
  }

  static getUploadedEvent(int id) async {
    Response response;
    final url = "/api/events/show.php?id=$id";
    Dio dio = initiateDio();
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

  static getCategories() async {
    Response response;
    final url = "/api/categories/index.php";
    Dio dio = initiateDio();
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
