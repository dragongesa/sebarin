import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:sebarin/shared/controller/theme_controller.dart';

import '../controller/drawer_controller.dart';

class SideBar extends GetWidget<ThemeController> {
  final drawerController = Get.put(SidebarController());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.shortestSide * (2 / 3),
      child: Drawer(
        child: SafeArea(
          child: LayoutBuilder(builder: (context, snapshot) {
            print(snapshot.maxHeight);
            return Container(
              padding: EdgeInsets.all(15),
              child: Obx(
                () => Column(
                  children: [
                    if (drawerController.isLogin.value)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 32,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                      imageUrl: drawerController.user?.photo ??
                                          "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Blank_woman_placeholder.svg/1200px-Blank_woman_placeholder.svg.png",
                                      height: double.infinity,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  backgroundColor: Colors.grey.shade100,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        drawerController.user?.name ?? "Name",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Text(
                                        drawerController.user?.username ??
                                            "username",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Container(
                                        height: 16,
                                        child: TextButton(
                                            style: ButtonStyle(
                                                enableFeedback: false,
                                                overlayColor:
                                                    MaterialStateProperty
                                                        .resolveWith((states) =>
                                                            Colors.transparent),
                                                padding: MaterialStateProperty
                                                    .resolveWith((states) =>
                                                        EdgeInsets.zero)),
                                            onPressed: () => Get
                                              ..back()
                                              ..toNamed('/my-profile')!
                                                  .whenComplete(() =>
                                                      drawerController
                                                          .getLoginDetails()),
                                            child: Text("Lihat profil")),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(),
                        ],
                      ),
                    Container(
                      height: snapshot.maxHeight - 161,
                      child:
                          NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (notification) {
                          notification.disallowGlow();
                          return true;
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              if (drawerController.isLogin.value)
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () => Get
                                          ..back()
                                          ..toNamed('/create'),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Buat Event"),
                                          ],
                                        )),
                                    DrawerItem(
                                      icon: Feather.save,
                                      label: "Disimpan",
                                      route: '/saved',
                                    ),
                                    DrawerItem(
                                      icon: Feather.award,
                                      label: "Event Saya",
                                      route: '/my-event',
                                    ),
                                  ],
                                ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Feather.sun),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Dark Mode",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Spacer(),
                                    Switch(
                                        value: controller.isDarkMode.value,
                                        onChanged: (val) =>
                                            controller.changeTheme(val)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (drawerController.isLogin.value)
                                drawerController.logoutButton();
                              else
                                drawerController.loginButton();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              margin: EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Colors.grey.shade200),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Feather.log_out),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    (drawerController.isLogin.value)
                                        ? "Logout"
                                        : "Login",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () => Get
                            ..back()
                            ..toNamed('/settings'),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            margin: EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Feather.settings),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class DrawerItem extends GetWidget {
  final String label;
  final IconData icon;
  final String route;

  const DrawerItem(
      {Key? key, required this.label, required this.icon, required this.route})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get
        ..back()
        ..toNamed(route),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        margin: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon),
            SizedBox(
              width: 5,
            ),
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
