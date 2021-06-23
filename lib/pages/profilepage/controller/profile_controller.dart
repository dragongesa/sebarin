import 'dart:convert';

import 'package:dio/dio.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sebarin/pages/homepage/entities/models/newpost_model.dart';
import 'package:sebarin/shared/function/picker_function.dart';
import 'package:sebarin/shared/models/events.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../entities/respositories/profile_repository.dart';

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

  getUploadedEvent([int? p]) async {
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
    print(toModel);

    if (rawData['status'] == 200) {
      final data = newPostModelFromJson(toModel);
      totalPages = data.totalPages;
      nextPage = data.nextPage;
      feed.addAll(data.data);
    } else if (rawData['status'] == 404) {
      Get.snackbar("Upload event baru yuk",
          "Karena kayanya kamu belum pernah upload deh :(",
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue.withOpacity(.8),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15));
      print(rawData['status']);
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

  changePhoto() async {
    LoginDetails details = await Picker.getLoginDetails();
    PlatformFile? image = await Picker.getImageFromGallery();
    if (image == null) return false;
    http.FormData data = http.FormData.fromMap({
      "uid": "${details.userId}",
      "image":
          await http.MultipartFile.fromFile(image.path!, filename: image.name)
    });
    http.Response response = await ProfileRequest.changePhoto(data);
    print(response.data);
    if (response.data['status'] == 200) {
      savePref(response.data['link']);
      await getUserInfo();
      Fluttertoast.cancel();
      Fluttertoast.showToast(msg: response.data['message']);
    }
  }

  savePref(String link) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('photo', link);
  }
}
