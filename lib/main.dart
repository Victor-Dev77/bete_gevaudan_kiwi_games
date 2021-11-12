import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kiwigames/app/app.dart';
import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';

void main() async {
  configureApp(); 
  await GetStorage.init(); 
  Paint.enableDithering = true;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Kiwigames());
}

class Kiwigames extends StatelessWidget {
  static final AppTheme appTheme = AppTheme();
  static final AppPages appPages = AppPages();

  const Kiwigames({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kiwigames',
      translations: Messages(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('fr', 'FR'),
      theme: appTheme.primaryTheme,
      unknownRoute: appPages.notFoundPage,
      getPages: appPages.appPages,
      initialRoute: '/',
      defaultTransition: Transition.fadeIn,
    );
  }
}
