import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:sebarin/constants/themes/dark_theme.dart';
import 'package:sebarin/shared/widget/contentitem.dart';
import 'package:sebarin/shared/widget/navbar.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyEventScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(
        title: 'Event Saya',
      ),
      body: SingleChildScrollView(
        child: Column(
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
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10 + 1,
                  itemBuilder: (context, index) {
                    if (index == 10)
                      return TimelineTile(
                        beforeLineStyle: LineStyle(color: primaryColor),
                        afterLineStyle:
                            LineStyle(thickness: 0, color: Colors.transparent),
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
                    return TimelineTile(
                      axis: TimelineAxis.vertical,
                      endChild: ContentItem(),
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
                                        "14",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 2),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: primaryColor),
                                        child: Text(
                                          "Agustus",
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
                  }),
            )
          ],
        ),
      ),
    );
  }
}
