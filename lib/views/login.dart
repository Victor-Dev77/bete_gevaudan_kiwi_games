import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/controllers/controllers.dart';
import 'package:kiwigames/shared/shared.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = MediaQuery.of(context).size.width <= 700.0
        ? const MobileLogin()
        : const DesktopLogin();
    return Scaffold(
      appBar: notLoggedAppBar,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 50.0, bottom: 25.0),
        child: child,
      ),
    );
  }
}

class MobileLogin extends StatelessWidget {
  const MobileLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CatchPhrase(),
        HeightSpacer(50.0),
        LoginForm(),
      ],
    );
  }
}

class DesktopLogin extends StatelessWidget {
  const DesktopLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Flexible(child: CatchPhrase()),
        Flexible(child: LoginForm()),
      ],
    );
  }
}

class LoginForm extends GetView<LoginController> {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: const [
              _PseudoInput(),
              HeightSpacer(25.0),
              _PasswordInput(),
              HeightSpacer(20.0),
              _RememberMeForgotPassword(),
              HeightSpacer(50.0),
              _LoginRegister(),
              /* HeightSpacer(60.0),
              OrConnectWith(),
              HeightSpacer(70.0),
              OAuthRow(), */
            ],
          ),
        ),
      ),
    );
  }
}

class _PseudoInput extends GetView<LoginController> {
  const _PseudoInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.pseudoController,
      validator: (e) => e!.trim().isNotEmpty ? null : 'no_pseudo'.tr,
      decoration: InputDecoration(
        labelText: 'pseudo'.tr,
      ),
    );
  }
}

class _PasswordInput extends GetView<LoginController> {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueBuilder<bool?>(
      initialValue: true,
      builder: (obscureText, updater) => TextFormField(
        controller: controller.passwordController,
        obscureText: obscureText!,
        validator: (e) => e!.trim().isNotEmpty ? null : 'no_password'.tr,
        decoration: InputDecoration(
          labelText: 'password'.tr,
          suffixIcon: IconButton(
            onPressed: () => updater(!obscureText),
            icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
          ),
        ),
      ),
    );
  }
}

class _RememberMeForgotPassword extends GetView<LoginController> {
  const _RememberMeForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Axis direction;
    MainAxisAlignment mainAxisAlignment;
    CrossAxisAlignment crossAxisAlignment;
    Widget spacer;
    if (MediaQuery.of(context).size.width <= 400) {
      direction = Axis.vertical;
      mainAxisAlignment = MainAxisAlignment.center;
      crossAxisAlignment = CrossAxisAlignment.center;
      spacer = const HeightSpacer(10.0);
    } else {
      direction = Axis.horizontal;
      mainAxisAlignment = MainAxisAlignment.spaceBetween;
      crossAxisAlignment = CrossAxisAlignment.center;
      spacer = Container();
    }
    return Flex(
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Transform.translate(
          offset: const Offset(-10.0, 0),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  onChanged: controller.rememberMe,
                  value: controller.rememberMe(),
                ),
                InteractiveText(
                  text: 'remember_me'.tr,
                  function: () => controller.rememberMe.toggle(),
                  color: dividerColor.color,
                ),
              ],
            ),
          ),
        ),
        spacer,
        InteractiveText(
          text: 'forgotten_password'.tr,
          function: () => Get.toNamed('/forgot-password'),
        ),
      ],
    );
  }
}

class _LoginRegister extends GetView<LoginController> {
  static final buttonPadding = MaterialStateProperty.all(
    const EdgeInsets.symmetric(vertical: 25.0),
  );

  const _LoginRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.loading()) {
        return const Center(child: CircularProgressIndicator());
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
              child: Text('log_in'.tr.toUpperCase()),
              onPressed: controller.login,
              style: Get.theme.elevatedButtonTheme.style?.copyWith(
                padding: buttonPadding,
              ),
            ),
          ),
          spacer,
          Expanded(
            flex: flex,
            child: OutlinedButton(
              child: Text('register'.tr.toUpperCase()),
              onPressed: () => Get.toNamed('/register'),
              style: Get.theme.outlinedButtonTheme.style?.copyWith(
                padding: buttonPadding,
              ),
            ),
          ),
        ],
      );
    });
  }
}

class OrConnectWith extends StatelessWidget {
  const OrConnectWith({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        const WidthSpacer(25.0),
        Text(
          'or_connect_with'.tr,
          style: Get.textTheme.bodyText1?.copyWith(color: dividerColor.color),
        ),
        const WidthSpacer(25.0),
        const Expanded(child: Divider()),
      ],
    );
  }
}

class OAuthRow extends StatelessWidget {
  const OAuthRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        FlutterLogo(size: 65.0),
        WidthSpacer(80.0),
        FlutterLogo(size: 65.0),
      ],
    );
  }
}
