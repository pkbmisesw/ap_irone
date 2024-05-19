import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:irone/app/utils/local_db.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(DataUmumGrafikScreen());
}

class MenuItem {
  final int id;

  final String title;
  final String imagePath;

  MenuItem({required this.id, required this.title, required this.imagePath});
}

class DataUmumGrafikScreen extends StatefulWidget {
  @override
  _DataUmumGrafikScreenState createState() => _DataUmumGrafikScreenState();
}

class _DataUmumGrafikScreenState extends State<DataUmumGrafikScreen> {
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
        'http://app2.tppkk-bitung.com/api/view-barang-rekap?id_kel=$_idKel&value=data_pokjab&order_by=desc'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> data = jsonResponse['data'];

      return data.map((item) {
        return MenuItem(
          id: item['id'],

          title: item['nama_ling'],
          imagePath: 'assets/ic/red.png', // Ganti dengan path gambar asset Anda
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
          List<MenuItem> menuItems = snapshot.data!;

          // Final List<MenuItem> menuItems = snapshot.data!;

          return MaterialApp(
            title: 'Grafik - Data Pokja 2',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: TextTheme(
                  // Custom text theme
                  ),
            ),
            home: Scaffold(
              appBar: AppBar(
                title: Text('Grafik Pokja 2 - admin : ${_loadName()}'),
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
              body: Center(
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        color: Colors.blue,
                        value: 5, // Jumlah barang
                        title: 'Barang',
                        radius: 50, // Radius bagian
                        titleStyle: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      PieChartSectionData(
                        color: Colors.green,
                        value: 3, // Jumlah jasa
                        title: 'Jasa',
                        radius: 50, // Radius bagian
                        titleStyle: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0,
                    centerSpaceRadius: 40,
                    startDegreeOffset: -90,
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
