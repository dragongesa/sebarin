import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:sebarin/constants/themes/dark_theme.dart';
import 'package:sebarin/constants/themes/light_theme.dart';
import 'package:sebarin/pages/homepage/controller/home_controller.dart';
import 'package:sebarin/shared/widget/contentitem.dart';
import 'package:sebarin/shared/widget/drawer.dart';
import 'package:sebarin/shared/widget/navbar.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      endDrawer: SideBar(),
      appBar: NavBar(
        actions: [
          IconButton(
            icon: Icon(Feather.more_horizontal),
            onPressed: () => controller.openDrawer(),
          )
        ],
      ),
      body: Obx(
        () => LazyLoadScrollView(
          isLoading: controller.isConnecting.value,
          onEndOfPage: () {
            print("End of page");
            if (!controller.isLastPage) controller.getEvent();
            print(controller.isConnecting);
          },
          child: RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            onRefresh: () => controller.getEvent(1),
            child: ListView(
              children: [
                GestureDetector(
                  onTap: () => Get.toNamed('/search'),
                  child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(15, 30, 15, 15),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: Get.isDarkMode
                            ? DarkTheme.dpLayer06
                            : LightTheme.greyBackground,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Feather.search,
                            size: 16,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Cari Webinar",
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ],
                      )),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Row(
                      children: [
                        _UnderSearchButton(
                          label: "Otomotif",
                          icon: Feather.truck,
                          constraints: constraints,
                        ),
                        _UnderSearchButton(
                          label: "Geografis",
                          icon: Feather.map,
                          constraints: constraints,
                        ),
                        _UnderSearchButton(
                          label: "Keluarga",
                          icon: Feather.heart,
                          constraints: constraints,
                        ),
                        _UnderSearchButton(
                          label: "Musik",
                          icon: Feather.headphones,
                          constraints: constraints,
                        ),
                      ],
                    );
                  }),
                ),
                // Container(
                //   margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                //   child: Column(
                //     children: [
                //       SectionHeader(
                //         label: "Cocok Buat Kamu",
                //         haveReadMore: true,
                //       ),
                //       ContentItem(),
                //       ContentItem(),
                //       ContentItem(),
                //     ],
                //   ),
                // ),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Column(
                    children: [
                      SectionHeader(
                        label: "Terbaru",
                        haveReadMore: false,
                      ),
                      GetBuilder<HomeController>(
                        id: 'terbaru',
                        builder: (controller) => ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.feed.length,
                          itemBuilder: (context, index) {
                            if (controller.feed.length == 0)
                              return Text("No event found");
                            return ContentItem(controller.feed[index]);
                          },
                        ),
                      ),
                      if (controller.isConnecting.value)
                        Text("Loading...")
                      else
                        Image.network("https://i.redd.it/h8t6xvq7t8s51.png")
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UnderSearchButton extends StatelessWidget {
  final BoxConstraints constraints;
  final String label;
  final IconData icon;

  const _UnderSearchButton(
      {Key? key,
      required this.constraints,
      required this.label,
      required this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed('/search?query=$label'),
      child: Container(
        padding: EdgeInsets.all(5),
        width: constraints.maxWidth / 4,
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.grey,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String label;
  final bool haveReadMore;

  const SectionHeader(
      {Key? key, required this.label, required this.haveReadMore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
              fontFamily: 'pacifico',
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
        if (haveReadMore)
          Row(
            children: [
              Text(
                "Lihat semuanya",
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Feather.arrow_right,
                size: 12,
              ),
            ],
          )
      ],
    );
  }
}
