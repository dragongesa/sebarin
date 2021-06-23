import 'dart:convert';

import 'package:dio/dio.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sebarin/pages/createpage/entities/models/categories_model.dart';
import 'package:sebarin/pages/createpage/entities/repositories/create_repository.dart';
import 'package:sebarin/shared/function/picker_function.dart';

class CreateController extends GetxController {
  QuillController? editorController;
  final currentIndex = 0.obs;
  final formattedDate = <String>[].obs;
  final formattedTime = "".obs;
  final FocusNode focusNode = FocusNode();
  List<Category>? categories;
  Category? selectedCategory;
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
    fetchCategories();
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

  Future<List<Category>> fetchCategories() async {
    isConnecting.toggle();
    if (categories == null) {
      http.Response response = await CreateRequest.getCategories();
      if (response.data['status'] == 200) {
        CategoriesModel model =
            categoriesModelFromJson(jsonEncode(response.data));
        categories = model.categories;
      }
    }
    isConnecting.toggle();
    return categories!;
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
    LoginDetails loginDetails = await Picker.getLoginDetails();
    final judul = judulController!.text;
    final moderator = moderatorController!.text;
    final narasumber = narasumberController!.text;
    var stringdate = tmpDate.toString();
    final jadwal = stringdate.contains(".")
        ? stringdate.substring(0, stringdate.lastIndexOf('.'))
        : "";

    if (judul.isEmpty ||
        moderator.isEmpty ||
        narasumber.isEmpty ||
        jadwal.isEmpty ||
        poster == null ||
        selectedCategory == null) {
      List<String> emptyList = [];
      if (judul.isEmpty) emptyList.add("judul");
      if (moderator.isEmpty) emptyList.add("moderator");
      if (narasumber.isEmpty) emptyList.add("narasumber");
      if (jadwal.isEmpty) emptyList.add("jadwal");
      if (poster == null) emptyList.add("poster");
      if (selectedCategory == null) emptyList.add("kategori");
      String emptyField = emptyList.join(", ");
      Fluttertoast.cancel();
      Fluttertoast.showToast(msg: "Bilah $emptyField masih belum kamu isi! :(");
      return;
    }
    final formData = http.FormData.fromMap({
      'title': judul,
      'moderator': moderator,
      'narasumber': narasumber,
      'uploaded_by': "${loginDetails.userId}",
      'category_id': "${selectedCategory!.id}",
      'jadwal': jadwal,
      'short_desc': editorController!.document.toPlainText().length > 50
          ? editorController!.document.toPlainText().substring(0, 50)
          : editorController!.document.toPlainText(),
      'description': jsonEncode(editorController!.document.toDelta().toJson()),
      'image': await http.MultipartFile.fromFile(poster!.path!,
          filename: poster!.name)
    });
    print(formData.fields[7]);
    isConnecting.toggle();
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
