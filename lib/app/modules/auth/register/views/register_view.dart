import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silahan_kawan/app/modules/auth/register/controllers/register_controller.dart';
import 'package:silahan_kawan/app/shared/cards.dart';
import 'package:silahan_kawan/app/widgets/textformfield/custom_text_from_field.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

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
            controller.appName,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      );
    }

    Widget builderNameInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Nama Lengkap',
            style: theme.textTheme.labelLarge,
          ),
          const SizedBox(height: 12),
          CustomTextFormField(
            controller: controller.namaC,
            hintText: 'Example Name',
            prefixIcon: const Icon(Icons.person_rounded),
            suffixIcon: Obx(
              () => (controller.nama.value.isNotEmpty)
                  ? IconButton(
                      onPressed: () => controller.namaC.clear(),
                      icon: const Icon(Icons.cancel_rounded),
                    )
                  : const SizedBox(),
            ),
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: controller.validatorNama,
          ),
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
            hintText: 'example@gmail.com',
            prefixIcon: const Icon(Icons.email_rounded),
            suffixIcon: Obx(
              () => (controller.email.value.isNotEmpty)
                  ? IconButton(
                      onPressed: () => controller.emailC.clear(),
                      icon: const Icon(Icons.cancel_rounded),
                    )
                  : const SizedBox(),
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
            builderNameInput(),
            const SizedBox(height: 16),
            builderEmailInput(),
            const SizedBox(height: 16),
            builderPasswordInput(),
          ],
        ),
      );
    }

    Widget builderRegisterButton() {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: double.infinity,
          maxWidth: double.infinity,
          minHeight: size.height / 16,
        ),
        child: Obx(
          () => FilledButton(
            onPressed: () => controller.checkRegisterData(theme),
            child: (controller.isLoading.value)
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: theme.colorScheme.surface,
                    ),
                  )
                : const Text(
                    'Daftar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      );
    }

    Widget builderLoginButton() {
      return TextButton(
        onPressed: () => controller.moveToLogin(),
        child: Text(
          'Sudauh punya akun? Login',
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
            children: [
              builderFormTextField(),
              const SizedBox(height: 32),
              builderRegisterButton(),
              const SizedBox(height: 32),
              builderLoginButton(),
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
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
