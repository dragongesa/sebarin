import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:sebarin/constants/themes/dark_theme.dart';
import 'package:sebarin/pages/searchpage/controller/search_controller.dart';

class SearchScreen extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Get.isDarkMode
                              ? context.textTheme.bodyText1!.color
                              : primaryColor,
                          fontFamily: 'lato',
                          fontSize: 24,
                        ),
                        children: [
                          TextSpan(
                            text: "Mau ",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: "nyari",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          TextSpan(
                            text: " topik",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      controller: controller.textfield,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => OutlinedButton(
                          onPressed: () {
                            if (!controller.isConnecting.value)
                              controller.search();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (controller.isConnecting.value)
                                Expanded(
                                  child: LinearProgressIndicator(
                                    minHeight: 20,
                                  ),
                                )
                              else
                                Text(
                                  "Cariin dong!",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ),
            IconButton(
                icon: Icon(Feather.arrow_left), onPressed: () => Get.back()),
          ],
        ),
      ),
    );
  }
}
