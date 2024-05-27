import 'dart:convert';
import 'dart:html';

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
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:barcode_widget/barcode_widget.dart';

class ViewReportSTTPP extends StatefulWidget {
  final Map<String, dynamic> selectedProject;
  final DataModel data;
  final String nip;
  const ViewReportSTTPP({Key? key, this.selectedProject = const {}, required this.data, required this.nip})
      : super(key: key);


  @override
  State<ViewReportSTTPP> createState() => _ViewReportSTTPState();
}

class _ViewReportSTTPState extends State<ViewReportSTTPP> {
  bool isViewVisible = false;
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;

  int _selectedIndex = 0;

  TextEditingController idLotcontroller = TextEditingController();
  TextEditingController namaProjectcontroller = TextEditingController();
  TextEditingController noProdukcontroller = TextEditingController();
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

  void fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.8.152/ProjectWebAdminRekaChain/lib/Project/edit_aftersales.php?nama=${widget.selectedProject['nama']}&noProduk=${widget.selectedProject['noProduk']}'),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final noProduk = responseData['noProduk'];
        setState(() {
          noProdukcontroller.text = noProduk;
        });
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
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
                  builder: (context) => ViewReportSTTPP(data: widget.data,nip: widget.nip),
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
                                onPressed: () {},
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
                                        builder: (context) => Notifikasi(nip: widget.nip, data: widget.data)),
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
                                        builder: (context) => Profile(data: widget.data,nip: widget.nip)),
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
              columnSpacing: 200.0,
              horizontalMargin: 100.0,
              columns: [
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
                      'Tanggal Mulai',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                DataColumn(
                  label: Center(
                    child: Text(
                      'Tanggal Selesai',
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
              rows: [
                DataRow(cells: [
                  DataCell(
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text((1).toString()),
                      ),
                    ),
                  ),
                  DataCell(
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        alignment: Alignment.center,
                        child: qrCodeWidget ?? Container(),
                      ),
                    ),
                  ),
                  DataCell(
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(alurProses1controller.text),
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
                        child: Text('1'),
                      ),
                    ),
                  ),
                  DataCell(
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text('1'),
                      ),
                    ),
                  ),
                ]),
              ],
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
                builder: (context) => AdminDashboard(nip: widget.nip, data: widget.data),
              ),
            );
          } else if (index == 6) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AfterSales(nip: widget.nip, data: widget.data),
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
                builder: (context) => ReportSTTPP(data: widget.data,nip: widget.nip),
              ),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Perencanaan(nip: widget.nip, data: widget.data),
              ),
            );
          } else if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InputMaterial(nip: widget.nip, data: widget.data),
              ),
            );
          } else if (index == 5) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InputDokumen(data: widget.data,nip: widget.nip),
              ),
            );
          } else if (index == 7) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TambahProject(nip: widget.nip, data: widget.data),
              ),
            );
          } else if (index == 8) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TambahStaff(nip: widget.nip, data: widget.data),
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
                  MaterialPageRoute(builder: (context) => LoginPage(data: widget.data,nip: widget.nip)),
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
