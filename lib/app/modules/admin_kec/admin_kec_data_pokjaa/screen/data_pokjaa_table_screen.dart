import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:silahan_kawan/app/modules/data_pokjaa/models/data_pokja.dart';
import 'package:silahan_kawan/app/modules/data_pokjaa/models/data_pokja_model.dart';
import 'package:silahan_kawan/app/services/data_services/data_pokjaa_services.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class AdminKecTableDataPokjaaScreen extends StatefulWidget {
  const AdminKecTableDataPokjaaScreen({super.key});

  @override
  _AdminKecTableDataPokjaaScreenState createState() =>
      _AdminKecTableDataPokjaaScreenState();
}

class _AdminKecTableDataPokjaaScreenState
    extends State<AdminKecTableDataPokjaaScreen> {
  late EmployeeDataSource employeeDataSource =
      EmployeeDataSource(employeeData: []);
  final RxBool isLoading = true.obs;

  final DataPokjaaServices dataServices = DataPokjaaServices();
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
      List<DataPokjaModel> dataRekap =
          await dataServices.fetchTableData('data_pokjaa', useIdKec: true);

      employeeDataSource = EmployeeDataSource(employeeData: dataRekap);

      setState(() {});
    } catch (e) {
      print("Error: $e");
    }
  }

  DataPokja dataModel = DataPokja();

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
            'Data Pokja 1 Table',
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
  EmployeeDataSource({required List<DataPokjaModel> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'namaLing', value: e.namaLing),
              DataGridCell<int>(columnName: 'jPkbn', value: e.jPkbn),
              DataGridCell<int>(columnName: 'jPkdrt', value: e.jPkdrt),
              DataGridCell<int>(columnName: 'pola', value: e.pola),
              DataGridCell<int>(columnName: 'pPkbnSim', value: e.pPkbnSim),
              DataGridCell<int>(
                  columnName: 'pPkbnAnggota', value: e.pPkbnAnggota),
              DataGridCell<int>(columnName: 'pPkdrtSim', value: e.pPkdrtSim),
              DataGridCell<int>(
                  columnName: 'pPkdrtAnggota', value: e.pPkdrtAnggota),
              DataGridCell<int>(columnName: 'polaKel', value: e.polaKel),
              DataGridCell<int>(
                  columnName: 'polaAnggota', value: e.polaAnggota),
              DataGridCell<int>(columnName: 'lansiaKel', value: e.lansiaKel),
              DataGridCell<int>(
                  columnName: 'lansiaAnggota', value: e.lansiaAnggota),
              DataGridCell<int>(columnName: 'gJumKer', value: e.gJumKer),
              DataGridCell<int>(columnName: 'gJumRuk', value: e.gJumRuk),
              DataGridCell<int>(columnName: 'gJumAgama', value: e.gJumAgama),
              DataGridCell<int>(columnName: 'gJumJimpit', value: e.gJumJimpit),
              DataGridCell<int>(columnName: 'gJumArisan', value: e.gJumArisan),
              DataGridCell<String>(columnName: 'ket', value: e.ket ?? 'Kosong'),
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
