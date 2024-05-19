import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:irone/app/modules/auth/login/controllers/login_controller.dart';
import 'package:irone/app/shared/cards.dart';
import 'package:irone/app/widgets/textformfield/custom_text_from_field.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    Widget builderHead() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/img/logo.png',
            width: size.width / 3.5,
          ),
          const SizedBox(height: 32),
          Text(
            // controller.appName,
            'PKK BITUNG DIGITAL V2',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )
        ],
      );
    }

    Widget builderEmailInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Email Address',
            style: theme.textTheme.labelLarge,
          ),
          const SizedBox(height: 12),
          CustomTextFormField(
            controller: controller.emailC,
            hintText: 'email@gmail.com',
            prefixIcon: const Icon(Icons.email_rounded),
            suffixIcon: Obx(
              () => (controller.email.value.isNotEmpty)
                  ? IconButton(
                      onPressed: () => controller.emailC.clear(),
                      icon: const Icon(Icons.cancel_rounded),
                    )
                  : const SizedBox(
                      width: 0,
                      height: 0,
                    ),
            ),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: controller.validatorEmail,
          ),
        ],
      );
    }

    Widget builderPasswordInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Password',
            style: theme.textTheme.labelLarge,
          ),
          const SizedBox(height: 12),
          Obx(
            () => CustomTextFormField(
              controller: controller.passwordC,
              hintText: '*******',
              prefixIcon: const Icon(Icons.lock_rounded),
              suffixIcon: IconButton(
                onPressed: () => controller.setObscure(),
                icon: Icon(
                  (controller.isObscure.value)
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                ),
              ),
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              validator: controller.validatorPassword,
              obscureText: controller.isObscure.value,
            ),
          ),
        ],
      );
    }

    Widget builderFormTextField() {
      return Form(
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            builderEmailInput(),
            const SizedBox(height: 16),
            builderPasswordInput(),
          ],
        ),
      );
    }

    Widget builderLoginButton() {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: double.infinity,
          maxWidth: double.infinity,
          minHeight: size.height / 16,
        ),
        child: Obx(
          () => FilledButton(
            onPressed: () => controller.checkIsUserExist(theme),
            child: (controller.isLoading.value)
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: theme.colorScheme.surface,
                    ),
                  )
                : const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      );
    }

    Widget builderRegisterButton() {
      return TextButton(
        onPressed: () => controller.moveToRegister(),
        child: Text(
          'Belum punya akun? Daftar',
          style: theme.textTheme.labelLarge?.copyWith(color: Colors.white),
        ),
      );
    }

    Widget builderAuth() {
      return Cards.filled(
        context: context,
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 32,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              builderFormTextField(),
              const SizedBox(height: 32),
              builderLoginButton(),
              const SizedBox(height: 32),
              builderRegisterButton(),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/pkk_img2.webp'),
              fit: BoxFit.cover,
              opacity: 0.7,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  builderHead(),
                  const SizedBox(height: 4),
                  builderAuth(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
