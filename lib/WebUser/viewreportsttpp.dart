import 'dart:convert';
import 'dart:html';
import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:RekaChain/WebAdmin/data_model.dart';
import 'package:RekaChain/WebUser/AfterSales.dart';
import 'package:RekaChain/WebUser/dasboard.dart';
import 'package:RekaChain/WebUser/inputdokumen.dart';
import 'package:RekaChain/WebUser/inputkebutuhanmaterial.dart';
import 'package:RekaChain/WebAdmin/login.dart';
import 'package:RekaChain/WebUser/notification.dart';
import 'package:RekaChain/WebUser/perencanaan.dart';
import 'package:RekaChain/WebUser/profile.dart';
import 'package:RekaChain/WebUser/reportsttpp.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:barcode_widget/barcode_widget.dart';

class ViewReportSTTPP extends StatefulWidget {
  final Map<String, dynamic> selectedProject;
  final DataModel data;
  final String nip;
  const ViewReportSTTPP(
      {Key? key,
      this.selectedProject = const {},
      required this.data,
      required this.nip})
      : super(key: key);

  @override
  State<ViewReportSTTPP> createState() => _ViewReportSTTPState();
}

class _ViewReportSTTPState extends State<ViewReportSTTPP> {
  bool isViewVisible = false;
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;

  int _selectedIndex = 0;
  List _listdata = [];
  bool _isloading = true;

  String _searchQuery = '';

  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  TextEditingController idLotcontroller = TextEditingController();
  TextEditingController noIndukProdukcontroller = TextEditingController();
  TextEditingController namaProjectcontroller = TextEditingController();
  TextEditingController noProdukcontroller = TextEditingController();
  TextEditingController noSeriAwalcontroller = TextEditingController();
  TextEditingController namaProdukcontroller = TextEditingController();
  TextEditingController jumlahLotcontroller = TextEditingController();
  TextEditingController kodeLotcontroller = TextEditingController();
  TextEditingController noSeriAkhircontroller = TextEditingController();
  TextEditingController tglMulaicontroller = TextEditingController();
  TextEditingController tglSelesaicontroller = TextEditingController();

  TextEditingController alurProses1controller = TextEditingController();
  TextEditingController kategori1controller = TextEditingController();
  TextEditingController detail1controller = TextEditingController();

  TextEditingController alurProses2controller = TextEditingController();
  TextEditingController kategori2controller = TextEditingController();
  TextEditingController detail2controller = TextEditingController();

  TextEditingController alurProses3controller = TextEditingController();
  TextEditingController kategori3controller = TextEditingController();
  TextEditingController detail3controller = TextEditingController();

  TextEditingController alurProses4controller = TextEditingController();
  TextEditingController kategori4controller = TextEditingController();
  TextEditingController detail4controller = TextEditingController();

  TextEditingController alurProses5controller = TextEditingController();
  TextEditingController kategori5controller = TextEditingController();
  TextEditingController detail5controller = TextEditingController();

  TextEditingController alurProses6controller = TextEditingController();
  TextEditingController kategori6controller = TextEditingController();
  TextEditingController detail6controller = TextEditingController();

  TextEditingController alurProses7controller = TextEditingController();
  TextEditingController kategori7controller = TextEditingController();
  TextEditingController detail7controller = TextEditingController();

  TextEditingController alurProses8controller = TextEditingController();
  TextEditingController kategori8controller = TextEditingController();
  TextEditingController detail8controller = TextEditingController();

  TextEditingController alurProses9controller = TextEditingController();
  TextEditingController kategori9controller = TextEditingController();
  TextEditingController detail9controller = TextEditingController();

  TextEditingController alurProses10controller = TextEditingController();
  TextEditingController kategori10controller = TextEditingController();
  TextEditingController detail10controller = TextEditingController();

