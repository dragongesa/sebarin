import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:sebarin/shared/widget/navbar.dart';

import '../controller/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(
        title: "Login",
      ),
      body: Stack(
        children: [
          Center(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 30),
              shrinkWrap: true,
              children: [
                TextField(
                  controller: controller.usernameController,
                  decoration: InputDecoration(
                    icon: Icon(Feather.user),
                    hintText: "Username",
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Obx(
                  () => TextField(
                    controller: controller.passwordController,
                    obscureText: controller.obscureText.value,
                    decoration: InputDecoration(
                      icon: Icon(Feather.lock),
                      hintText: "Password",
                      suffixIcon: IconButton(
                        splashColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerRight,
                        icon: Icon(
                          controller.obscureText.value
                              ? Feather.eye_off
                              : Feather.eye,
                          size: 18,
                        ),
                        onPressed: () => controller.togglePassword(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Obx(
              () => TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(32)))),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    elevation: MaterialStateProperty.all(0),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    minimumSize: MaterialStateProperty.all(Size(120, 40))),
                onPressed: () {
                  if (!controller.isConnecting.value) controller.doLogin();
                },
                child: controller.isConnecting.value
                    ? Container(
                        constraints: BoxConstraints(maxWidth: 80),
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.white,
                        ))
                    : Row(
                        children: [
                          Text(
                            "Login".toUpperCase(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Feather.log_in,
                            size: 16,
                          ),
                        ],
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
