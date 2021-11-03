import 'package:kiwigames/games/bete_du_gevaudan/bindings/app_binding.dart';
import 'package:kiwigames/games/bete_du_gevaudan/bindings/distrib_role_binding.dart';
import 'package:kiwigames/games/bete_du_gevaudan/bindings/roles/loup_role_binding.dart';
import 'package:kiwigames/games/bete_du_gevaudan/bindings/roles/male_alpha_role_binding.dart';
import 'package:kiwigames/games/bete_du_gevaudan/bindings/roles/marieuse_role_binding.dart';
import 'package:kiwigames/games/bete_du_gevaudan/bindings/roles/medium_role_binding.dart';
import 'package:kiwigames/games/bete_du_gevaudan/bindings/roles/protecteur_role_binding.dart';
import 'package:kiwigames/games/bete_du_gevaudan/bindings/roles/sorciere_role_binding.dart';
import 'package:kiwigames/games/bete_du_gevaudan/bindings/sleep_binding.dart';
import 'package:kiwigames/games/bete_du_gevaudan/bindings/vote_binding.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/distrib_role/distrib_role_page.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/end_game/end_game_page.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_dead_page.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/roles/loup/loup_role_sleep_page.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/roles/loup/loup_role_wake_page.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/roles/male_alpha/male_alpha_role_sleep_page.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/roles/male_alpha/male_alpha_role_wake_page.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/roles/marieuse/marieuse_role_sleep_page.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/roles/marieuse/marieuse_role_wake_page.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/roles/medium/medium_role_sleep_page.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/roles/medium/medium_role_wake_page.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/roles/protecteur/protecteur_role_sleep_page.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/roles/protecteur/protecteur_role_wake_page.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/roles/sorciere/sorciere_role_sleep_page.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/roles/sorciere/sorciere_role_wake_page.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/rules/rules_page.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/sleep/sleep_page.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/vote/vote_page.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/wake/wake_page.dart';
import 'package:get/get.dart';
part './app_routes.dart';

class BeteDuGevaudanPages {
  static final beteDuGevaudanRoutes = [
    GetPage(
      name: Routes.RULES,
      page: () => RulesPage(),
      binding: AppBinding(),
    ),
    GetPage(
        name: Routes.DISTRIB_ROLE,
        page: () => DistribRolePage(),
        binding: DistribRoleBinding()),
    GetPage(
        name: Routes.SLEEP, page: () => SleepPage(), binding: SleepBinding()),

    // #################
    // ROLES
    // #################
    GetPage(
        name: Routes.MARIEUSE_ROLE_WAKE,
        page: () => MarieuseRoleWakePage(),
        binding: MarieuseRoleBinding()),
    GetPage(
        name: Routes.MARIEUSE_ROLE_SLEEP,
        page: () => MarieuseRoleSleepPage(),
        binding: MarieuseRoleBinding()),

    GetPage(
        name: Routes.MEDIUM_ROLE_WAKE,
        page: () => MediumRoleWakePage(),
        binding: MediumRoleBinding()),
    GetPage(
        name: Routes.MEDIUM_ROLE_SLEEP,
        page: () => MediumRoleSleepPage(),
        binding: MediumRoleBinding()),

    GetPage(
        name: Routes.MALE_ALPHA_ROLE_WAKE,
        page: () => MaleAlphaRoleWakePage(),
        binding: MaleAlphaRoleBinding()),
    GetPage(
        name: Routes.MALE_ALPHA_ROLE_SLEEP,
        page: () => MaleAlphaRoleSleepPage(),
        binding: MaleAlphaRoleBinding()),

    GetPage(
        name: Routes.PROTECTEUR_ROLE_WAKE,
        page: () => ProtecteurRoleWakePage(),
        binding: ProtecteurRoleBinding()),
    GetPage(
        name: Routes.PROTECTEUR_ROLE_SLEEP,
        page: () => ProtecteurRoleSleepPage(),
        binding: ProtecteurRoleBinding()),

    GetPage(
        name: Routes.LOUP_ROLE_WAKE,
        page: () => LoupRoleWakePage(),
        binding: LoupRoleBinding()),
    GetPage(
        name: Routes.LOUP_ROLE_SLEEP,
        page: () => LoupRoleSleepPage(),
        binding: LoupRoleBinding()),

    GetPage(
        name: Routes.SORCIERE_ROLE_WAKE,
        page: () => SorciereRoleWakePage(),
        binding: SorciereRoleBinding()),
    GetPage(
        name: Routes.SORCIERE_ROLE_SLEEP,
        page: () => SorciereRoleSleepPage(),
        binding: SorciereRoleBinding()),

    // #################
    // #################

    GetPage(
      name: Routes.WAKE,
      page: () => WakePage(),
    ),
    GetPage(
      name: Routes.VOTE,
      page: () => VotePage(),
      binding: VoteBinding(),
    ),

    GetPage(
      name: Routes.PLAYER_DEAD,
      page: () => PlayerDeadPage(),
    ),

    GetPage(
      name: Routes.END_GAME,
      page: () => EndGamePage(),
    ),
  ];
}
