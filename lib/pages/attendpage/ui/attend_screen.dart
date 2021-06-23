import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sebarin/constants/themes/dark_theme.dart';
import 'package:sebarin/pages/attendpage/controller/attend_controller.dart';

class AttendScreen extends GetView<AttendController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Lottie.asset(
                      'assets/images/animation/check.json',
                      repeat: false,
                      width: 100,
                    ),
                    Expanded(
                      child: Text(
                        "Siap Bos!",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Sekarang kamu terdaftar dalam event ini, pengen diingetin sekalian?",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: Row(
                  children: [
                    OutlinedButton(
                        onPressed: () => controller.addToCalendar(),
                        child: Text("Ingetin Sekalian dong".toUpperCase())),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          style: ButtonStyle(
                            elevation:
                                MaterialStateProperty.resolveWith((states) {
                              if (!states.contains(MaterialState.pressed))
                                return 0;
                            }),
                          ),
                          onPressed: () => Get.back(),
                          child: Text("Gausah".toUpperCase())),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
