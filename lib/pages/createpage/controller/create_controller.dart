import 'dart:convert';

import 'package:dio/dio.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sebarin/pages/createpage/entities/repositories/create_repository.dart';
import 'package:sebarin/shared/function/picker_function.dart';

class CreateController extends GetxController {
  QuillController? editorController;
  final currentIndex = 0.obs;
  final formattedDate = <String>[].obs;
  final formattedTime = "".obs;
  final FocusNode focusNode = FocusNode();
  PlatformFile? poster;
  TextEditingController? judulController;
  TextEditingController? moderatorController;
  TextEditingController? narasumberController;
  final isConnecting = false.obs;
  String? jadwal;
  DateTime? tmpDate;
  formatDate(DateTime date) {
    tmpDate = date;
    formattedDate.clear();
    List<String> dates =
        DateFormat('EEEE|dd|MMMM|yyyy', 'id').format(date).split("|");
    formattedDate.addAll(dates);
    formattedTime.value = DateFormat('HH:mm', 'id').format(date) + " WIB";
  }

  @override
  void onInit() {
    editorController = new QuillController.basic();
    judulController = new TextEditingController();
    moderatorController = new TextEditingController();
    narasumberController = new TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    editorController!.dispose();
    judulController!.dispose();
    moderatorController!.dispose();
    narasumberController!.dispose();

    super.onClose();
  }

  pickPoster() async {
    try {
      poster = await Picker.getImageFromGallery();
    } catch (e) {
      print(e);
    } finally {
      update(['poster']);
    }
  }

  deletePoster() async {
    await Picker.deleteTemporaryFiles();
    poster = null;
    update(['poster']);
  }

  prepareUpload() async {
    isConnecting.toggle();
    final judul = judulController!.text;
    final moderator = moderatorController!.text;
    final narasumber = narasumberController!.text;
    var stringdate = tmpDate.toString();
    final jadwal = stringdate.substring(0, stringdate.lastIndexOf('.'));

    final formData = http.FormData.fromMap({
      'title': judul,
      'moderator': moderator,
      'narasumber': narasumber,
      'uploaded_by': 1.toString(),
      'category_id': 1.toString(),
      'jadwal': jadwal,
      'short_desc': editorController!.document.toPlainText().length > 50
          ? editorController!.document.toPlainText().substring(0, 50)
          : editorController!.document.toPlainText(),
      'description': jsonEncode(editorController!.document.toDelta().toJson()),
      'image': await http.MultipartFile.fromFile(poster!.path!,
          filename: poster!.name)
    });
    http.Response response = await CreateRequest.createEvent(formData);
    if (response.data['status'] == true) {
      Get.offNamedUntil("/create/success?id=${response.data['event_id']}",
          (route) => route.isFirst);
    }
    isConnecting.toggle();
  }

  getJadwal() async {
    final value = await Picker.getDateAndTime();
    formatDate(value);
  }
}