  void fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://rekachain.000webhostapp.com/Project/read_perencanaan.php?nama=${widget.selectedProject['nama']}&kodeLot=${widget.selectedProject['kodeLot']}'),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          _listdata = responseData;
        });
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void _downloadCSV() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Download CSV", style: TextStyle(color: Colors.white)),
          content: Text(
              "Apakah Anda yakin ingin mengunduh data sebagai file CSV?",
              style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromRGBO(43, 56, 86, 1),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Batal", style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                String? nama =
                    _listdata.isNotEmpty ? _listdata[0]['nama'] : 'default';
                String? kodeLot =
                    _listdata.isNotEmpty ? _listdata[0]['kodeLot'] : 'default';

                String finalNama = nama ?? 'default';
                String finalKodeLot = kodeLot ?? 'default';

                List<List<dynamic>> rows = [];

                rows.add([
                  'No',
                  'Nama Project',
                  'Kode Lot',
                  'Nama Produk',
                  'No Produk',
                  'ID Lot',
                  'Proses',
                  'Tgl Mulai',
                  'Tgl Selesai',
                  'Personil',
                  'Keterangan'
                ]);

                int rowIndex = 1;
                for (var data in _listdata) {
                  final nama = data['nama'];
                  final kodeLot = data['kodeLot'];
                  final idLot = data['id_lot'];

                  for (var i = 1; i <= 10; i++) {
                    final alurProsesKey = 'ap$i';
                    final detailKey = 'keterangan$i';

                    final alurProses = data[alurProsesKey];
                    final detail = data[detailKey];

                    if (alurProses != null && alurProses.isNotEmpty) {
                      rows.add([
                        rowIndex.toString(),
                        nama ?? '',
                        kodeLot ?? '',
                        namaProdukcontroller.text,
                        data['noProduk'] ?? '',
                        data['id_lot'] ?? '',
                        alurProses ?? '',
                        tglMulaicontroller.text,
                        tglSelesaicontroller.text,
                        detail ?? '',
                        detail ?? ''
                      ]);
                      rowIndex++;
                    }
                  }
                }

                String csv = const ListToCsvConverter().convert(rows);
                final bytes = utf8.encode(csv);
                final blob = Blob([bytes]);
                final url = Url.createObjectUrlFromBlob(blob);
                AnchorElement(href: url)
                  ..setAttribute(
                      "download", "ReportSTTPP/$finalNama - $finalKodeLot.csv")
                  ..click();
                Url.revokeObjectUrl(url);
              },
              child: Text("Download", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData();

    idLotcontroller =
        TextEditingController(text: widget.selectedProject['id_lot'] ?? '');
    noProdukcontroller =
        TextEditingController(text: widget.selectedProject['noProduk'] ?? '');
    noIndukProdukcontroller = TextEditingController(
        text: widget.selectedProject['noIndukProduk'] ?? '');
    namaProjectcontroller =
        TextEditingController(text: widget.selectedProject['nama'] ?? '');
    noSeriAwalcontroller =
        TextEditingController(text: widget.selectedProject['noSeriAwal'] ?? '');
    namaProdukcontroller =
        TextEditingController(text: widget.selectedProject['namaProduk'] ?? '');
    jumlahLotcontroller =
        TextEditingController(text: widget.selectedProject['jumlahLot'] ?? '');
    kodeLotcontroller =
        TextEditingController(text: widget.selectedProject['kodeLot'] ?? '');
    noSeriAkhircontroller = TextEditingController(
        text: widget.selectedProject['noSeriAkhir'] ?? '');
    tglMulaicontroller = TextEditingController(
        text: widget.selectedProject['targetMulai'] ?? '');
    tglSelesaicontroller = TextEditingController(
        text: widget.selectedProject['targetSelesai'] ?? '');

    alurProses1controller =
        TextEditingController(text: widget.selectedProject['ap1'] ?? '');
    kategori1controller =
        TextEditingController(text: widget.selectedProject['kategori1'] ?? '');
    detail1controller = TextEditingController(
        text: widget.selectedProject['keterangan1'] ?? '');

    alurProses2controller =
        TextEditingController(text: widget.selectedProject['ap2'] ?? '');
    kategori2controller =
        TextEditingController(text: widget.selectedProject['kategori2'] ?? '');
    detail2controller = TextEditingController(
        text: widget.selectedProject['keterangan2'] ?? '');

    alurProses3controller =
        TextEditingController(text: widget.selectedProject['ap3'] ?? '');
    kategori3controller =
        TextEditingController(text: widget.selectedProject['kategori3'] ?? '');
    detail3controller = TextEditingController(
        text: widget.selectedProject['keterangan3'] ?? '');

    alurProses4controller =
        TextEditingController(text: widget.selectedProject['ap4'] ?? '');
    kategori4controller =
        TextEditingController(text: widget.selectedProject['kategori4'] ?? '');
    detail4controller = TextEditingController(
        text: widget.selectedProject['keterangan4'] ?? '');

    alurProses5controller =
        TextEditingController(text: widget.selectedProject['ap5'] ?? '');
    kategori5controller =
        TextEditingController(text: widget.selectedProject['kategori5'] ?? '');
    detail5controller = TextEditingController(
        text: widget.selectedProject['keterangan5'] ?? '');

    alurProses6controller =
        TextEditingController(text: widget.selectedProject['ap6'] ?? '');
    kategori6controller =
        TextEditingController(text: widget.selectedProject['kategori6'] ?? '');
    detail6controller = TextEditingController(
        text: widget.selectedProject['keterangan6'] ?? '');

    alurProses7controller =
        TextEditingController(text: widget.selectedProject['ap7'] ?? '');
    kategori7controller =
        TextEditingController(text: widget.selectedProject['kategori7'] ?? '');
    detail7controller = TextEditingController(
        text: widget.selectedProject['keterangan7'] ?? '');

    alurProses8controller =
        TextEditingController(text: widget.selectedProject['ap8'] ?? '');
    kategori8controller =
        TextEditingController(text: widget.selectedProject['kategori8'] ?? '');
    detail8controller = TextEditingController(
        text: widget.selectedProject['keterangan8'] ?? '');

    alurProses9controller =
        TextEditingController(text: widget.selectedProject['ap9'] ?? '');
    kategori9controller =
        TextEditingController(text: widget.selectedProject['kategori9'] ?? '');
    detail9controller = TextEditingController(
        text: widget.selectedProject['keterangan9'] ?? '');

    alurProses10controller =
        TextEditingController(text: widget.selectedProject['ap10'] ?? '');
    kategori10controller =
        TextEditingController(text: widget.selectedProject['kategori10'] ?? '');
    detail10controller = TextEditingController(
        text: widget.selectedProject['keterangan10'] ?? '');

    _generateBarcode();
  }

  Widget? qrCodeWidget;
  void _generateBarcode() async {
    String idLot = idLotcontroller.text;
    String namaProject = namaProjectcontroller.text;
    String noProduk = noProdukcontroller.text;

    setState(() {
      qrCodeWidget = Column(
        children: [
          BarcodeWidget(
            barcode: Barcode.qrCode(),
            data: idLot,
            color: Colors.black,
            height: 37,
            width: 37,
          ),
          SizedBox(height: 5),
          Text(
            '$namaProject - $noProduk',
            style: TextStyle(fontSize: 4, fontWeight: FontWeight.bold),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        screenWidth = constraints.maxWidth;
        screenHeight = constraints.maxHeight;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/':
                return MaterialPageRoute(
                  builder: (context) =>
                      ViewReportSTTPP(data: widget.data, nip: widget.nip),
                );
              default:
                return null;
            }
          },
          home: Scaffold(
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDrawer(),
                Expanded(
                  child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: const Color.fromRGBO(43, 56, 86, 1),
                      toolbarHeight: 65,
                      title: Padding(
                        padding: EdgeInsets.only(left: screenHeight * 0.02),
                        child: Text(
                          'View Report STTPP',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Donegal One',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      actions: [
                        Padding(
                          padding: EdgeInsets.only(right: screenHeight * 0.11),
                          child: Row(
                            children: [
                              SizedBox(
                                width: screenWidth * 0.005,
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.file_download_outlined,
                                  size: 33,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                onPressed: () {
                                  _downloadCSV();
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.notifications_active,
                                  size: 33,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Notifikasi(
                                            nip: widget.nip,
                                            data: widget.data)),
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.account_circle_rounded,
                                  size: 35,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Profile(
                                            data: widget.data,
                                            nip: widget.nip)),
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    body: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Center(
                        child: _buildMainTable(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          ),
        );
      },
    );
  }

  Widget _buildMainTable() {
    List<DataRow> generateRows() {
      List<DataRow> rows = [];
      int rowIndex = 1;

      List<Map<String, TextEditingController>> data = [
        {
          'alurProses': alurProses1controller,
          'detail': detail1controller,
          'noProduk': noProdukcontroller,
          'id_lot': idLotcontroller
        },
        {
          'alurProses': alurProses2controller,
          'detail': detail2controller,
          'noProduk': noProdukcontroller,
          'id_lot': idLotcontroller
        },
        {
          'alurProses': alurProses3controller,
          'detail': detail3controller,
          'noProduk': noProdukcontroller,
          'id_lot': idLotcontroller
        },
        {
          'alurProses': alurProses4controller,
          'detail': detail4controller,
          'noProduk': noProdukcontroller,
          'id_lot': idLotcontroller
        },
        {
          'alurProses': alurProses5controller,
          'detail': detail5controller,
          'noProduk': noProdukcontroller,
          'id_lot': idLotcontroller
        },
        {
          'alurProses': alurProses6controller,
          'detail': detail6controller,
          'noProduk': noProdukcontroller,
          'id_lot': idLotcontroller
        },
        {
          'alurProses': alurProses7controller,
          'detail': detail7controller,
          'noProduk': noProdukcontroller,
          'id_lot': idLotcontroller
        },
        {
          'alurProses': alurProses8controller,
          'detail': detail8controller,
          'noProduk': noProdukcontroller,
          'id_lot': idLotcontroller
        },
        {
          'alurProses': alurProses9controller,
          'detail': detail9controller,
          'noProduk': noProdukcontroller,
          'id_lot': idLotcontroller
        },
        {
          'alurProses': alurProses10controller,
          'detail': detail10controller,
          'noProduk': noProdukcontroller,
          'id_lot': idLotcontroller
        },
      ];
      for (var data in _listdata) {
        // Ekstrak 'nama' dan 'kodeLot'
        final nama = data['nama'];
        final kodeLot = data['kodeLot'];
        final idLot = data['id_lot'];

        // Iterasi melalui 'alurProses' dan 'detail'
        for (var i = 1; i <= 10; i++) {
          final alurProsesKey = 'ap$i';
          final detailKey = 'keterangan$i';

          final alurProses = data[alurProsesKey];
          final detail = data[detailKey];

          if (alurProses != null && alurProses.isNotEmpty) {
            rows.add(
              DataRow(cells: [
                DataCell(
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(rowIndex.toString()),
                    ),
                  ),
                ),
                DataCell(
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(nama ?? ''),
                    ),
                  ),
                ),
                DataCell(
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(kodeLot ?? ''),
                    ),
                  ),
                ),
                DataCell(
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(namaProdukcontroller.text),
                    ),
                  ),
                ),
                DataCell(
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(data['noProduk'] ?? ''),
                    ),
                  ),
                ),
                DataCell(
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(data['id_lot'] ?? ''),
                    ),
                  ),
                ),
                DataCell(
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      alignment: Alignment.center,
                      child: BarcodeWidget(
                        barcode: Barcode.qrCode(),
                        data: idLot ?? '',
                        color: Colors.black,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                ),
                DataCell(
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(alurProses ?? ''),
                    ),
                  ),
                ),
                DataCell(
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(tglMulaicontroller.text),
                    ),
                  ),
                ),
                DataCell(
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(tglSelesaicontroller.text),
                    ),
                  ),
                ),
                DataCell(
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(detail ?? ''),
                    ),
                  ),
                ),
                DataCell(
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(detail ?? ''),
                    ),
                  ),
                ),
              ]),
            );
            rowIndex++;
          }
        }
      }
      return rows;
    }

    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - 50,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 120.0,
              horizontalMargin: 70.0,
              columns: [
                DataColumn(
                  label: Center(
                    child: Text(
                      'No',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                DataColumn(
                  label: Center(
                    child: Text(
                      'Nama Project',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                DataColumn(
                  label: Center(
                    child: Text(
                      'Kode Lot',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                DataColumn(
                  label: Center(
                    child: Text(
                      'Nama Produk',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                DataColumn(
                  label: Center(
                    child: Text(
                      'No Produk',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                DataColumn(
                  label: Center(
                    child: Text(
                      'ID Lot',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                DataColumn(
                  label: Center(
                    child: Text(
                      'Kode QR',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                DataColumn(
                  label: Center(
                    child: Text(
                      'Proses',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                DataColumn(
                  label: Center(
                    child: Text(
                      'Tgl Mulai',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                DataColumn(
                  label: Center(
                    child: Text(
                      'Tgl Selesai',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                DataColumn(
                  label: Center(
                    child: Text(
                      'Personil',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                DataColumn(
                  label: Center(
                    child: Text(
                      'Keterangan',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ],
              rows: generateRows(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 244, 249, 255),
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'assets/images/logoreka.png',
                    height: 130,
                    width: 250,
                  ),
                ),
              ],
            ),
          ),
          _buildListTile('Dashboard', Icons.dashboard, 0, 35),
          _buildSubMenu(),
          _buildListTile('Report STTPP', Icons.receipt, 4, 35),
          _buildListTile('After Sales', Icons.headset_mic, 5, 35),
          _buildListTile('Logout', Icons.logout, 8, 35),
        ],
      ),
    );
  }

  Widget _buildListTile(String title, IconData icon, int index, int size) {
    return ListTile(
      title: Text(title),
      leading: Icon(
        icon,
        size: size.toDouble(),
        color: Color.fromARGB(255, 6, 37, 55),
      ),
      onTap: () {
        if (index == 8) {
          _showLogoutDialog();
        } else {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    UserDashboard(nip: widget.nip, data: widget.data),
              ),
            );
          } else if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ReportSTTPP(data: widget.data, nip: widget.nip),
              ),
            );
          } else if (index == 5) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AfterSales(data: widget.data, nip: widget.nip),
              ),
            );
          }
        }
      },
    );
  }

  Widget _buildSubMenu({IconData? icon}) {
    return ExpansionTile(
      title: Row(
        children: [
          Icon(
            icon ?? Icons.input,
            size: 35,
            color: Color.fromARGB(255, 6, 37, 55),
          ),
          SizedBox(width: 12),
          Text('Input Data'),
        ],
      ),
      children: [
        _buildSubListTile('Perencanaan', Icons.calendar_today, 1, 35),
        _buildSubListTile('Input Kebutuhan Material', Icons.assignment, 2, 35),
        _buildSubListTile('Input Dokumen Pendukung', Icons.file_present, 3, 35),
      ],
    );
  }

  Widget _buildSubListTile(
    String title,
    IconData icon,
    int index,
    int size,
  ) {
    return ListTile(
      title: Text(title),
      leading: Icon(
        icon,
        size: size.toDouble(),
        color: Color.fromARGB(255, 6, 37, 55),
      ),
      onTap: () {
        if (index == 8) {
          _showLogoutDialog();
        } else {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Perencanaan(data: widget.data, nip: widget.nip),
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    InputMaterial(data: widget.data, nip: widget.nip),
              ),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    InputDokumen(data: widget.data, nip: widget.nip),
              ),
            );
          }
        }
      },
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout", style: TextStyle(color: Colors.white)),
          content: Text("Apakah Anda yakin ingin logout?",
              style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromRGBO(43, 56, 86, 1),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Batal", style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LoginPage(data: widget.data, nip: widget.nip)),
                );
              },
              child: Text("Logout", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
