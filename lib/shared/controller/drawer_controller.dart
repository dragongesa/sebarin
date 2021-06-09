import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sebarin/shared/function/picker_function.dart';

class SidebarController extends GetxController {
  final isLogin = false.obs;
  LoginDetails? user;
  @override
  void onInit() {
    getLoginDetails();
    super.onInit();
  }

  getLoginDetails() async {
    LoginDetails loginDetails = await Picker.getLoginDetails();
    user = loginDetails;
    isLogin.value = loginDetails.loginStatus;
  }

  loginButton() async {
    var result = await Get.toNamed('/login');
    print(result);
    if (result == true) getLoginDetails();
  }

  logoutButton() {
    Get.dialog(
      AlertDialog(
        content: Text("Yakin mau keluar bro?"),
        actions: [
          OutlinedButton(
              onPressed: () {
                Picker.deleteLoginDetails();
                getLoginDetails();
                Get.close(1);
              },
              child: Text("Yakinlah, masa")),
          ElevatedButton(
              style: ButtonStyle(elevation: MaterialStateProperty.all(0)),
              onPressed: () => Get.back(),
              child: Text("Engga")),
        ],
      ),
    );
  }
}
