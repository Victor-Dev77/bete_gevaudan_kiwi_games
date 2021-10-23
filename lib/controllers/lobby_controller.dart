import 'package:get/get.dart';
import 'package:kiwigames/models/models.dart';

class LobbyController extends GetxController {
  final lobbyCode = 'jambon'.obs;

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
      pseudo: 'Gilbert Swag',
      isActive: false,
    ),
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
      pseudo: 'Gilbert Swag',
      isActive: false,
    ),
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
      pseudo: 'Gilbert Swag',
      isActive: false,
    ),
  ].obs;

  @override
  void onInit() {
    String? type = Get.parameters['type'];
    print(type);
    /* if (type == null || (type != 'public' && type != 'private')) {
      Get.offAllNamed('/not-found');
    } */
    super.onInit();
  }
}
