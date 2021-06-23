import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:sebarin/constants/themes/dark_theme.dart';
import 'package:sebarin/pages/myeventpage/controller/myevent_controller.dart';
import 'package:sebarin/shared/models/events.dart';
import 'package:sebarin/shared/widget/contentitem.dart';
import 'package:sebarin/shared/widget/navbar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyEventScreen extends GetView<MyEventController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(
        title: 'Event Saya',
      ),
      body: Obx(
        () => LazyLoadScrollView(
          isLoading: controller.isConnecting.value,
          onEndOfPage: () {
            print("End of page");
            if (!controller.isLastPage) controller.getMyEvent();
            print(controller.isConnecting);
          },
          child: RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            onRefresh: () => controller.getMyEvent(1),
            child: ListView(
              children: [
                Container(
                  color: primaryColor,
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "Webinar atau acara yang akan kamu hadiri akan tampil disini, pastikan tepat waktu dan pasang pengingat ya!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      height: 1.5,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: GetBuilder<MyEventController>(
                    init: MyEventController(),
                    builder: (controller) => ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.isConnecting.value
                            ? 5
                            : controller.feed.length + 1,
                        itemBuilder: (context, index) {
                          if (controller.isConnecting.value)
                            return Shimmer.fromColors(
                              highlightColor: Colors.grey.shade300,
                              baseColor: Colors.grey.shade100,
                              child: _MyEventItem(),
                            );
                          if (index == controller.feed.length)
                            return TimelineTile(
                              beforeLineStyle: LineStyle(color: primaryColor),
                              afterLineStyle: LineStyle(
                                  thickness: 0, color: Colors.transparent),
                              indicatorStyle: IndicatorStyle(
                                color: primaryColor,
                                padding: EdgeInsets.only(right: 15),
                                width: 60,
                                height: 60,
                                indicator: Container(
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Container(
                                      height: 52,
                                      width: 52,
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(MaterialCommunityIcons
                                          .lightbulb_on_outline),
                                    ),
                                  ),
                                ),
                              ),
                              endChild: Container(
                                margin: EdgeInsets.symmetric(vertical: 30),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                    "Belajarlah selagi mampu. agar kau tidak menelan paitnya kebodohan di masa tuamu."),
                              ),
                            );

                          return _MyEventItem(controller.feed[index]);
                        }),
                  ),
                ),
                if (controller.isNotFound)
                  Center(
                      child: CachedNetworkImage(
                    imageUrl:
                        "https://cdn.iconscout.com/icon/free/png-512/data-not-found-1965034-1662569.png",
                  ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MyEventItem extends StatelessWidget {
  final Event? event;

  const _MyEventItem([this.event]);
  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      axis: TimelineAxis.vertical,
      endChild: ContentItem(event),
      beforeLineStyle: LineStyle(color: primaryColor),
      indicatorStyle: IndicatorStyle(
          color: primaryColor,
          padding: EdgeInsets.only(right: 15),
          width: 60,
          height: 60,
          indicator: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        event == null
                            ? "14"
                            : DateTime.fromMillisecondsSinceEpoch(
                                    event!.jadwal.timestamp)
                                .day
                                .toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: primaryColor),
                        child: Text(
                          event == null
                              ? "Bulan"
                              : DateFormat("MMMM", "ID").format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      event!.jadwal.timestamp)),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
