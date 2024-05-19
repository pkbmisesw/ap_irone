import 'package:irone/app/data/models/auth/login/users_model.dart';
import 'package:irone/app/modules/article/views/article_view.dart';
import 'package:irone/app/modules/article/views/article_view_new.dart';
import 'package:irone/app/modules/home/views/home_user_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_user_controller.dart';

class MainUserView extends GetView<MainUserController> {
  const MainUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as UsersModel?;

    List<Widget> pages = [
      HomeUserView(users: args),
      ArticleViewNew(),
    ];

    List<Widget> itemNavDest = [
      const NavigationDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home_rounded),
        label: 'Home',
      ),
      const NavigationDestination(
        icon: Icon(Icons.event_note_outlined),
        selectedIcon: Icon(Icons.event_note_rounded),
        label: 'Berita',
      ),
      const NavigationDestination(
        icon: Icon(Icons.chat_outlined),
        selectedIcon: Icon(Icons.chat_rounded),
        label: 'Chat',
      ),
      const NavigationDestination(
        icon: Icon(Icons.bubble_chart_outlined),
        selectedIcon: Icon(Icons.bubble_chart_rounded),
        label: 'Struktur',
      ),
      const NavigationDestination(
        icon: Icon(Icons.person_outline),
        selectedIcon: Icon(Icons.person_rounded),
        label: 'Account',
      ),
    ];

    Widget builderBottomNavBar() {
      return Obx(
        () => NavigationBar(
          selectedIndex: controller.indexStack.value,
          destinations: itemNavDest,
          onDestinationSelected: controller.setDestinationSelected,
        ),
      );
    }

    Widget builderNavDrawer() {
      return Obx(
        () => NavigationDrawer(
          selectedIndex: controller.selectedItemNavDrawer.value,
          onDestinationSelected: controller.selectedNavDrawerIndex,
          children: [
            NavigationDrawerDestination(
              icon: const Icon(Icons.notifications_outlined),
              label: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Push Notifikasi'),
                        Text('Aktifkan Notifikasi'),
                      ],
                    ),
                    Switch(
                      value: controller.isActivePushNotifications.value,
                      onChanged: controller.setPushNotifications,
                    ),
                  ],
                ),
              ),
              selectedIcon: const Icon(Icons.notifications_rounded),
            ),
            NavigationDrawerDestination(
              icon: Icon(
                (controller.isDarkMode.value)
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined,
              ),
              label: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Mode Gelap'),
                    Switch(
                      value: controller.isDarkMode.value,
                      onChanged: controller.setDarkMode,
                    ),
                  ],
                ),
              ),
              selectedIcon: Icon(
                (controller.isDarkMode.value)
                    ? Icons.dark_mode_rounded
                    : Icons.light_mode_rounded,
              ),
            ),
            const NavigationDrawerDestination(
              icon: Icon(Icons.help_outline),
              label: Text('Bantuan'),
              selectedIcon: Icon(Icons.help_rounded),
            ),
            const NavigationDrawerDestination(
              icon: Icon(Icons.logout_outlined),
              label: Text('Log Out'),
              selectedIcon: Icon(Icons.logout_rounded),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      key: controller.scaffoldKey,
      body: Obx(
        () => IndexedStack(
          index: controller.indexStack.value,
          children: pages,
        ),
      ),
      bottomNavigationBar: builderBottomNavBar(),
      endDrawer: builderNavDrawer(),
      onEndDrawerChanged: controller.setEndDrawerChanged,
    );
  }
}
