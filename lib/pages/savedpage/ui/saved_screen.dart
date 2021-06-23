import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:sebarin/pages/savedpage/controller/saved_controller.dart';
import 'package:sebarin/shared/models/events.dart';
import 'package:sebarin/shared/widget/contentitem.dart';
import 'package:sebarin/shared/widget/navbar.dart';
import 'package:shimmer/shimmer.dart';

class SavedScreen extends GetView<SavedController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(
        title: "Tersimpan",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "Webinar atau acara yang pernah kamu simpan akan tampil disini dan akan hilang ketika kamu menghapus sebarin di smartphone kamu.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.5,
                  fontSize: 16,
                ),
              ),
            ),
            Obx(
              () => Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: controller.length.value > 0
                    ? GetBuilder<SavedController>(
                        id: 'item',
                        builder: (controller) => ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.length.value,
                          itemBuilder: (context, index) {
                            print(index);
                            print(controller.saved.length);
                            if (index <= controller.saved.length) if (controller
                                .saved[index] is Event)
                              return Stack(
                                children: [
                                  ContentItem(controller.saved[index]),
                                  Positioned(
                                    top: 30,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () =>
                                          controller.deleteSavedEventById(
                                              controller.eventsId[index]),
                                      child: Icon(
                                        Feather.trash_2,
                                        size: 14,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            else if (controller.saved[index] == null)
                              return Shimmer.fromColors(
                                  baseColor: Colors.grey.shade200,
                                  highlightColor: Colors.grey.shade300,
                                  child: ContentItem());
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.amber.shade300,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.amber),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Text(
                                        "Event dengan ID [${controller.saved[index]}] tidak tersedia lagi."),
                                  ),
                                  IconButton(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onPressed: () =>
                                        controller.deleteSavedEventById(
                                            controller.saved[index]),
                                    icon: Icon(Feather.x),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    : Text("Kosong"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
