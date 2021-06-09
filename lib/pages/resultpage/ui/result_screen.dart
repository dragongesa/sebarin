import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sebarin/shared/widget/contentitem.dart';

class ResultScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48),
        child: AppBar(
          title: Text("Results"),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Menampilkan hasil untuk",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              Text(
                '''"${Get.parameters['query'] ?? Get.arguments['query']}"''',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              ListView.builder(
                itemCount: Get.arguments['data'].data.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) =>
                    ContentItem(Get.arguments['data'].data[index]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
