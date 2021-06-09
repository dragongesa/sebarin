import 'dart:convert';

import 'package:dio/dio.dart' as http;
import 'package:get/get.dart';
import 'package:sebarin/pages/createpage/entities/repositories/create_repository.dart';

import '../entities/models/singleevent_models.dart';

class CreateSuccessController extends GetxController {
  final isConnecting = false.obs;
  SingleEventModel? model;
  @override
  void onInit() {
    getUploadedEvent(int.parse(Get.parameters['id']!));
    super.onInit();
  }

  getUploadedEvent(int id) async {
    isConnecting.toggle();
    http.Response response = await CreateRequest.getUploadedEvent(id);
    if (response.data['status'] == "200")
      model = singleEventModelFromJson(jsonEncode(response.data));
    isConnecting.toggle();
  }

  nextPage() {
    Get.offNamed('/view-event', arguments: {'event': model!.data});
  }
}
