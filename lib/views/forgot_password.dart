import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:kiwigames/controllers/controllers.dart';
import 'package:kiwigames/shared/shared.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: notLoggedAppBar,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 50.0, bottom: 25.0),
        child: MediaQuery.of(context).size.width <= 700
            ? const MobileForgotPassword()
            : const DesktopForgotPassword(),
      ),
    );
  }
}

class MobileForgotPassword extends StatelessWidget {
  const MobileForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CatchPhrase(),
        HeightSpacer(50.0),
        ForgotPasswordForm(),
      ],
    );
  }
}

class DesktopForgotPassword extends StatelessWidget {
  const DesktopForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Flexible(child: CatchPhrase()),
        Flexible(child: ForgotPasswordForm()),
      ],
    );
  }
}

class ForgotPasswordForm extends GetView<ForgotPasswordController> {
  const ForgotPasswordForm({Key? key}) : super(key: key);

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
              HeightSpacer(50.0),
              _LoginReset(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends GetView<ForgotPasswordController> {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (e) => GetUtils.isEmail(e!.trim()) ? null : 'not_an_email'.tr,
      decoration: InputDecoration(labelText: 'email'.tr),
    );
  }
}

class _LoginReset extends GetView<ForgotPasswordController> {
  static final buttonPadding = MaterialStateProperty.all(
    const EdgeInsets.symmetric(vertical: 25.0),
  );

  const _LoginReset({Key? key}) : super(key: key);

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
            child: OutlinedButton(
              child: Text('log_in'.tr.toUpperCase()),
              onPressed: () => Get.offAllNamed('/login'),
              style: Get.theme.outlinedButtonTheme.style?.copyWith(
                padding: buttonPadding,
              ),
            ),
          ),
          spacer,
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
        ],
      );
    });
  }
}
