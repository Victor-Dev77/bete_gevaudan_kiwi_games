import 'package:get/get.dart';

void back(String path) {
  Get.previousRoute == '' ? Get.offAllNamed(path) : Get.back();
}
