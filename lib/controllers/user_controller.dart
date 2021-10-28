import 'package:get/get.dart';
import 'package:kiwigames/models/models.dart';

class UserController extends GetxController {
  final User user;

  UserController(this.user);

  final userList = <User>[
    User(
      email: 'test@test.test',
      username: 'Childebert',
      imagePath: 'https://source.unsplash.com/random',
      isActive: true,
    ),
    User(
      email: 'test@test.test',
      username: 'Clarantine',
      isActive: true,
    ),
    User(
      email: 'test@test.test',
      username: 'Gilbert Swag',
      imagePath: 'https://source.unsplash.com/random',
      isActive: false,
    ),
    User(
      email: 'test@test.test',
      username: 'Clarantine',
      imagePath: 'https://source.unsplash.com/random',
      isActive: false,
    ),
    User(
      email: 'test@test.test',
      username: 'Gilbert Swag',
      isActive: true,
    ),
  ].obs;
}
