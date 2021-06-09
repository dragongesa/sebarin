import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:sebarin/constants/themes/dark_theme.dart';
import 'package:sebarin/shared/widget/contentitem.dart';
import 'package:sebarin/shared/widget/navbar.dart';

import '../controller/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(
        title: "Profil Saya",
      ),
      body: Column(
        children: [
          GetBuilder<ProfileController>(
            init: ProfileController(),
            builder: (controller) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              controller.loginDetails?.photo ??
                                  "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Blank_woman_placeholder.svg/1200px-Blank_woman_placeholder.svg.png",
                            ),
                          ),
                          backgroundColor: Colors.grey.shade100,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  overlayColor:
                                      MaterialStateProperty.all(Colors.green),
                                  backgroundColor:
                                      MaterialStateProperty.all(primaryColor),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(15)),
                                  shape: MaterialStateProperty.all(
                                      CircleBorder())),
                              child: Icon(Feather.camera),
                              onPressed: () {}),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  controller.loginDetails?.name ?? "Nama",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                ),
                Text(
                  controller.loginDetails?.username ?? "username",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: GetBuilder(
            id: 'event',
            builder: (ProfileController controller) => ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 30),
              itemCount: controller.feed.length,
              itemBuilder: (context, index) =>
                  ContentItem(controller.feed[index]),
            ),
          )),
        ],
      ),
    );
  }
}
