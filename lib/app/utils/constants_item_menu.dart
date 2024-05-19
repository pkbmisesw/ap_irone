import 'package:flutter/material.dart';
import 'package:irone/app/data/db/item_menu_db.dart';
import 'package:irone/app/routes/app_pages.dart';
import 'package:remixicon/remixicon.dart';

const listMenuSuperAdmin = [
  ItemMenuDB(
    id: 1,
    title: 'Data Rekap',
    assetsImg: 'assets/ic/dataRekapSuper.png',
    routeName: '',
  ),
  ItemMenuDB(
    id: 2,
    title: 'Data Umum',
    assetsImg: 'assets/ic/dataUmumSuper.png',
    routeName: '',
  ),
  ItemMenuDB(
    id: 3,
    title: 'Data Pokja 1',
    assetsImg: 'assets/ic/dataPokjaaSuper.png',
    routeName: '',
  ),
  ItemMenuDB(
    id: 4,
    title: 'Data Pokja 2',
    assetsImg: 'assets/ic/dataPokjabSuper.png',
    routeName: '',
  ),
  ItemMenuDB(
    id: 5,
    title: 'Data Pokja 3',
    assetsImg: 'assets/ic/dataPokjacSuper.png',
    routeName: '',
  ),
  ItemMenuDB(
    id: 6,
    title: 'Data Pokja 4',
    assetsImg: 'assets/ic/dataPokjadSuper.png',
    routeName: '',
  ),
  ItemMenuDB(
    id: 7,
    title: 'Produk Hukum',
    assetsImg: 'assets/ic/lawimage.png',
    routeName: '',
  ),
  ItemMenuDB(
    id: 8,
    title: 'Surat Keluar',
    assetsImg: 'assets/ic/mailout.png',
    routeName: '',
  ),
  ItemMenuDB(
    id: 9,
    title: 'Surat Masuk',
    assetsImg: 'assets/ic/mailin.png',
    routeName: '',
  ),
];

const listMenuSuperAdminPusat = [
  ItemMenuDB(
    id: 1,
    title: 'Data Rekap',
    assetsImg: 'assets/ic/dataRekapSuper.png',
    routeName: '',
  ),
  ItemMenuDB(
    id: 2,
    title: 'Data Umum',
    assetsImg: 'assets/ic/dataUmumSuper.png',
    routeName: '',
  ),
  ItemMenuDB(
    id: 3,
    title: 'Data Pokja 1',
    assetsImg: 'assets/ic/dataPokjaaSuper.png',
    routeName: '',
  ),
  ItemMenuDB(
    id: 4,
    title: 'Data Pokja 2',
    assetsImg: 'assets/ic/dataPokjabSuper.png',
    routeName: '',
  ),
  ItemMenuDB(
    id: 5,
    title: 'Data Pokja 3',
    assetsImg: 'assets/ic/dataPokjacSuper.png',
    routeName: '',
  ),
  ItemMenuDB(
    id: 6,
    title: 'Data Pokja 4',
    assetsImg: 'assets/ic/dataPokjadSuper.png',
    routeName: '',
  ),
  // ItemMenuDB(
  //   id: 7,
  //   title: 'Produk Hukum',
  //   assetsImg: 'assets/ic/lawimage.png',
  //   routeName: '',
  // ),
  // ItemMenuDB(
  //   id: 8,
  //   title: 'Surat Keluar',
  //   assetsImg: 'assets/ic/mailout.png',
  //   routeName: '',
  // ),
  // ItemMenuDB(
  //   id: 9,
  //   title: 'Surat Masuk',
  //   assetsImg: 'assets/ic/mailin.png',
  //   routeName: '',
  // ),
];

