import 'package:dio/dio.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../entities/repositories/login_repository.dart';

class LoginController extends GetxController {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final obscureText = true.obs;
  final isConnecting = false.obs;

  togglePassword() {
    obscureText.toggle();
  }

  doLogin() async {
    isConnecting.toggle();
    http.FormData data = http.FormData.fromMap({
      'username': usernameController.text,
      'password': passwordController.text,
    });
    http.Response response = await LoginRequest.doLogin(data);
    isConnecting.toggle();
    if (response.data['status'] == 200) {
      Fluttertoast.cancel();
      Fluttertoast.showToast(msg: response.data['message'].toString());

      savePrefs(response.data);
      Get.back(result: true);
    } else {
      Fluttertoast.cancel();
      Fluttertoast.showToast(msg: response.data['message'].toString());
    }
  }

  savePrefs(Map<String, dynamic> response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loginStatus', response['success']);
    prefs.setInt('userId', response['data']['id']);
    prefs.setString('username', response['data']['username']);
    prefs.setString('name', response['data']['name']);
    if(response['data']['photo']!=null)
    prefs.setString('photo', response['data']['photo']);
    else
      prefs.remove('photo');
  }
}
