import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:sebarin/pages/settingpage/controller/setting_controller.dart';
import 'package:sebarin/shared/widget/navbar.dart';

class SettingScreen extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NavBar(
          title: "Pengaturan",
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      Icon(Feather.info),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Application version",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Obx(
                            () => Text(
                              controller.packageInfo['version'].toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
