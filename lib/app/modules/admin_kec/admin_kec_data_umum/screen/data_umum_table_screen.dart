import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:silahan_kawan/app/modules/data_rekap/models/data_model.dart';
import 'package:silahan_kawan/app/modules/data_rekap/models/data_rekap_models.dart';
import 'package:silahan_kawan/app/services/data_services/data_services.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class AdminKecTableDataUmumScreen extends StatefulWidget {
  const AdminKecTableDataUmumScreen({super.key});

  @override
  _AdminKecTableDataUmumScreenState createState() =>
      _AdminKecTableDataUmumScreenState();
}

class _AdminKecTableDataUmumScreenState
    extends State<AdminKecTableDataUmumScreen> {
  late EmployeeDataSource employeeDataSource =
      EmployeeDataSource(employeeData: []);
  final RxBool isLoading = true.obs;

  final DataServices dataServices = DataServices();
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
      List<DataRekapModels> dataRekap =
          await dataServices.fetchTableDataUmum(useIdKec: true);

      employeeDataSource = EmployeeDataSource(employeeData: dataRekap);

      setState(() {});
    } catch (e) {
      print("Error: $e");
    }
  }

  DataModel dataModel = DataModel();

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
            'Data Umum Table',
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
  EmployeeDataSource({required List<DataRekapModels> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'nama_ling', value: e.namaLing),
              DataGridCell<int>(columnName: 'j_kel', value: e.jKel),
              DataGridCell<int>(columnName: 'j_ling', value: e.jLing),
              DataGridCell<int>(columnName: 'j_rw', value: e.jRw),
              DataGridCell<int>(columnName: 'j_rt', value: e.jRt),
              DataGridCell<int>(columnName: 'j_dasawisma', value: e.jDasawisma),
              DataGridCell<int>(columnName: 'j_krt', value: e.jKrt),
              DataGridCell<int>(columnName: 'j_kk', value: e.jKk),
              DataGridCell<int>(columnName: 'j_a_total_l', value: e.jATotalL),
              DataGridCell<int>(columnName: 'j_a_total_p', value: e.jATotalP),
              DataGridCell<int>(columnName: 'j_a_balita_l', value: e.jABalitaP),
              DataGridCell<int>(columnName: 'j_a_balita_p', value: e.jABalitaL),
              DataGridCell<int>(columnName: 'j_a_pus', value: e.jAPus),
              DataGridCell<int>(columnName: 'j_a_wus', value: e.jAWus),
              DataGridCell<int>(columnName: 'j_a_hamil', value: e.jAHamil),
              DataGridCell<int>(columnName: 'j_a_susui', value: e.jASusui),
              DataGridCell<int>(columnName: 'j_a_lansia', value: e.jALansia),
              DataGridCell<int>(columnName: 'j_a_blaki', value: e.jABlaki),
              DataGridCell<int>(columnName: 'j_a_bcwe', value: e.jABcwe),
              DataGridCell<int>(columnName: 'j_a_bb', value: e.jABb),
              DataGridCell<int>(columnName: 'kr_sehat', value: e.krSehat),
              DataGridCell<int>(
                  columnName: 'kr_tdk_sehat', value: e.krTdkSehat),
              DataGridCell<int>(columnName: 'jr_tsampah', value: e.jrTsampah),
              DataGridCell<int>(columnName: 'jr_spal', value: e.jrSpal),
              DataGridCell<int>(columnName: 'jr_jamban', value: e.jrJamban),
              DataGridCell<int>(columnName: 'jr_stiker', value: e.jrStiker),
              DataGridCell<int>(columnName: 'sak_pdam', value: e.sakPdam),
              DataGridCell<int>(columnName: 'sak_sumur', value: e.sakSumur),
              DataGridCell<int>(columnName: 'sak_sungai', value: e.sakSungai),
              DataGridCell<int>(columnName: 'sak_dll', value: e.sakDll),
              DataGridCell<int>(columnName: 'mp_beras', value: e.mpBeras),
              DataGridCell<int>(columnName: 'mp_nonberas', value: e.mpNonberas),
              DataGridCell<int>(columnName: 'jkk_tabung', value: e.jkkTabung),
              DataGridCell<int>(columnName: 'k_upk', value: e.kUpk),
              DataGridCell<int>(columnName: 'kp_ternak', value: e.kpTernak),
              DataGridCell<int>(columnName: 'kp_ikan', value: e.kpIkan),
              DataGridCell<int>(columnName: 'kp_warung', value: e.kpWarung),
              DataGridCell<int>(columnName: 'kp_lumbung', value: e.kpLumbung),
              DataGridCell<int>(columnName: 'kp_toga', value: e.kpToga),
              DataGridCell<int>(columnName: 'kp_tanaman', value: e.kpTanaman),
              DataGridCell<int>(columnName: 'i_pangan', value: e.iPangan),
              DataGridCell<int>(columnName: 'i_sandang', value: e.iSandang),
              DataGridCell<int>(columnName: 'i_jasa', value: e.iJasa),
              DataGridCell<int>(columnName: 'kes_ling', value: e.kesLing),
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
