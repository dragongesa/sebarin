import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:sebarin/shared/models/events.dart';

class ContentItem extends GetWidget {
  final Event? event;

  ContentItem([this.event]);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed('/view-event', arguments: {'event': event}),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 100,
                    height: 80,
                    color: Colors.grey,
                    child: Image.network(
                      event?.thumbnail ??
                          "https://boostcrack.com/wp-content/themes/zoom-lite/assets/images/misc/placeholder/thumb-medium.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: event?.category.name == null
                                ? null
                                : EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Text(
                              event?.category.name ?? "        ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: event?.jadwal.parsed != null
                                ? Text(
                                    event!.jadwal.parsed,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  )
                                : Container(
                                    width: 80,
                                    height: 12,
                                    color: Colors.grey,
                                  ),
                          )
                        ],
                      ),
                      if (event == null)
                        SizedBox(
                          height: 5,
                        ),
                      Container(
                        margin:
                            event == null ? EdgeInsets.only(bottom: 5) : null,
                        color: event == null ? Colors.grey : Colors.transparent,
                        child: Text(
                          event?.title ?? "Lorem ipsum dolor sit amet",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      if (event == null)
                        Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: [
                            Container(
                                height: 12, width: 50, color: Colors.grey),
                            Container(
                                height: 12, width: 80, color: Colors.grey),
                            Container(
                                height: 12, width: 30, color: Colors.grey),
                            Container(
                                height: 12, width: 100, color: Colors.grey),
                            Container(
                                height: 12, width: 50, color: Colors.grey),
                          ],
                        )
                      else
                        Text(
                          event?.shortDesc.toString() ?? "",
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          if (event != null)
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomRight: Radius.circular(8),
                    ),
                    border: Border.all(width: 1, color: Colors.amber),
                  ),
                  child: Icon(
                    MaterialCommunityIcons.share,
                    size: 12,
                    color: Colors.amber,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
