import 'package:irone/app/data/models/auth/login/users_model.dart';
import 'package:irone/app/modules/article/views/article_view_new.dart';
import 'package:irone/app/modules/home/views/home_super_admin_view.dart';
import 'package:irone/app/modules/main/controllers/main_super_admin_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class MainSuperAdminView extends GetView<MainAdminController> {
  const MainSuperAdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as UsersModel?;

    RxList<Widget> pages = <Widget>[
      HomeSuperAdminView(users: args),
      ArticleViewNew(),
    ].obs;

    List<Widget> itemNavDest = [
      const NavigationDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home_rounded),
        label: 'Home',
      ),
      const NavigationDestination(
        icon: Icon(Icons.event_note_outlined),
        selectedIcon: Icon(Icons.event_note_rounded),
        label: 'History',
      ),
      const SizedBox(width: 2),
      const NavigationDestination(
        icon: Icon(Icons.info_outlined),
        selectedIcon: Icon(Icons.info_rounded),
        label: 'Info',
      ),
      const NavigationDestination(
        icon: Icon(Icons.support_agent_outlined),
        selectedIcon: Icon(Icons.abc),
        label: 'Customer Service',
      ),
    ];

    Widget builderBottomNavBar() {
      return Obx(
        () => NavigationBar(
          selectedIndex: controller.indexStack.value,
          destinations: itemNavDest,
          onDestinationSelected: controller.setDestinationSelected,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        ),
      );
    }

    return Scaffold(
      body: Obx(() => IndexedStack(
            index: controller.indexStack.value,
            children: pages,
          )),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          margin: const EdgeInsets.only(bottom: 28),
          decoration: const BoxDecoration(
            // color: theme.colorScheme.surface,
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          child: FloatingActionButton(
            onPressed: () {},
            shape: const CircleBorder(),
            child: const Icon(Icons.grid_view_rounded),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: builderBottomNavBar(),
    );
  }
}
