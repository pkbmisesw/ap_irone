import 'package:get/get.dart';
import 'package:silahan_kawan/app/modules/article/views/article_view_new.dart';
import 'package:silahan_kawan/app/modules/auth/auth_screen.dart';

import '../modules/article/bindings/article_binding.dart';
import '../modules/article/views/article_view.dart';
import '../modules/article_detail/bindings/article_detail_binding.dart';
import '../modules/article_detail/views/article_detail_view.dart';
import '../modules/auth/login/bindings/login_binding.dart';
import '../modules/auth/login/views/login_view.dart';
import '../modules/auth/register/bindings/register_binding.dart';
import '../modules/auth/register/views/register_view.dart';
import '../modules/auth/register/views/signup_screen.dart';
import '../modules/data_rekap/screen/data_rekap_menu_screen_new.dart';
import '../modules/detail_pkk/bindings/detail_pkk_binding.dart';
import '../modules/detail_pkk/views/detail_pkk_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_admin_kecamatan.dart';
import '../modules/home/views/home_admin_view.dart';
import '../modules/home/views/home_super_admin_view.dart';
import '../modules/home/views/home_user_view.dart';
import '../modules/input_data/bindings/input_data_binding.dart';
import '../modules/input_data/views/input_data_view.dart';
import '../modules/law/bindings/law_binding.dart';
import '../modules/law/views/law_view.dart';
import '../modules/law/views/law_view_new.dart';
import '../modules/letter/bindings/letter_binding.dart';
import '../modules/letter/views/letter_view_new.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_super_admin_view.dart';
import '../modules/main/views/main_user_view.dart';
import '../modules/pdf_viewer/views/pdf_view.dart';
import '../modules/pengurus/bindings/pengurus_binding.dart';
import '../modules/pengurus/views/pengurus_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/data_rekap/screen/data_rekap_screen.dart';
import '../modules/data_rekap/screen/data_rekap_menu_screen_new.dart';
import '../modules/data_umum/screen/data_umum_menu_screen.dart';
import '../modules/data_pokjaa/screen/data_pokjaa_screen.dart';
import '../modules/data_pokjaa/screen/data_pokjaa_menu_screen.dart';
import '../modules/data_pokjac/screen/data_pokjac_screen.dart';
import '../modules/data_pokjab/screen/data_pokjab_menu_screen.dart';
import '../modules/data_pokjad/screen/data_pokjad_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    // GetPage(
    //   name: _Paths.LOGIN,
    //   page: () => const AuthScreen(),
    //   binding: LoginBinding(),
    // ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegistScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_USER,
      page: () => const MainUserView(),
      binding: MainBinding(),
      children: [
        GetPage(
          name: _Paths.HOME,
          page: () => HomeUserView(),
          // binding: HomeBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.MAIN_ADMIN_KEC,
      page: () => HomeAdminKecamatanView(),
      binding: MainBinding(),
      children: [
        GetPage(
          name: _Paths.HOME,
          page: () => HomeUserView(),
          // binding: HomeBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.MAIN_SUPER_ADMIN,
      page: () => const MainSuperAdminView(),
      binding: MainBinding(),
      children: [
        GetPage(
          name: _Paths.HOME,
          page: () => const HomeSuperAdminView(),
          // binding: HomeBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.MAIN_ADMIN,
      page: () => const HomeAdminView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ARTICLE,
      page: () => ArticleViewNew(),
      binding: ArticleBinding(),
    ),
    GetPage(
      name: '${_Paths.ARTICLE}/:id',
      page: () => const ArticleDetailView(),
      binding: ArticleDetailBinding(),
    ),
    GetPage(
      name: _Paths.PENGURUS,
      page: () => const PengurusView(),
      binding: PengurusBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.LETTER,
      page: () => LetterView(),
      binding: LetterBinding(),
    ),
    GetPage(
      name: '${_Paths.LETTER}/:id',
      page: () => const PDFViewer(),
    ),
    GetPage(
      name: _Paths.LAW,
      page: () => const LawView(),
      binding: LawBinding(),
    ),
    GetPage(
      name: '${_Paths.LAW}/:id',
      page: () => const PDFViewer(),
    ),
    GetPage(
      name: _Paths.DETAIL_PKK,
      page: () => DetailPkkView(),
      binding: DetailPkkBinding(),
    ),
    GetPage(
      name: _Paths.INPUT_DATA,
      page: () => const InputDataView(),
      binding: InputDataBinding(),
    ),
    GetPage(
      name: _Paths.DATA_REKAP,
      page: () => const DataRekapScreen(),
    ),
    GetPage(
      name: _Paths.DATA_REKAP_MENU,
      page: () => DataRekapHome(),
    ),
    // GetPage(
    //   name: _Paths.DATA_UMUM,
    //   page: () => DataUmumScreen(),
    // ),
    GetPage(
      name: _Paths.DATA_UMUM_MENU,
      page: () => DataUmumMenuScreen(),
    ),
    GetPage(
      name: _Paths.DATA_POKJAA,
      page: () => DataPokjaaScreen(),
    ),
    GetPage(
      name: _Paths.DATA_POKJAA_MENU,
      page: () => DataPokjaaMenuScreen(),
    ),
    GetPage(
      name: _Paths.DATA_POKJAB,
      page: () => DataPokjabScreen(),
    ),
    GetPage(
      name: _Paths.DATA_POKJAB_MENU,
      page: () => DataPokjabMenuScreen(),
    ),
    GetPage(
      name: _Paths.DATA_POKJAD,
      page: () => DataPokjadScreen(),
    ),
  ];
}
