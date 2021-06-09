import 'package:get/get.dart';
import 'package:sebarin/pages/searchpage/controller/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchController());
  }
}
