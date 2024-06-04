import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:silahan_kawan/app/data/models/profile/item_profile_model.dart';
import 'package:silahan_kawan/app/shared/shared_theme.dart';
import 'package:silahan_kawan/app/widgets/errors/card_error_item.dart';
import 'package:silahan_kawan/app/widgets/result/result_widget.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    Widget builderItemContact({
      required String assetsImage,
      required String text,
    }) {
      return Card(
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ListTile(
            leading: Image.asset(
              assetsImage,
              width: size.width * 0.1,
            ),
            title: Text(text),
          ),
        ),
      );
    }

    Widget builderProfile(ItemProfileModel itemProfileModel) {
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 32,
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: size.width * 0.2,
                backgroundImage: const AssetImage('assets/img/logo.png'),
              ),
            ),
            const SizedBox(height: 28.0),
            Text(
              'Selamat Datang di Instansi \n${itemProfileModel.nama}',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontFamily: SharedTheme.titleTextStyle,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Text(
              '${itemProfileModel.deskripsi}',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24.0),
            builderItemContact(
              assetsImage: 'assets/ic/ic_call.png',
              text: '${itemProfileModel.kontak}',
            ),
            const SizedBox(height: 2),
            builderItemContact(
              assetsImage: 'assets/ic/ic_email.png',
              text: '${itemProfileModel.email}',
            ),
          ],
        ),
      );
    }

    Widget builderFutureProfile() {
      return FutureBuilder(
        future: controller.getProfile(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.isNotEmpty) {
            return builderProfile(snapshot.data![0]);
          } else if (snapshot.hasError) {
            return Center(
              child: SizedBox(
                height: size.height / 4,
                child: CardErrorItem(
                  onPressed: () => controller.getProfile(),
                ),
              ),
            );
          }

          return ResultWidget.loading();
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: builderFutureProfile(),
    );
  }
}
