import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:sebarin/shared/widget/contentitem.dart';
import 'package:sebarin/shared/widget/navbar.dart';

class SavedScreen extends GetView {
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) => Stack(
                  children: [
                    ContentItem(),
                    Positioned(
                      top: 30,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => print("Pressed trash"),
                        child: Icon(
                          Feather.trash_2,
                          size: 14,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
