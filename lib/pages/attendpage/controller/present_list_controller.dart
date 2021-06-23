import 'dart:convert';

import 'package:dio/dio.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sebarin/pages/attendpage/entities/models/presentlist_model.dart';
import 'package:sebarin/pages/attendpage/entities/repositories/present_list_repository.dart';

class PresentListController extends GetxController {
  AttendeList? data;
  final isConnecting = false.obs;
  @override
  void onInit() {
    getList();
    super.onInit();
  }

  getList() async {
    isConnecting.toggle();
    int id = int.parse(Get.parameters['id']!);
    http.Response response = await PresentRequest.getAttendee(id);
    if (response.data['status'] == 200) {
      AttendeList model = attendeListFromJson(jsonEncode(response.data));
      data = model;
    } else if (response.data['status'] == 404) {
      Fluttertoast.cancel();
      Fluttertoast.showToast(msg: "Belum ada yang hadir");
    }
    isConnecting.toggle();
    update(['navbar']);
  }
}
