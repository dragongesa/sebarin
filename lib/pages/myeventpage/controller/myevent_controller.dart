import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sebarin/pages/homepage/entities/models/newpost_model.dart';
import 'package:sebarin/pages/myeventpage/entities/repositories/myevent_repository.dart';
import 'package:sebarin/shared/models/events.dart';

class MyEventController extends GetxController {
  final isConnecting = false.obs;
  final page = 1;
  List<Event> feed = [];
  int? totalPages;
  int? nextPage;
  int? currentPage;
  bool isLastPage = false;
  bool isNotFound = false;
  @override
  void onInit() {
    getMyEvent();
    super.onInit();
  }

  getMyEvent([int? p]) async {
    isConnecting.toggle();
    if (p != null) feed.clear();
    final response = await MyEventRequest.getMyEvent(p ?? nextPage ?? page);
    Map<String, dynamic> rawData = response.data;
    isLastPage = rawData['currentPage'] == rawData['totalPages'];
    print("is last: $isLastPage");

    var toModel = jsonEncode(rawData);
    print(toModel);
    if (rawData['status'] == 200) {
      final data = newPostModelFromJson(toModel);
      totalPages = data.totalPages;
      nextPage = data.nextPage;
      feed.addAll(data.data);
    } else if (rawData['status'] == 404) {
      isNotFound = true;
    } else {
      Get.snackbar("Error", "${rawData['message']}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(.5),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15));
      print(rawData['status']);
    }
    isConnecting.toggle();
    update(['feed']);
  }
}
