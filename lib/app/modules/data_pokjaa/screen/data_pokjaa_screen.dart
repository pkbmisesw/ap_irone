import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:silahan_kawan/app/utils/local_db.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(DataPokjaaScreen());
}

class MenuItem {
  final int id;
  final String namaLing;
  final int j_pkbn;
  final int j_pkdrt;
  final int pola;
  final int p_pkbn_sim;
  final int p_pkbn_anggota;
  final int p_pkdrt_sim;
  final int p_pkdrt_anggota;
  final int pola_kel;
  final int pola_anggota;
  final int lansia_kel;
  final int lansia_anggota;
  final int g_jum_ker;
  final int g_jum_ruk;
  final int g_jum_agama;
  final int g_jum_jimpit;
  final int g_jum_arisan;

  MenuItem({
    required this.id,
    required this.namaLing,
    required this.j_pkbn,
    required this.j_pkdrt,
    required this.pola,
    required this.p_pkbn_sim,
    required this.p_pkbn_anggota,
    required this.p_pkdrt_sim,
    required this.p_pkdrt_anggota,
    required this.pola_kel,
    required this.pola_anggota,
    required this.lansia_kel,
    required this.lansia_anggota,
    required this.g_jum_ker,
    required this.g_jum_ruk,
    required this.g_jum_agama,
    required this.g_jum_jimpit,
    required this.g_jum_arisan,
  });
}

class DataPokjaaScreen extends StatefulWidget {
  @override
  _DataPokjaaScreenState createState() => _DataPokjaaScreenState();
}

class _DataPokjaaScreenState extends State<DataPokjaaScreen> {
  late SharedPreferences _prefs;
  int _idKel = 0; // Nilai awal

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  void _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _loadIdKel();
  }

  void _loadIdKel() {
    final getData = _prefs.getString(LocalDb.keyCredential);

    if (getData != null) {
      final idKelFromPrefs = jsonDecode(getData)['users']['id_kel'];
      setState(() {
        _idKel = idKelFromPrefs;
      });
    }
  }

  String _loadName() {
    try {
      final getData = _prefs.getString(LocalDb.keyCredential);

      if (getData != null) {
        return jsonDecode(getData)['users']['nama'];
      }
      return "";
    } catch (e) {
      return "";
    }
  }

  Future<void> _saveIdKel(int idKel) async {
    await _prefs.setInt('id_kel', idKel);
    setState(() {
      _idKel = idKel;
    });
  }

  Future<List<MenuItem>> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://app2.tppkk-bitung.com/api/view-barang-rekap?id_kel=$_idKel&value=data_pokjaa&order_by=desc'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> data = jsonResponse['data'];

      return data.map((item) {
        return MenuItem(
          id: item['id'],
          namaLing: item['nama_ling'],
          j_pkbn: item['j_pkbn'],
          j_pkdrt: item['j_pkdrt'],
          pola: item['pola'],
          p_pkbn_sim: item['p_pkbn_sim'],
          p_pkbn_anggota: item['p_pkbn_anggota'],
          p_pkdrt_sim: item['p_pkdrt_sim'],
          p_pkdrt_anggota: item['p_pkdrt_anggota'],
          pola_kel: item['pola_kel'],
          pola_anggota: item['pola_anggota'],
          lansia_kel: item['lansia_kel'],
          lansia_anggota: item['lansia_anggota'],
          g_jum_ker: item['g_jum_ker'],
          g_jum_ruk: item['g_jum_ruk'],
          g_jum_agama: item['g_jum_agama'],
          g_jum_jimpit: item['g_jum_jimpit'],
          g_jum_arisan: item['g_jum_arisan'],
        );
      }).toList();
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MenuItem>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Handling no internet connection error
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<MenuItem> menuItems = snapshot.data!;

          return MaterialApp(
            title: 'Data Pokja 1',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: TextTheme(
                  // Custom text theme
                  ),
            ),
            home: Scaffold(
              appBar: AppBar(
                title: Text('Data Pokja 1 - admin : ${_loadName()}'),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red,
                        const Color.fromARGB(255, 0, 87, 150)
                      ], // Warna gradien merah dan tosca
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
              body: ListView.builder(
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final menuItem = menuItems[index];
                  return Card(
                    elevation: 4.0,
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Icon(Icons.book),
                      title: Text(menuItem.namaLing),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('"Jumlah Kader PKBN": ${menuItem.j_pkbn},'),
                          Text('"Jumlah Kader PKDRT": ${menuItem.j_pkdrt},'),
                        ],
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(menuItem.namaLing),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                      '"Jumlah Kader PKBN": ${menuItem.j_pkbn},'),
                                  Text(
                                      '"Jumlah Kader PKDRT": ${menuItem.j_pkdrt},'),
                                  Text(
                                      '"Jumlah Kader Pola Asuh": ${menuItem.pola},'),
                                  Text(
                                      '"Penghayatan Pancasila PKBM Jumlah Kelompok Simulasi": ${menuItem.p_pkbn_sim},'),
                                  Text(
                                      '"Penghayatan Pancasila PKBM Jumlah Anggota": ${menuItem.p_pkbn_anggota},'),
                                  Text(
                                      '"Penghayatan Pancasila PKDRT Jumlah Kelompok Simulasi ": ${menuItem.p_pkdrt_sim},'),
                                  Text(
                                      '"Penghayatan Pancasila PKDRT Jumlah Anggota": ${menuItem.p_pkdrt_anggota},'),
                                  Text(
                                      '"Penghayatan Pancasila Pola Asuh Jumlah Kelompok Simulasi ": ${menuItem.pola_kel},'),
                                  Text(
                                      '"Penghayatan Pancasila Pola Asuh Jumlah Anggota ": ${menuItem.pola_anggota},'),
                                  Text(
                                      '"Penghayatan Pancasila Lansia Jumlah Kelompok Simulasi ": ${menuItem.lansia_kel},'),
                                  Text(
                                      '"Penghayatan Pancasila Lansia Jumlah Anggota ": ${menuItem.lansia_anggota},'),
                                  Text(
                                      '"Gotong Royong Jumlah Kelompok Kerja Bakti": ${menuItem.g_jum_ker},'),
                                  Text(
                                      '"Gotong Royong Jumlah Kelompok Rukun Kematian": ${menuItem.g_jum_ruk},'),
                                  Text(
                                      '"Gotong Royong Jumlah Kelompok Keagamaan": ${menuItem.g_jum_agama},'),
                                  Text(
                                      '"Gotong Royong Jumlah Kelompok Jimpitan": ${menuItem.g_jum_jimpit},'),
                                  Text(
                                      '"Gotong Royong Jumlah Kelompok Arisan": ${menuItem.g_jum_arisan},'),
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Tutup'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}
