import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:silahan_kawan/app/modules/data_pokjab/models/data_pokjab.dart';
import 'package:silahan_kawan/app/modules/data_pokjab/models/data_pokjab_model.dart';
import 'package:silahan_kawan/app/services/data_services/data_pokjab_services.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class SuperAdminTableDataPokjabScreen extends StatefulWidget {
  const SuperAdminTableDataPokjabScreen({super.key});

  @override
  _SuperAdminTableDataPokjabScreenState createState() =>
      _SuperAdminTableDataPokjabScreenState();
}

class _SuperAdminTableDataPokjabScreenState
    extends State<SuperAdminTableDataPokjabScreen> {
  late EmployeeDataSource employeeDataSource =
      EmployeeDataSource(employeeData: []);
  final RxBool isLoading = true.obs;

  final DataPokjabServices dataServices = DataPokjabServices();
  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    getData();
    Future.delayed(Duration(seconds: 1));
    isLoading.value = false;
    setState(() {});
  }

  void getData() async {
    try {
      List<DataPokjabModel> dataRekap =
          await dataServices.fetchTableData(withoutID: true);

      employeeDataSource = EmployeeDataSource(employeeData: dataRekap);

      setState(() {});
    } catch (e) {
      print("Error: $e");
    }
  }

  DataPokjab dataModel = DataPokjab();

  @override
  Widget build(BuildContext context) {
    String truncateStringToTwoWords(String valueData) {
      String originalString = valueData;

      List<String> words = originalString.split(' ');

      if (words.length >= 2) {
        return '${words[0]} ${words[1]}';
      } else {
        return originalString;
      }
    }

    List<GridColumn> dataGridColumn =
        List.generate(dataModel.datas.length, (index) {
      return GridColumn(
        columnName: truncateStringToTwoWords(
          dataModel.datas[index].toString(),
        ),
        label: Container(
          color: Colors.redAccent,
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: Text(
            dataModel.datas[index].toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    });

    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 2,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xffB00020),
            ),
          ),
          title: Text(
            'Data Pokja 2 Table',
            style: GoogleFonts.outfit(
                fontWeight: FontWeight.w500, color: Color(0xffB00020)),
          ),
        ),
        body: Obx(
          () => isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SfDataGrid(
                  source: employeeDataSource,
                  columnWidthMode: ColumnWidthMode.fitByColumnName,
                  headerRowHeight: 100,
                  columns: dataGridColumn),
        ));
  }
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<DataPokjabModel> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'namaLing', value: e.namaLing),
              DataGridCell<int>(columnName: 'jWmL', value: e.jWmL),
              DataGridCell<int>(columnName: 'jWmP', value: e.jWmP),
              DataGridCell<int>(columnName: 'jABel', value: e.jABel),
              DataGridCell<int>(columnName: 'jAWBel', value: e.jAWBel),
              DataGridCell<int>(columnName: 'jBBel', value: e.jBBel),
              DataGridCell<int>(columnName: 'jBWBel', value: e.jBWBel),
              DataGridCell<int>(columnName: 'jCBel', value: e.jCBel),
              DataGridCell<int>(columnName: 'jCWBel', value: e.jCWBel),
              DataGridCell<int>(columnName: 'jKfBel', value: e.jKfBel),
              DataGridCell<int>(columnName: 'jKfWBel', value: e.jKfWBel),
              DataGridCell<int>(
                  columnName: 'jPaudSJenis', value: e.jPaudSJenis),
              DataGridCell<int>(columnName: 'jTbmPer', value: e.jTbmPer),
              DataGridCell<int>(columnName: 'jBkbKel', value: e.jBkbKel),
              DataGridCell<int>(columnName: 'jBkbIbu', value: e.jBkbIbu),
              DataGridCell<int>(columnName: 'jBkbApe', value: e.jBkbApe),
              DataGridCell<int>(columnName: 'jBkbSim', value: e.jBkbSim),
              DataGridCell<int>(columnName: 'jKtKf', value: e.jKtKf),
              DataGridCell<int>(columnName: 'jKtPaud', value: e.jKtPaud),
              DataGridCell<int>(columnName: 'jKBkb', value: e.jKBkb),
              DataGridCell<int>(columnName: 'jKKop', value: e.jKKop),
              DataGridCell<int>(columnName: 'jKKet', value: e.jKKet),
              DataGridCell<int>(columnName: 'jKLlpt', value: e.jKLlpt),
              DataGridCell<int>(columnName: 'jKLtpk', value: e.jKLtpk),
              DataGridCell<int>(columnName: 'jKLdamas', value: e.jKLdamas),
              DataGridCell<int>(columnName: 'pKopPemKel', value: e.pKopPemKel),
              DataGridCell<int>(columnName: 'pKopPemPes', value: e.pKopPemPes),
              DataGridCell<int>(columnName: 'pKopMadKel', value: e.pKopMadKel),
              DataGridCell<int>(columnName: 'pKopMadPes', value: e.pKopMadPes),
              DataGridCell<int>(columnName: 'pKopUtKel', value: e.pKopUtKel),
              DataGridCell<int>(columnName: 'pKopMutPes', value: e.pKopMutPes),
              DataGridCell<int>(columnName: 'pKopManKel', value: e.pKopManKel),
              DataGridCell<int>(columnName: 'pKopManPes', value: e.pKopManPes),
              DataGridCell<int>(columnName: 'kJKel', value: e.kJKel),
              DataGridCell<int>(columnName: 'kJPes', value: e.kJPes),
              DataGridCell<String>(columnName: 'ket', value: e.ket ?? ''),
              DataGridCell<int>(columnName: 'status', value: e.status),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
