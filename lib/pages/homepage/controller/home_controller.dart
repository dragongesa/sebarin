import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sebarin/pages/homepage/entities/models/newpost_model.dart';
import 'package:sebarin/pages/homepage/entities/repositories/home_repository.dart';
import 'package:sebarin/shared/models/events.dart';

class HomeController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController? scaffoldConroller;
  int page = 1;
  List<Event> feed = [];
  int? totalPages;
  int? nextPage;
  int? currentPage;
  final isConnecting = false.obs;
  bool isLastPage = false;
  @override
  void onInit() {
    print("home_controller is ready");
    scaffoldConroller = new ScrollController();
    getEvent();
    super.onInit();
  }

  @override
  void onClose() {
    scaffoldConroller!.dispose();
    super.onClose();
  }

  void openDrawer() {
    if (scaffoldKey.currentState!.hasEndDrawer)
      scaffoldKey.currentState!.openEndDrawer();
  }

  getEvent([int? p]) async {
    isConnecting.toggle();
    if (p != null) feed.clear();
    final response = await HomeRequest.getEvent(p ?? nextPage ?? page);
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

    update(['terbaru']);
  }
}
