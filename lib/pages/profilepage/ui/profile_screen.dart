import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:sebarin/constants/themes/dark_theme.dart';
import 'package:sebarin/shared/widget/contentitem.dart';
import 'package:sebarin/shared/widget/navbar.dart';
import 'package:shimmer/shimmer.dart';

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
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,
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
                              onPressed: () => controller.changePhoto()),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                Text(
                  "Pernah nyebarin",
                  style: TextStyle(
                      fontFamily: 'pacifico',
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                Spacer(),
                ElevatedButton(
                    onPressed: () => Get.toNamed('/create'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Buat Event"),
                      ],
                    )),
              ],
            ),
          ),
          Expanded(
              child: Obx(
            () => LazyLoadScrollView(
              isLoading: controller.isConnecting.value,
              onEndOfPage: () {
                print("End of page");
                if (!controller.isLastPage) controller.getUploadedEvent();
                print(controller.isConnecting);
              },
              child: RefreshIndicator(
                onRefresh: () => controller.getUploadedEvent(1),
                child: GetBuilder<ProfileController>(
                  id: 'event',
                  assignId: true,
                  builder: (controller) => ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 15),
                    itemCount: controller.feed.length + 1,
                    itemBuilder: (context, index) {
                      if (index == controller.feed.length &&
                          controller.isConnecting.value)
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (context, index) => Shimmer.fromColors(
                              baseColor: Colors.grey.shade200,
                              highlightColor: Colors.grey.shade300,
                              child: ContentItem()),
                        );
                      if (index == controller.feed.length &&
                          controller.isConnecting.value == false)
                        return SizedBox();
                      return ContentItem(controller.feed[index]);
                    },
                  ),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
