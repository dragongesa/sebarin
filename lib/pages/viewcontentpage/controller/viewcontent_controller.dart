import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sebarin/shared/function/picker_function.dart';
import 'package:sebarin/shared/models/events.dart';

class ViewContentController extends GetxController {
  late ScrollController scrollController;
  GlobalKey titleKey = new GlobalKey();
  final isShowShort = true.obs;

  final headerOpacity = 0.0.obs;
  final title = "".obs;
  final shortDescription = "".obs;
  final description = "".obs;
  final isLogin = false.obs;
  Event? event;
  @override
  void onInit() {
    initializeDateFormatting('id');
    scrollController = new ScrollController()
      ..addListener(() {
        print(scrollController.offset);
      });
    if (Get.arguments['event'] != null) event = Get.arguments['event'];
    description.value = event?.description ?? "Description not provided";
    shortTheDesc();
    checkLogin();
    super.onInit();
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
    isLogin.value = loginDetails.loginStatus;
  }

  attendButton() async {
    if (isLogin.value)
      Get.offNamed('/attend');
    else {
      var result = await Get.toNamed('/login');
      print(result);
      if (result == true) checkLogin();
    }
  }
}
