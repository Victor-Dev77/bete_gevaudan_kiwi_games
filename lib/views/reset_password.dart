import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/controllers/controllers.dart';
import 'package:kiwigames/shared/shared.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: notLoggedAppBar,
      body: GetBuilder<ResetPasswordController>(
        builder: (c) {
          if (c.code == null || c.code!.isEmpty) {
            return const Center(child: _NoIdFound());
          }
          return const SingleChildScrollView(
            padding: EdgeInsets.only(top: 50.0, bottom: 25.0),
            child: ResetPasswordForm(),
          );
        },
      ),
    );
  }
}

class _NoIdFound extends StatelessWidget {
  const _NoIdFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('no_id_found'.tr),
        const HeightSpacer(25.0),
        ElevatedButton(
          child: Text('forgotten_password'.tr),
          onPressed: () => Get.offAllNamed('/forgot-password'),
        ),
      ],
    );
  }
}

class ResetPasswordForm extends GetView<ResetPasswordController> {
  const ResetPasswordForm({Key? key}) : super(key: key);

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              ResetPasswordText(),
              HeightSpacer(50.0),
              _NewPasswordInput(),
              HeightSpacer(25.0),
              _ConfirmNewPasswordInput(),
              HeightSpacer(40.0),
              _ResetLogin(),
            ],
          ),
        ),
      ),
    );
  }
}

class ResetPasswordText extends StatelessWidget {
  const ResetPasswordText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'reset_password'.tr,
      style: Get.textTheme.headline5,
    );
  }
}

class _NewPasswordInput extends GetView<ResetPasswordController> {
  const _NewPasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueBuilder<bool?>(
      initialValue: true,
      builder: (obscureText, updater) => TextFormField(
        controller: controller.newPasswordController,
        validator: (e) => e!.trim().isEmpty ? 'no_password'.tr : null,
        obscureText: obscureText!,
        decoration: InputDecoration(
          labelText: 'new_password'.tr,
          suffixIcon: IconButton(
            onPressed: () => updater(!obscureText),
            icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
          ),
        ),
      ),
    );
  }
}

class _ConfirmNewPasswordInput extends GetView<ResetPasswordController> {
  const _ConfirmNewPasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueBuilder<bool?>(
      initialValue: true,
      builder: (obscureText, updater) => TextFormField(
        controller: controller.confirmNewPasswordController,
        obscureText: obscureText!,
        decoration: InputDecoration(
          labelText: 'confirm_new_password'.tr,
          suffixIcon: IconButton(
            onPressed: () => updater(!obscureText),
            icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
          ),
        ),
        validator: (e) => e!.trim().isEmpty
            ? 'no_password'.tr
            : e.trim() != controller.newPassword
                ? 'please_confirm_new_password'.tr
                : null,
      ),
    );
  }
}

class _ResetLogin extends GetView<ResetPasswordController> {
  static final buttonPadding = MaterialStateProperty.all(
    const EdgeInsets.symmetric(vertical: 25.0),
  );

  const _ResetLogin({Key? key}) : super(key: key);

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
              child: Text('reset'.tr.toUpperCase()),
              onPressed: controller.resetPassword,
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
              onPressed: () => Get.offAllNamed('/login'),
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
