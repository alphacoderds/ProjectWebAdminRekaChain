import 'dart:convert';

import 'package:RekaChain/WebAdmin/AfterSales.dart';
import 'package:RekaChain/WebAdmin/dasboard.dart';
import 'package:RekaChain/WebAdmin/data_model.dart';
import 'package:RekaChain/WebAdmin/inputdokumen.dart';
import 'package:RekaChain/WebAdmin/inputkebutuhanmaterial.dart';
import 'package:RekaChain/WebAdmin/login.dart';
import 'package:RekaChain/WebAdmin/notification.dart';
import 'package:RekaChain/WebAdmin/perencanaan.dart';
import 'package:RekaChain/WebAdmin/profile.dart';
import 'package:RekaChain/WebAdmin/reportsttpp.dart';
import 'package:RekaChain/WebAdmin/tambahproject.dart';
import 'package:RekaChain/WebAdmin/tambahstaff.dart';
import 'package:RekaChain/WebAdmin/viewperencanaan.dart';
import 'package:http/http.dart' as http;
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class Cetak1 extends StatefulWidget {
  final Map<String, dynamic> selectedProject;
  final DataModel data;
  final String nip;
  const Cetak1(
      {Key? key,
      this.selectedProject = const {},
      required this.data,
      required this.nip})
      : super(key: key);

  @override
  State<Cetak1> createState() => _Cetak1State();
}

class _Cetak1State extends State<Cetak1> {
  int _selectedIndex = 0;

  late double screenWidth;
  late double screenHeight;

  List _listdata = [];
  bool _isloading = true;

  TextEditingController idLotcontroller = TextEditingController();
  TextEditingController noProdukcontroller = TextEditingController();
  TextEditingController namaProjectcontroller = TextEditingController();
  TextEditingController noIndukProdukcontroller = TextEditingController();
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
            'http://192.168.8.207/ProjectWebAdminRekaChain/lib/Project/edit_perencanaan.php?nama=${widget.selectedProject['nama']}&kodeLot=${widget.selectedProject['kodeLot']}'),
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final kodeLot = responseData['kodeLot'];
        setState(() {
          kodeLotcontroller.text = kodeLot;
        });
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void _generateBarcode() async {
    String idLot = idLotcontroller.text;

    final widget = BarcodeWidget(
      barcode: Barcode.qrCode(),
      data: idLot,
      color: Colors.black,
      height: 200,
      width: 200,
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('QR Code ID Lot'),
        content: Container(
          width: 200,
          height: 200,
          child: widget,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
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

    TextEditingController(text: widget.selectedProject['kodeLot'] ?? '');
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => Cetak1(data: widget.data, nip: widget.nip),
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
                      'Cetak Barcode',
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
                      padding: EdgeInsets.only(right: screenHeight * 0.13),
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
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.notifications_active,
                              size: 35,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Notifikasi(
                                      nip: widget.nip, data: widget.data),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.account_circle_rounded,
                              size: 38,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Profile(
                                        data: widget.data, nip: widget.nip)),
                              );
                            },
                            padding: EdgeInsets.only(right: 16.0),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                body: Stack(
                  children: [
                    Container(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                        child: Column(
                          children: [
                            Center(
                              child: Container(
                                width: screenWidth * 0.63,
                                height: screenHeight * 0.80,
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                margin: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(30, 10, 30, 10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black45))),
                                      alignment: Alignment.center,
                                      child: Text(
                                        namaProjectcontroller.text,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Container(
                                      child: _buildMainTable(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 150,
                      right: 150,
                      child: ElevatedButton(
                        onPressed: _generateBarcode,
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 1, 46, 76),
                        ),
                        child: Text('Cetak QR Code',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Vperencanaan(
                                  data: widget.data, nip: widget.nip),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 1, 46, 76),
                        ),
                        child: Text(
                          'Back',
                          style: TextStyle(
                              color: Color.fromARGB(255, 226, 228, 231)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - 200,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
              columnSpacing: 150.0,
              horizontalMargin: 150.0,
              columns: [
                DataColumn(
                  label: Container(
                    padding: EdgeInsets.symmetric(horizontal: 1.0),
                    child: Text(
                      'ID Lot',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    padding: EdgeInsets.symmetric(horizontal: 1.0),
                    child: Text(
                      'Nama Produk',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                DataColumn(
                  label: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Text(
                          'Kode Lot',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                DataColumn(
                  label: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Text(
                          'No Produk',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              rows: [
                DataRow(
                  cells: [
                    DataCell(
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(idLotcontroller.text),
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
                          child: Text(kodeLotcontroller.text),
                        ),
                      ),
                    ),
                    DataCell(
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(noProdukcontroller.text),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
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
          _buildListTile('After Sales', Icons.headset_mic, 6, 35),
          _buildAdminMenu(),
          _buildListTile('Logout', Icons.logout, 9, 35),
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
        if (index == 9) {
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
                    AdminDashboard(data: widget.data, nip: widget.nip),
              ),
            );
          } else if (index == 6) {
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
        _buildSubListTile('Report STTPP', Icons.receipt, 2, 35),
        _buildSubListTile('Perencanaan', Icons.calendar_today, 3, 35),
        _buildSubListTile('Input Kebutuhan Material', Icons.assignment, 4, 35),
        _buildSubListTile('Input Dokumen Pendukung', Icons.file_present, 5, 35),
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
        if (index == 9) {
          _showLogoutDialog();
        } else {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ReportSTTPP(data: widget.data, nip: widget.nip),
              ),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Perencanaan(data: widget.data, nip: widget.nip),
              ),
            );
          } else if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    InputMaterial(data: widget.data, nip: widget.nip),
              ),
            );
          } else if (index == 5) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    InputDokumen(data: widget.data, nip: widget.nip),
              ),
            );
          } else if (index == 7) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    TambahProject(data: widget.data, nip: widget.nip),
              ),
            );
          } else if (index == 8) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    TambahStaff(data: widget.data, nip: widget.nip),
              ),
            );
          }
        }
      },
    );
  }

  Widget _buildAdminMenu() {
    return ExpansionTile(
      title: Row(
        children: [
          Icon(
            Icons.admin_panel_settings,
            size: 35,
            color: Color.fromARGB(255, 6, 37, 55),
          ),
          SizedBox(width: 12),
          Text('Menu Admin'),
        ],
      ),
      children: [
        _buildSubListTile('Tambah Project', Icons.assignment_add, 7, 35),
        _buildSubListTile('Tambah User', Icons.assignment_ind_rounded, 8, 35),
      ],
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
