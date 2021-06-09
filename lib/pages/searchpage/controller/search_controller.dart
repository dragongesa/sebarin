import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sebarin/pages/searchpage/entities/models/searchresult_model.dart';
import 'package:sebarin/pages/searchpage/entities/repositories/search_repository.dart';

class SearchController extends GetxController {
  TextEditingController? textfield;
  final isConnecting = false.obs;

  @override
  void onInit() {
    textfield = new TextEditingController(text: Get.parameters['query'] ?? "");
    if (Get.parameters['query'] != null) search();
    super.onInit();
  }

  @override
  void onClose() {
    textfield!.dispose();
    super.onClose();
  }

  search() async {
    isConnecting.toggle();
    final response = await SearchRequest.querySearch(textfield!.text);
    Map<String, dynamic> rawData = response.data;
    isConnecting.toggle();
    print(rawData['status']);
    if (rawData['status'] == "200") {
      final model = searchResultModelFromJson(jsonEncode(response.data));
      Get.toNamed('/results',
          arguments: {'query': textfield!.text, 'data': model});
    } else {
      Fluttertoast.cancel();
      Fluttertoast.showToast(msg: "event ${textfield!.text} tidak ditemukan");
    }
  }
}
