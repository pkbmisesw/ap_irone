import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:irone/app/modules/data_pokjac/model/data_pokjac.dart';
import 'package:irone/app/modules/data_pokjac/model/data_pokjac_model.dart';
import 'package:irone/app/services/data_services/data_pokjac_services.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class SuperAdminTableDataPokjacScreen extends StatefulWidget {
  const SuperAdminTableDataPokjacScreen({super.key});

  @override
  _SuperAdminTableDataPokjacScreenState createState() =>
      _SuperAdminTableDataPokjacScreenState();
}

class _SuperAdminTableDataPokjacScreenState
    extends State<SuperAdminTableDataPokjacScreen> {
  late EmployeeDataSource employeeDataSource =
      EmployeeDataSource(employeeData: []);
  final RxBool isLoading = true.obs;

  final DataPokjacServices dataServices = DataPokjacServices();
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
      List<DataPokjacModel> dataRekap =
          await dataServices.fetchTableData(withoutID: true);

      employeeDataSource = EmployeeDataSource(employeeData: dataRekap);

      setState(() {});
    } catch (e) {
      print("Error: $e");
    }
  }

  DataPokjac dataModel = DataPokjac();

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
            'Data Pokja 3 Table',
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
  EmployeeDataSource({required List<DataPokjacModel> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'namaLing', value: e.namaLing),
              DataGridCell<int>(columnName: 'jKPangan', value: e.jKPangan),
              DataGridCell<int>(columnName: 'jKSandang', value: e.jKSandang),
              DataGridCell<int>(columnName: 'jKTaRt', value: e.jKTaRt),
              DataGridCell<int>(columnName: 'pMpBeras', value: e.pMpBeras),
              DataGridCell<int>(columnName: 'pMpNberas', value: e.pMpNberas),
              DataGridCell<int>(columnName: 'pPPTernak', value: e.pPPTernak),
              DataGridCell<int>(columnName: 'pPPIkan', value: e.pPPIkan),
              DataGridCell<int>(columnName: 'pPPWarung', value: e.pPPWarung),
              DataGridCell<int>(columnName: 'pPPLumbung', value: e.pPPLumbung),
              DataGridCell<int>(columnName: 'pPPToga', value: e.pPPToga),
              DataGridCell<int>(columnName: 'pPPTkeras', value: e.pPPTkeras),
              DataGridCell<int>(columnName: 'jiPangan', value: e.jiPangan),
              DataGridCell<int>(columnName: 'jiSandang', value: e.jiSandang),
              DataGridCell<int>(columnName: 'jiJasa', value: e.jiJasa),
              DataGridCell<int>(columnName: 'jrSehat', value: e.jrSehat),
              DataGridCell<int>(columnName: 'jrTsehat', value: e.jrTsehat),
              DataGridCell<String?>(columnName: 'ket', value: e.ket),
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
