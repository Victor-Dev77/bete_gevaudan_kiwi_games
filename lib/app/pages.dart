import 'package:get/get.dart';
import 'package:kiwigames/bindings/bindings.dart';
import 'package:kiwigames/middlewares/middlewares.dart';
import 'package:kiwigames/views/lobby.dart';
import 'package:kiwigames/views/master_screen.dart';
import 'package:kiwigames/views/views.dart';

class AppPages {
  final GetPage notFoundPage = GetPage(
    name: '/not-found',
    page: () => const NotFound(),
  );

  final List<GetPage> appPages = [
    GetPage(
      name: '/',
      page: () => const Home(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: '/browse',
      page: () => const Browse(),
      bindings: [TabBarBinding(), BrowseBinding()],
      middlewares: [BrowseMiddleWare()],
    ),
    GetPage(
      name: '/login',
      page: () => const Login(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: '/register',
      page: () => const Register(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: '/join-lobby',
      page: () => const JoinLobby(),
      binding: JoinLobbyBinding(),
    ),
    GetPage(
      name: '/master-screen',
      page: () => const MasterScreen(),
    ),
    GetPage(
      name: '/lobby',
      page: () => const Lobby(),
      binding: LobbyBinding(),
    ),
    GetPage(
      name: '/forgot-password',
      page: () => const ForgotPassword(),
      binding: ForgotPasswordBinding(),
    ),
  ];
}
