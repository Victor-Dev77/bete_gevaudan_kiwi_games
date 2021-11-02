import 'package:get/get.dart';
import 'package:kiwigames/models/models.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();

  final User user;

  UserController(this.user);
}