const listMenuAdmin = [
  // ItemMenuDB(
  //   id: 1,
  //   title: 'Input Data',
  //   icon: Icons.data_saver_off_rounded,
  //   routeName: Routes.INPUT_DATA,
  // ),
  // ItemMenuDB(
  //   id: 1,
  //   title: 'DRekap',
  //   imagePath: 'assets/ic/ic_rekapa.png',
  //   routeName: Routes.INPUT_DATA,
  // ),

  ItemMenuDB(
    id: 1,
    title: 'DRekap',
    imagePath: 'assets/ic/drekap.png',
    routeName: '',
  ),

  ItemMenuDB(
    id: 2,
    title: 'DUmum',
    imagePath: 'assets/ic/dumum.png',
    routeName: '',
  ),
  ItemMenuDB(
    id: 3,
    title: 'Pokja 1',
    imagePath: 'assets/ic/pokja1.png',
    routeName: '',
  ),
  ItemMenuDB(
    id: 4,
    title: 'Pokja 2',
    imagePath: 'assets/ic/pokja2.png',
    routeName: '',
  ),
  ItemMenuDB(
    id: 5,
    title: 'Pokja 3',
    imagePath: 'assets/ic/pokja3.png',
    routeName: '',
  ),
  ItemMenuDB(
    id: 6,
    title: 'Pokja 4',
    imagePath: 'assets/ic/pokja4.png',
    routeName: '',
  ),
  ItemMenuDB(
    id: 9,
    title: 'Logout',
    imagePath: 'assets/ic/logout.png',
    routeName: '',
  ),
];

final listMenuUser = [
  const ItemMenuDB(
    id: 1,
    title: 'Profile',
    assetsImg: 'assets/img/logo.png',
    routeName: Routes.PROFILE,
  ),
  const ItemMenuDB(
    id: 2,
    title: 'Pengurus',
    assetsImg: 'assets/ic/ic_team.png',
    routeName: Routes.PENGURUS,
  ),
  const ItemMenuDB(
    id: 3,
    title: 'DC Digital',
    assetsImg: 'assets/ic/ic_letter.png',
  ),
  const ItemMenuDB(
    id: 4,
    title: 'Data PKK',
    assetsImg: 'assets/ic/ic_structure.png',
    image: 'assets/img/banner/banner_3.jpg',
  ),
  const ItemMenuDB(
    id: 5,
    title: 'Produk Hukum',
    assetsImg: 'assets/ic/ic_law.png',
    // routeName: Routes.LAW,
  ),
  const ItemMenuDB(
    id: 6,
    title: 'Posyandu',
    assetsImg: 'assets/ic/ic_information.png',
  ),
  const ItemMenuDB(
    id: 7,
    title: 'Capaian Program',
    assetsImg: 'assets/ic/ic_data.png',
    image: 'assets/img/pencapaian.png',
  ),
  const ItemMenuDB(
    id: 8,
    title: 'Prestasi',
    assetsImg: 'assets/ic/ic_events.png',
    image: 'assets/img/prestasi.jpg',
  ),
];

const listMenuKecamatan = [
  ItemMenuDB(
    id: 1,
    title: 'DRekap',
    imagePath: 'assets/ic/kecRekap.png',
    routeName: '',
  ),
  ItemMenuDB(
    id: 2,
    title: 'DUmum',
    imagePath: 'assets/ic/kecUmum.png',
    routeName: '',
  ),
  ItemMenuDB(
    id: 3,
    title: 'Pokja 1',
    imagePath: 'assets/ic/kecPokja1.png',
    routeName: '',
  ),
  ItemMenuDB(
    id: 4,
    title: 'Pokja 2',
    imagePath: 'assets/ic/kecPokja2.png',
    routeName: '',
  ),
  ItemMenuDB(
    id: 5,
    title: 'Pokja 3',
    imagePath: 'assets/ic/kecPokja3.png',
    routeName: '',
  ),
  ItemMenuDB(
    id: 6,
    title: 'Pokja 4',
    imagePath: 'assets/ic/kecPokja4.png',
    routeName: '',
  ),
  ItemMenuDB(
    id: 9,
    title: 'Logout',
    imagePath: 'assets/ic/kecLogout.png',
    routeName: '',
  ),
];
