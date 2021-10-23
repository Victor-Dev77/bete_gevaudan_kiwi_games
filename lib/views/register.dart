import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:kiwigames/controllers/controllers.dart';
import 'package:kiwigames/shared/shared.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: notLoggedAppBar,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 50.0, bottom: 25.0),
        child: MediaQuery.of(context).size.width <= 700.0
            ? const MobileRegister()
            : const DesktopRegister(),
      ),
    );
  }
}

class MobileRegister extends StatelessWidget {
  const MobileRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CatchPhrase(),
        HeightSpacer(50.0),
        RegisterForm(),
      ],
    );
  }
}

class DesktopRegister extends StatelessWidget {
  const DesktopRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Flexible(child: CatchPhrase()),
        Flexible(child: RegisterForm()),
      ],
    );
  }
}

class RegisterForm extends GetView<RegisterController> {
  const RegisterForm({Key? key}) : super(key: key);

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
              _EmailInput(),
              HeightSpacer(25.0),
              _PseudoInput(),
              HeightSpacer(25.0),
              _PasswordInput(),
              HeightSpacer(25.0),
              _ConfirmPassword(),
              HeightSpacer(25.0),
              _TelephoneInput(),
              HeightSpacer(50.0),
              _Loginregister(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends GetView<RegisterController> {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.emailController,
      decoration: InputDecoration(labelText: 'email'.tr),
    );
  }
}

class _PseudoInput extends GetView<RegisterController> {
  const _PseudoInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.pseudoController,
      decoration: InputDecoration(labelText: 'pseudo'.tr),
    );
  }
}

class _PasswordInput extends GetView<RegisterController> {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueBuilder<bool?>(
      initialValue: true,
      builder: (obscureText, updater) => TextFormField(
        controller: controller.passwordController,
        obscureText: obscureText!,
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

class _ConfirmPassword extends GetView<RegisterController> {
  const _ConfirmPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueBuilder<bool?>(
      initialValue: true,
      builder: (obscureText, updater) => TextFormField(
        controller: controller.confirmPasswordController,
        obscureText: obscureText!,
        decoration: InputDecoration(
          labelText: 'confirm_password'.tr,
          suffixIcon: IconButton(
            onPressed: () => updater(!obscureText),
            icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
          ),
        ),
      ),
    );
  }
}

class _TelephoneInput extends GetView<RegisterController> {
  static final labelStyle = Get.theme.inputDecorationTheme.labelStyle;

  const _TelephoneInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.telephoneController,
      decoration: InputDecoration(
        label: RichText(
          text: TextSpan(
            style: labelStyle,
            children: [
              TextSpan(
                text: 'telephone'.tr,
              ),
              TextSpan(
                text: 'optionnal'.tr,
                style: labelStyle?.copyWith(
                  color: labelColor.color.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Loginregister extends StatelessWidget {
  static final buttonPadding = MaterialStateProperty.all(
    const EdgeInsets.symmetric(vertical: 25.0),
  );

  const _Loginregister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          child: OutlinedButton(
            child: Text('log_in'.tr.toUpperCase()),
            onPressed: () => back('/login'),
            style: Get.theme.outlinedButtonTheme.style?.copyWith(
              padding: buttonPadding,
            ),
          ),
        ),
        spacer,
        Expanded(
          flex: flex,
          child: ElevatedButton(
            child: Text('register'.tr.toUpperCase()),
            onPressed: () => print('register'),
            style: Get.theme.elevatedButtonTheme.style?.copyWith(
              padding: buttonPadding,
            ),
          ),
        ),
      ],
    );
  }
}
