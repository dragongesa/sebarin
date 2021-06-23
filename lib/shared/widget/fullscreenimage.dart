import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImage extends GetWidget {
  final String image;

  FullScreenImage(this.image);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: Container(
        child: Hero(
          tag: 'img',
          child: PhotoView(
            imageProvider: NetworkImage(image),
          ),
        ),
      ),
    );
  }
}
