import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sebarin/shared/models/local_events_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Picker {
  Picker._privateConstructor();

  static final Picker _instance = Picker._privateConstructor();

  factory Picker() {
    return _instance;
  }

  static getDateAndTime() async {
    DateTime? val;
    await Get.bottomSheet(
      Container(
        height: 200,
        foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.white.withOpacity(0),
                Colors.white.withOpacity(0),
                Colors.white,
              ],
              begin: Alignment.topCenter,
              stops: [.1, 0.4, 0.6, .9],
              end: Alignment.bottomCenter,
            )),
        child: CupertinoDatePicker(
          minimumDate: DateTime.now(),
          use24hFormat: true,
          onDateTimeChanged: (value) {
            print(value);
            val = value;
          },
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      backgroundColor: Colors.white,
    );
    return val ?? DateTime.now();
  }

  static Future<PlatformFile?> getImageFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      // allowedExtensions: ['jpeg', 'jpg', 'png'],
    );
    if (result == null) return null;
    var file = File(result.files.single.path!);
    PlatformFile image = PlatformFile(
      name: result.files.single.name,
      size: result.files.single.size,
      bytes: file.readAsBytesSync(),
      path: result.files.single.path,
      readStream: result.files.single.readStream,
    );
    return image;
  }

  static deleteTemporaryFiles() async {
    await FilePicker.platform.clearTemporaryFiles();
    return true;
  }

  static Future<LoginDetails> getLoginDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loginStatus = prefs.getBool('loginStatus') ?? false;
    int? userId = prefs.getInt('userId');
    String? username = prefs.getString('username');
    String? name = prefs.getString('name');
    String? photo = prefs.getString("photo");
    return LoginDetails(loginStatus, userId, username, name, photo);
  }

  static deleteLoginDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('loginStatus');
    prefs.remove('userId');
  }

  static Future<int?> saveEventToLocal(int id) async {
    LoginDetails loginDetails = await getLoginDetails();
    var box = await Hive.openBox('local_event');
    for (LocalEvent event in box.values) {
      if (event.userId == loginDetails.userId! && event.eventId == id)
        return await null;
    }
    int key = await box.add(LocalEvent(loginDetails.userId!, id));
    return key;
  }

  static Future<List<Map<String, dynamic>>> getLocalEvent() async {
    LoginDetails loginDetails = await Picker.getLoginDetails();
    var box = await Hive.openBox('local_event');
    List<Map<String, dynamic>> j = [];
    for (LocalEvent event in box.values) {
      if (event.userId == loginDetails.userId)
        j.add({
          'key': box.keyAt(box.values.toList().indexOf(event)),
          'event_id': event.eventId,
        });
    }
    return j;
  }

  static deleteLocalEventById(int id) async {
    var box = await Hive.openBox('local_event');
    return await box.delete(id);
  }
}

class LoginDetails {
  bool loginStatus;
  int? userId;
  String? username;
  String? name;
  String? photo;
  LoginDetails(
      this.loginStatus, this.userId, this.username, this.name, this.photo);

  @override
  String toString() {
    return '''status: $loginStatus
    ${userId != null ? "userID: $userId" : ""}
    ''';
  }
}
