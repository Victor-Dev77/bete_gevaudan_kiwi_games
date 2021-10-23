import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/controllers/controllers.dart';
import 'package:kiwigames/shared/shared.dart';

class JoinLobby extends StatelessWidget {
  const JoinLobby({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: notLoggedAppBar,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(25.0, 100.0, 25.0, 25.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600.0),
            child: const JoinLobbyForm(),
          ),
        ),
      ),
    );
  }
}

class JoinLobbyForm extends GetView<JoinLobbyController> {
  const JoinLobbyForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('join_lobby'.tr, style: Get.textTheme.headline5),
          const HeightSpacer(50.0),
          if (controller.isGuest) ...const [_PseudoInput(), HeightSpacer(25.0)],
          const _LobbyCodeInput(),
          const HeightSpacer(40.0),
          const _JoinLogin(),
        ],
      ),
    );
  }
}

class _PseudoInput extends GetView<JoinLobbyController> {
  const _PseudoInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.pseudoController,
      decoration: InputDecoration(labelText: 'pseudo'.tr),
    );
  }
}

class _LobbyCodeInput extends GetView<JoinLobbyController> {
  const _LobbyCodeInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.lobbyCodeController,
      decoration: InputDecoration(labelText: 'lobby_code'.tr),
    );
  }
}

class _JoinLogin extends GetView<JoinLobbyController> {
  static final buttonPadding = MaterialStateProperty.all(
    const EdgeInsets.symmetric(vertical: 25.0),
  );

  const _JoinLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.loading()) {
        return const CircularProgressIndicator();
      }
      Widget spacer;
      Axis direction;
      CrossAxisAlignment crossAxisAlignment;
      int flex;
      if (MediaQuery.of(context).size.width <= 500.0) {
        spacer = const HeightSpacer(15.0);
        direction = Axis.vertical;
        crossAxisAlignment = CrossAxisAlignment.stretch;
        flex = 0;
      } else {
        spacer = const WidthSpacer(25.0);
        direction = Axis.horizontal;
        crossAxisAlignment = CrossAxisAlignment.center;
        flex = 1;
      }
      return Flex(
        direction: direction,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Expanded(
            flex: flex,
            child: ElevatedButton(
              child: Text('join'.tr.toUpperCase()),
              onPressed: controller.joinLobby,
              style: Get.theme.elevatedButtonTheme.style?.copyWith(
                padding: buttonPadding,
              ),
            ),
          ),
          spacer,
          Expanded(
            flex: flex,
            child: OutlinedButton(
              child: Text('log_in'.tr.toUpperCase()),
              onPressed: () => back('/login'),
              style: Get.theme.outlinedButtonTheme.style?.copyWith(
                padding: buttonPadding,
              ),
            ),
          )
        ],
      );
    });
  }
}
