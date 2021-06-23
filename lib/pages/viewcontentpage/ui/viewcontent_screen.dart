import 'dart:convert';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_quill/models/documents/document.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:flutter_quill/widgets/simple_viewer.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:sebarin/constants/themes/dark_theme.dart';
import 'package:sebarin/pages/viewcontentpage/controller/viewcontent_controller.dart';
import 'package:sebarin/shared/widget/fullscreenimage.dart';

class ViewContentScreen extends GetView<ViewContentController> {
  @override
  Widget build(BuildContext context) {
    List<Widget> contentAction = [
      PopupMenuButton(
        enableFeedback: false,
        onSelected: (value) async {
          await controller.savetoLocal();
        },
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        icon: Icon(Feather.more_vertical),
        itemBuilder: (context) => [
          PopupMenuItem(
            height: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Save"),
            ),
            value: "save",
          )
        ],
      )
    ];
    return Scaffold(
        body: Stack(
      children: [
        if (MediaQuery.of(context).orientation.index == 1)
          ContentViewHeader(contentAction),
        Container(
            margin: MediaQuery.of(context).orientation.index == 0
                ? null
                : EdgeInsets.only(
                    left: MediaQuery.of(context).size.height - 100),
            width: MediaQuery.of(context).size.width,
            child: CustomScrollView(
              controller: controller.scrollController,
              slivers: [
                if (MediaQuery.of(context).orientation.index == 0)
                  Obx(
                    () => SliverAppBar(
                      pinned: true,
                      stretch: true,
                      brightness: Brightness.light,
                      actions: controller.isLogin.value ? contentAction : null,
                      expandedHeight: MediaQuery.of(context).size.width,
                      flexibleSpace:
                          LayoutBuilder(builder: (context, constraints) {
                        final settings =
                            context.dependOnInheritedWidgetOfExactType<
                                FlexibleSpaceBarSettings>();
                        final deltaExtent =
                            settings!.maxExtent - settings.minExtent;
                        final t = (1.0 -
                                (settings.currentExtent - settings.minExtent) /
                                    deltaExtent)
                            .clamp(0.0, 1.0);
                        final fadeStart =
                            math.max(0.0, 1.0 - (10) / deltaExtent);
                        const fadeEnd = 1.0;
                        final opacity =
                            1.0 - Interval(fadeStart, fadeEnd).transform(t);
                        controller.headerOpacity.value = opacity;
                        print(controller.headerOpacity);
                        return FlexibleSpaceBar(
                            title: Opacity(
                              opacity: 1 - opacity,
                              child: Text(
                                "Detail acara",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            background: GestureDetector(
                              onTap: () => Get.to(
                                  FullScreenImage(
                                      "${controller.event!.thumbnail}"),
                                  transition: Transition.fadeIn),
                              child: Hero(
                                tag: 'img',
                                child: CachedNetworkImage(
                                  imageUrl: "${controller.event!.thumbnail}",
                                  progressIndicatorBuilder:
                                      (context, url, progress) => Container(
                                    width: 20,
                                    height: 20,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        value: progress.progress,
                                      ),
                                    ),
                                  ),
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ));
                      }),
                    ),
                  ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  if (MediaQuery.of(context).orientation.index == 1)
                    SizedBox(height: context.mediaQueryPadding.top),
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Wrap(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Text(
                                "${controller.event!.title}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 24,
                                ),
                              ),
                              Divider(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                        _DetailItem(
                          icon: Feather.mic,
                          label: "Moderator",
                          value: controller.event!.moderator,
                        ),
                        _DetailItem(
                          icon: Feather.volume_2,
                          label: "Narasumber",
                          value: controller.event!.narasumber,
                        ),
                        _DetailItem(
                          icon: Feather.calendar,
                          label: "Tanggal",
                          value: controller.event!.jadwal.parsed +
                              " jam " +
                              DateFormat('HH:mmWIB', 'id').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      controller.event!.jadwal.timestamp)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        Obx(() => QuillSimpleViewer(
                              truncate: controller.isShowShort.value,
                              truncateHeight:
                                  controller.isShowShort.value ? 80 : null,
                              controller: QuillController(
                                  selection: TextSelection.collapsed(offset: 0),
                                  document: Document.fromJson(jsonDecode(
                                      controller.description.value))),
                            )),
                        if (controller.description.value.length > 100)
                          Obx(
                            () => TextButton(
                              onPressed: () => controller.isShowShort.toggle(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(controller.isShowShort.value
                                      ? "Show more"
                                      : "Show less"),
                                ],
                              ),
                            ),
                          )
                        else
                          SizedBox(height: 30),
                        Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Obx(
                            () => ElevatedButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.resolveWith(
                                      (states) =>
                                          EdgeInsets.symmetric(vertical: 16)),
                                  overlayColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) {
                                    if (states.contains(MaterialState.pressed))
                                      return Colors.green;
                                  }),
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) {
                                    if (states.contains(MaterialState.disabled))
                                      return Colors.transparent;
                                    else
                                      return primaryColor;
                                  }),
                                ),
                                onPressed: controller.isConnecting.value
                                    ? null
                                    : controller.isExpired.value
                                        ? null
                                        : controller.isAttended.value
                                            ? null
                                            : () => controller.attendButton(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (controller.isConnecting.value)
                                      SizedBox(
                                          height: 18,
                                          width: 18,
                                          child: CircularProgressIndicator())
                                    else
                                      Text(
                                        controller.isLogin.value
                                            ? controller.isUploadedByMe.value
                                                ? "Lihat daftar hadir"
                                                : controller.isAttended.value
                                                    ? "Kamu akan menghadiri"
                                                    : controller.isExpired.value
                                                        ? "Event sudah berakhir"
                                                        : "Aku Ingin Hadir!"
                                            : "Login untuk menghadiri",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                  ],
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ]))
              ],
            ))
      ],
    ));
  }
}

class _DetailItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _DetailItem(
      {Key? key, required this.label, required this.value, required this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: Icon(
                  icon,
                  size: 24,
                  color: primaryColor,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(
            height: 30,
          ),
        ],
      ),
    );
  }
}

class ContentViewHeader extends GetWidget<ViewContentController> {
  final List<Widget> contentAction;

  ContentViewHeader(this.contentAction);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).orientation.index == 0
          ? double.infinity
          : MediaQuery.of(context).size.height - 100,
      height: MediaQuery.of(context).orientation.index == 0
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.height,
      color: Colors.grey,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: "${controller.event!.thumbnail}",
            progressIndicatorBuilder: (context, url, progress) => Container(
              width: 20,
              height: 20,
              child: Center(
                child: CircularProgressIndicator(
                  value: progress.progress,
                ),
              ),
            ),
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Container(
            height: 48 + MediaQuery.of(context).padding.top,
            child: PreferredSize(
              preferredSize: Size.fromHeight(48),
              child: Obx(
                () => AppBar(
                  backgroundColor: Colors.transparent,
                  actions: controller.isLogin.value ? contentAction : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
