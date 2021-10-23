import 'package:get/get.dart';
import 'package:kiwigames/models/models.dart';

class UserController extends GetxController {
  final user = User(pseudo: 'Zloffy66', isActive: true).obs;
  final userList = <User>[
    User(
      pseudo: 'Childebert',
      imagePath: 'https://source.unsplash.com/random',
      isActive: true,
    ),
    User(
      pseudo: 'Clarantine',
      isActive: true,
    ),
    User(
      pseudo: 'Gilbert Swag',
      imagePath: 'https://source.unsplash.com/random',
      isActive: false,
    ),
    User(
      pseudo: 'Clarantine',
      imagePath: 'https://source.unsplash.com/random',
      isActive: false,
    ),
    User(
      pseudo: 'Gilbert Swag',
      isActive: true,
    ),
  ].obs;
}
