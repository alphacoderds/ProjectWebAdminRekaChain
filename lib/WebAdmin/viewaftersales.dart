import 'dart:convert';
import 'dart:html';
import 'package:csv/csv.dart';
import 'package:excel/excel.dart' as excel;
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

class ViewAfterSales extends StatefulWidget {
  final Map<String, dynamic> selectedProject;
  final DataModel data;
  final String nip;
  const ViewAfterSales(
      {Key? key,
      this.selectedProject = const {},
      required this.nip,
      required this.data})
      : super(key: key);

  @override
  State<ViewAfterSales> createState() => _ViewAfterSalesState();
}

class _ViewAfterSalesState extends State<ViewAfterSales> {
  int _selectedIndex = 0;

  late double screenWidth;
  late double screenHeight;

  List _listdata = [];
  bool _isloading = true;

  TextEditingController namaProjectcontroller = TextEditingController();
  TextEditingController kodeLotcontroller = TextEditingController();
  TextEditingController noProdukcontroller = TextEditingController();
  TextEditingController tglMulaicontroller = TextEditingController();
  TextEditingController dtlKekurangancontroller = TextEditingController();
  TextEditingController itemcontroller = TextEditingController();
  TextEditingController keterangancontroller = TextEditingController();
  TextEditingController sarancontroller = TextEditingController();

  void fetchData() async {
    try {
      final noProduk = widget.selectedProject['noProduk'] ?? '';
      final nama = widget.selectedProject['nama'] ?? '';

      final response = await http.get(
        Uri.parse(
          'http://192.168.10.102/ProjectWebAdminRekaChain/lib/Project/edit_aftersales.php?nama=$nama&noProduk=$noProduk',
        ),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        setState(() {
          noProdukcontroller.text = responseData['noProduk'] ?? 'N/A';
          kodeLotcontroller.text = responseData['kodeLot'] ?? 'N/A';
          namaProjectcontroller.text = responseData['nama'] ?? 'N/A';
          sarancontroller.text = responseData['saran'] ?? 'N/A';
        });
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void fetchDataKerusakan() async {
    try {
      final idProject = widget.selectedProject['id_lot'];
      print('id_project: $idProject');

      final response = await http.get(
        Uri.parse(
          'http://192.168.10.102/ProjectWebAdminRekaChain/lib/Project/read_aftersales.php?id_project=$idProject',
        ),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData.isNotEmpty) {
          final firstItem = responseData[0];

          setState(() {
            dtlKekurangancontroller.text =
                firstItem['detail_kerusakan'] ?? 'N/A';
            itemcontroller.text = firstItem['item'] ?? 'N/A';
            keterangancontroller.text = firstItem['keterangan'] ?? 'N/A';
            _listdata = responseData;
            _isloading = false;
          });
        } else {
          print('No data found in the response');
        }
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
                // Kode pengunduhan CSV dimulai dari sini
                String? nama =
                    _listdata.isNotEmpty ? _listdata[0]['nama'] : 'default';
                String? kodeLot =
                    _listdata.isNotEmpty ? _listdata[0]['kodeLot'] : 'default';

                String finalNama = nama ?? 'default';
                String finalKodeLot = kodeLot ?? 'default';

                List<List<dynamic>> rows = [
                  [
                    'No',
                    'Nama Project',
                    'Kode Lot',
                    'No Produk',
                    'Detail Kerusakan',
                    'Item',
                    'Keterangan',
                    'Saran',
                  ]
                ];

                int rowIndex = 1;
                for (var data in _listdata) {
                  final nama = data['nama'];
                  final kodeLot = data['kodeLot'];

                  rows.add([
                    rowIndex.toString(),
                    nama ?? '',
                    kodeLot ?? '',
                    data['noProduk'] ?? '',
                    data['detail_kerusakan'] ?? '',
                    data['item'] ?? '',
                    data['keterangan'] ?? '',
                    data['saran'] ?? '',
                  ]);
                  rowIndex++;
                }

                String csv = const ListToCsvConverter().convert(rows);
                final bytes = utf8.encode(csv);
                final blob = Blob([bytes]);
                final url = Url.createObjectUrlFromBlob(blob);
                AnchorElement(href: url)
                  ..setAttribute(
                      "download", "Aftersales/$finalNama-$finalKodeLot.csv")
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
    fetchDataKerusakan();

    noProdukcontroller =
        TextEditingController(text: widget.selectedProject['noProduk'] ?? '');
    kodeLotcontroller =
        TextEditingController(text: widget.selectedProject['kodeLot'] ?? '');
    namaProjectcontroller =
        TextEditingController(text: widget.selectedProject['nama'] ?? '');
    tglMulaicontroller = TextEditingController(
        text: widget.selectedProject['targetMulai'] ?? '');
    dtlKekurangancontroller = TextEditingController(
        text: widget.selectedProject['detail_kerusakan'] ?? '');
    itemcontroller =
        TextEditingController(text: widget.selectedProject['item'] ?? '');
    keterangancontroller =
        TextEditingController(text: widget.selectedProject['keterangan'] ?? '');
    sarancontroller =
        TextEditingController(text: widget.selectedProject['saran'] ?? '');
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
              builder: (context) =>
                  ViewAfterSales(data: widget.data, nip: widget.nip),
            );
          default:
            return null;
        }
      },
      home: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(
                builder: (context) =>
                    ViewAfterSales(data: widget.data, nip: widget.nip),
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
                        'Detail After Sales',
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
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  body: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.05,
                          horizontal: screenWidth * 0.08),
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                              margin: EdgeInsets.all(50.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text('Nama Project : ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16)),
                                            Text(namaProjectcontroller.text,
                                                style: TextStyle(fontSize: 16)),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Text('Kode Lot         : ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16)),
                                            Text(kodeLotcontroller.text,
                                                style: TextStyle(fontSize: 16)),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Text('No Produk      : ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16)),
                                            Text(noProdukcontroller.text,
                                                style: TextStyle(fontSize: 16)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(child: _buildMainTable()),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              color: Colors.black45)),
                                    ),
                                    height: screenHeight * 0.3,
                                    padding: EdgeInsets.fromLTRB(30, 30, 0, 10),
                                    alignment: Alignment.topLeft,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Saran :',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(sarancontroller.text,
                                              style: TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
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
            horizontalMargin: 70.0,
            columns: [
              DataColumn(
                label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.0),
                  child: Text(
                    'No.',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              DataColumn(
                label: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Text(
                        'Detail Kerusakan',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
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
                        'Item',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
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
                        'Keterangan',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            rows: List<DataRow>.generate(
              _listdata.length,
              (index) {
                final item = _listdata[index];
                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        '${index + 1}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    DataCell(
                      Text(
                        item['detail_kerusakan'] ?? 'N/A',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    DataCell(
                      Text(
                        item['item'] ?? 'N/A',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    DataCell(
                      Text(
                        item['keterangan'] ?? 'N/A',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                );
              },
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
          _buildAdminMenu(),
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
                    AdminDashboard(nip: widget.nip, data: widget.data),
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
          } else if (index == 6) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    TambahProject(data: widget.data, nip: widget.nip),
              ),
            );
          } else if (index == 7) {
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
        _buildSubListTile('Tambah Project', Icons.assignment_add, 6, 35),
        _buildSubListTile('Tambah Staff', Icons.assignment_ind_rounded, 7, 35),
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
