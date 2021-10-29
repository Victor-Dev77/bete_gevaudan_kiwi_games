import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/controllers/controllers.dart';
import 'package:kiwigames/models/models.dart';
import 'package:kiwigames/shared/shared.dart';

final AppBar appBar = AppBar(
  title: const KiwiAppBar(),
  titleSpacing: 0,
);

class KiwiAppBar extends GetView<UserController> {
  const KiwiAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width <= 1250.0) {
      return const MobileAppBar();
    }
    return const DesktopAppBar();
  }
}

class MobileAppBar extends StatelessWidget {
  const MobileAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight + 25.0,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          KiwiGamesLogo(),
          // Categories(),
          CurrentUser(),
        ],
      ),
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  void showCategoryList() {
    Get.dialog(
      const CategoryList(),
      barrierDismissible: false,
      useSafeArea: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: Text('categories'.tr),
      label: const Icon(Icons.arrow_drop_down),
      onPressed: showCategoryList,
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      textStyle: Get.textTheme.headline6,
      color: dividerColor.color,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Ambiance'),
              Text('Cartes'),
              Text('Complexes'),
              Text('Escape Games'),
              Text('Plateau'),
              Text('Simple'),
              InkWell(
                borderRadius: BorderRadius.circular(100.0),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Get.textTheme.bodyText1?.color,
                  ),
                  child: Icon(
                    Icons.close,
                    color: Get.theme.scaffoldBackgroundColor,
                  ),
                ),
                onTap: Get.back,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DesktopAppBar extends StatelessWidget {
  const DesktopAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Image.asset(
            'assets/images/logos/logo.png',
            height: kToolbarHeight - 10.0,
          ),
          // const WidthSpacer(40.0),
          // InteractiveText(
          //   text: 'home'.tr,
          //   function: () => print('go to home'),
          // ),
          // const WidthSpacer(20.0),
          // InteractiveText(
          //   text: 'selected_for_you'.tr,
          //   function: () => print('go to selected'),
          // ),
          // const WidthSpacer(20.0),
          // InteractiveText(
          //   text: 'my_list'.tr,
          //   function: () => print('go to my list'),
          // ),
          // const WidthSpacer(20.0),
          // InteractiveText(
          //     text: 'category'.tr, function: () => print('go to category')),
          // const WidthSpacer(25.0),
          // ElevatedButton(
          //   child: Text('subscribe'.tr),
          //   onPressed: () => print('subscribe'),
          // ),
          const WidthSpacer(50.0),
          const UserList(),
          const WidthSpacer(25.0),
          // const Search(),
          // const WidthSpacer(20.0),
          const Spacer(),
          const CurrentUser(),
        ],
      ),
    );
  }
}

class UserList extends GetView<LobbyController> {
  const UserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Wrap(
        spacing: 10.0,
        children: controller.userList
            .map(
                (user) => UserController.instance.user.username != user.username
                    ? UserImage(
                        username: user.username,
                        url: user.imagePath,
                        isActive: user.isActive,
                      )
                    : Container())
            .toList(),
      );
    });
  }
}

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  void handleSearch(String search) {
    print(search);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300.0),
          child: TextField(
            style: TextStyle(color: textColor.color),
            cursorColor: textColor.color,
            onSubmitted: handleSearch,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: false,
              hintStyle: TextStyle(color: textColor.color),
              suffixIcon: Icon(
                Icons.search,
                color: textColor.color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CurrentUser extends GetView<UserController> {
  const CurrentUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserImage(
      username: controller.user.username,
      isActive: controller.user.isActive,
      url: controller.user.imagePath,
    );
  }
}

final AppBar notLoggedAppBar = AppBar(
  title: const Align(
    alignment: Alignment.centerLeft,
    child: KiwiGamesLogo(),
  ),
);
