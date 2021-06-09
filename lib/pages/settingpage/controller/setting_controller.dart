import 'package:get/get.dart';
import 'package:package_info/package_info.dart';

class SettingController extends GetxController {
  @override
  void onInit() {
    getPackageInfo();
    super.onInit();
  }

  final packageInfo = <String, dynamic>{}.obs;
  getPackageInfo() async {
    PackageInfo appInfo = await PackageInfo.fromPlatform();

    packageInfo.value = {
      "appName": appInfo.appName,
      "packageName": appInfo.packageName,
      "version": appInfo.version,
      "buildNumber": appInfo.buildNumber,
    };
  }
}
