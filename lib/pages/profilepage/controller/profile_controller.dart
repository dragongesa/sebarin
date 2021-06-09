import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sebarin/pages/homepage/entities/models/newpost_model.dart';
import 'package:sebarin/shared/function/picker_function.dart';
import 'package:sebarin/shared/models/events.dart';

import '../entities/respositories/event_uploaded_repository.dart';

class ProfileController extends GetxController {
  LoginDetails? loginDetails;
  int page = 1;
  List<Event> feed = [];
  int? totalPages;
  int? nextPage;
  int? currentPage;
  final isConnecting = false.obs;
  bool isLastPage = false;
  @override
  void onInit() {
    getUserInfo();
    getUploadedEvent();
    super.onInit();
  }

  getUserInfo() async {
    LoginDetails details = await Picker.getLoginDetails();
    loginDetails = details;
    update();
  }

  getUploadedEvent([int? p, int? userId]) async {
    isConnecting.toggle();
    if (p != null) feed.clear();
    final LoginDetails userDetails = await Picker.getLoginDetails();
    final userId = userDetails.userId!;
    final response =
        await ProfileRequest.getPostDetails(p ?? nextPage ?? page, userId);
    Map<String, dynamic> rawData = response.data;
    isLastPage = rawData['currentPage'] == rawData['totalPages'];
    print("is last: $isLastPage");

    var toModel = jsonEncode(rawData);
    // print(toModel);

    if (rawData['status'] == 200) {
      final data = newPostModelFromJson(toModel);
      totalPages = data.totalPages;
      nextPage = data.nextPage;
      feed.addAll(data.data);
    } else {
      Get.snackbar("Error",
          "${rawData['status'] == 010 ? rawData['message'] : rawData['status']}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(.5),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15));
      print(rawData['status']);
    }
    isConnecting.toggle();
    update(['event']);
  }
}
