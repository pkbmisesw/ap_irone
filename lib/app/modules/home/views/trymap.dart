import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irone/theme.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:http/http.dart' as http;

class MapController extends GetxController {
  RxList<ModelMap> dataMap = <ModelMap>[].obs;
  void onInit() {
    getMapApi();
  }

  Future<void> getMapApi() async {
    final httpData = 'http://app2.tppkk-bitung.com/api/lihat-map';
    final response = await http.get(Uri.parse(httpData));
    if (response.statusCode == 200) {
      // Jika permintaan berhasil, parse data dan masukkan ke dalam dataMap
      final jsonData = json.decode(response.body)['data'];
      final List<ModelMap> maps =
          List<ModelMap>.from(jsonData.map((x) => ModelMap.fromJson(x)));
      dataMap.assignAll(maps);

      print(dataMap.map((element) => element.id));
    } else {
      // Jika permintaan gagal, lakukan penanganan kesalahan
      print('Gagal mengambil data: ${response.statusCode}');
    }
  }
}

class ModelMap {
  final int id;
  final String name;
  final String lat;
  final String long;
  ModelMap(
      {required this.id,
      required this.lat,
      required this.long,
      required this.name});

  factory ModelMap.fromJson(Map<String, dynamic> json) => ModelMap(
      id: json['id'], lat: json['lat'], long: json['long'], name: json['nama']);
}

class TryMap extends StatelessWidget {
  TryMap({super.key});
  final controller = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: bgWhite,
          title: Text('Map PKK BITUNG'),
        ),
        body: Obx(() => controller.dataMap.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(1.4306889, 125.1136468),
                  initialZoom: 9.2,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  Obx(
                    () => MarkerLayer(
                      markers: controller.dataMap
                          .map(
                            (map) => Marker(
                              width: 20.0,
                              height: 20.0,
                              point: LatLng(double.parse(map.lat),
                                  double.parse(map.long)),
                              child: Container(
                                child: Icon(
                                  Icons.location_pin,
                                  color: Colors.red,
                                  size: 30.0,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  RichAttributionWidget(
                    attributions: [
                      TextSourceAttribution(
                        'OpenStreetMap contributors',
                        onTap: () => null,
                      ),
                    ],
                  ),
                ],
              )));
  }
}
