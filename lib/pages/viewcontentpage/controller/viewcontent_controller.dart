import 'package:dio/dio.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sebarin/pages/viewcontentpage/entities/repositories/viewcontent_repository.dart';
import 'package:sebarin/shared/function/picker_function.dart';
import 'package:sebarin/shared/models/events.dart';

class ViewContentController extends GetxController {
  late ScrollController scrollController;
  GlobalKey titleKey = new GlobalKey();
  final isShowShort = true.obs;
  final isConnecting = false.obs;
  final headerOpacity = 0.0.obs;
  final title = "".obs;
  final shortDescription = "".obs;
  final description = "".obs;
  final isLogin = false.obs;
  final isUploadedByMe = false.obs;
  final isAttended = false.obs;
  final isExpired = false.obs;
  Event? event;
  @override
  void onInit() {
    initializeDateFormatting('id');
    scrollController = new ScrollController()
      ..addListener(() {
        // print(scrollController.offset);
      });
    if (Get.arguments['event'] != null) event = Get.arguments['event'];
    description.value = event?.description ?? "Description not provided";
    shortTheDesc();
    checkLogin();
    checkIsAttended();
    checkExpDate();
    super.onInit();
  }

  checkExpDate() {
    isExpired.value =
        DateTime.now().millisecondsSinceEpoch > event!.jadwal.timestamp;
  }

  shortTheDesc() {
    print(description.value.length);
    if (description.value.length > 100)
      shortDescription.value = description.value.substring(0, 100) + "...";
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  checkLogin() async {
    LoginDetails loginDetails = await Picker.getLoginDetails();
    print(loginDetails);
    if (loginDetails.loginStatus) {
      isUploadedByMe.value = event!.uploadedBy.id == loginDetails.userId;
    }
    isLogin.value = loginDetails.loginStatus;
  }

  attendButton() async {
    print("attend");
    if (isLogin.value) if (isUploadedByMe.value == false) {
      bool isSuccess = await attendEvent();
      if (isSuccess)
        Get.offNamed('/attend', arguments: {
          'event': event,
        });
      else {
        Fluttertoast.cancel();
        Fluttertoast.showToast(msg: "Belum bisa nih, coba lagi yah!");
      }
    } else
      Get.toNamed('/presentlist?id=${event!.id}');
    else {
      var result = await Get.toNamed('/login');
      print(result);
      if (result == true) checkLogin();
    }
  }

  savetoLocal() async {
    print(event!.id);
    int? key = await Picker.saveEventToLocal(event!.id);
    if (key == null) {
      Fluttertoast.cancel();
      Fluttertoast.showToast(msg: "Event ini sudah kamu simpan sebelumnya");
    } else {
      Fluttertoast.cancel();
      Fluttertoast.showToast(msg: "Tersimpan di \"Disimpan\"");
    }
  }

  attendEvent() async {
    isConnecting.toggle();
    LoginDetails loginDetails = await Picker.getLoginDetails();
    int userId = loginDetails.userId!;
    http.FormData data = http.FormData.fromMap({
      'eid': "${event!.id}",
      'uid': "$userId",
    });
    http.Response response = await ViewContentRequest.attendEvent(data);
    isConnecting.toggle();
    if (response.data['status'] == 200) return true;
    return false;
  }

  checkIsAttended() async {
    isConnecting.toggle();
    http.Response response = await ViewContentRequest.getUserEventInfo(event!);
    print(response.data);
    if (response.data['status'] == 200) {
      isAttended.value = response.data['isAttended'];
    } else {
      Fluttertoast.cancel();
      Fluttertoast.showToast(msg: response.data['message']);
    }
    isConnecting.toggle();
  }
}
