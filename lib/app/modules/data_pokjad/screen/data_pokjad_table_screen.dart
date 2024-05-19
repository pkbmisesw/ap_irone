import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../services/data_services/data_pokjad_services.dart';
import '../model/data_pokjad.dart';
import '../model/data_pokjad_model.dart';

class TableDataPokjadScreen extends StatefulWidget {
  const TableDataPokjadScreen({super.key});

  @override
  _TableDataPokjadScreenState createState() => _TableDataPokjadScreenState();
}

class _TableDataPokjadScreenState extends State<TableDataPokjadScreen> {
  late EmployeeDataSource employeeDataSource =
      EmployeeDataSource(employeeData: []);
  final RxBool isLoading = true.obs;

  final DataPokjadServices dataServices = DataPokjadServices();
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
      List<DataPokjadModel> dataRekap = await dataServices.fetchTableData();

      employeeDataSource = EmployeeDataSource(employeeData: dataRekap);

      setState(() {});
    } catch (e) {
      print("Error: $e");
    }
  }

  DataPokjad dataModel = DataPokjad();

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
            'Data Pokja 4 Table',
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
  EmployeeDataSource({required List<DataPokjadModel> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'namaLing', value: e.namaLing),
              DataGridCell<int>(columnName: 'jKPos', value: e.jKPos),
              DataGridCell<int>(columnName: 'jKGizi', value: e.jKGizi),
              DataGridCell<int>(columnName: 'jKKes', value: e.jKKes),
              DataGridCell<int>(columnName: 'jKNar', value: e.jKNar),
              DataGridCell<int>(columnName: 'jKPhbs', value: e.jKPhbs),
              DataGridCell<int>(columnName: 'jKKB', value: e.jKKB),
              DataGridCell<int>(columnName: 'kpJumlah', value: e.kpJumlah),
              DataGridCell<int>(columnName: 'kpJumlahI', value: e.kpJumlahI),
              DataGridCell<int>(columnName: 'kpLanJK', value: e.kpLanJK),
              DataGridCell<int>(columnName: 'kpLanJA', value: e.kpLanJA),
              DataGridCell<int>(columnName: 'kpLanBG', value: e.kpLanBG),
              DataGridCell<int>(columnName: 'jJamban', value: e.jJamban),
              DataGridCell<int>(columnName: 'jSPAL', value: e.jSPAL),
              DataGridCell<int>(columnName: 'jSampah', value: e.jSampah),
              DataGridCell<int>(columnName: 'jMCK', value: e.jMCK),
              DataGridCell<int>(columnName: 'jKPdam', value: e.jKPdam),
              DataGridCell<int>(columnName: 'jKSumur', value: e.jKSumur),
              DataGridCell<int>(columnName: 'jKSungai', value: e.jKSungai),
              DataGridCell<int>(columnName: 'jKLain', value: e.jKLain),
              DataGridCell<int>(columnName: 'jPus', value: e.jPus),
              DataGridCell<int>(columnName: 'jWus', value: e.jWus),
              DataGridCell<int>(columnName: 'jaL', value: e.jaL),
              DataGridCell<int>(columnName: 'jaP', value: e.jaP),
              DataGridCell<int>(columnName: 'jKK', value: e.jKK),
              DataGridCell<String>(columnName: 'ket', value: e.ket),
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
