import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sebarin/constants/themes/dark_theme.dart';
import 'package:sebarin/shared/widget/navbar.dart';

import '../controller/present_list_controller.dart';

class PresentListScreen extends GetView<PresentListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(
        title: "Daftar Hadir",
        actions: [
          GetBuilder<PresentListController>(
            id: 'navbar',
            builder: (controller) => controller.data == null
                ? Container()
                : Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 15, 10),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: primaryColor,
                    ),
                    child: Center(
                        child: Text(
                      (controller.data!.attendees.length.toString()) +
                          " Peserta",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ))),
          )
        ],
      ),
      body: Obx(() => controller.isConnecting.value
          ? Center(
              child: CupertinoActivityIndicator(),
            )
          : controller.data == null
              ? Stack(
                  fit: StackFit.expand,
                  children: [
                    Align(
                      alignment: context.orientation.index == 1
                          ? Alignment.centerLeft
                          : Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: context.orientation.index == 1 ? 60 : 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "404",
                              style: TextStyle(
                                color: primaryColor,
                                height: 1,
                                fontSize: 148,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "Belum ada peserta yang ikut event ini!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "Cobalah untuk membagikannya kepada teman - temanmu",
                              textAlign: TextAlign.center,
                            ),
                            if (context.orientation.index == 0)
                              SizedBox(
                                height: 100,
                              )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        top: context.orientation.index == 1 ? 0 : null,
                        left: context.orientation.index == 1 ? null : 0,
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            child: Image.asset('assets/images/noitem.png'))),
                  ],
                )
              : ListView.builder(
                  itemCount: controller.data?.attendees.length ?? 1,
                  itemBuilder: (context, index) {
                    if (controller.isConnecting.value) return Text("Loading");
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(controller
                                .data?.attendees[index].photo ??
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Blank_woman_placeholder.svg/1200px-Blank_woman_placeholder.svg.png"),
                      ),
                      title: Text(controller.data?.attendees[index].name ??
                          "Nama Pengguna"),
                    );
                  },
                )),
    );
  }
}
