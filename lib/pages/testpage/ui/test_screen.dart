import 'package:flutter/material.dart';
import 'package:flutter_quill/widgets/simple_viewer.dart';
import 'package:get/get.dart';
import 'package:sebarin/pages/createpage/controller/create_controller.dart';

class TestScreen extends GetView<CreateController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
              '''${controller.editorController!.document.toDelta().toJson()}'''),
          QuillSimpleViewer(controller: controller.editorController!),
        ],
      ),
    );
  }
}
