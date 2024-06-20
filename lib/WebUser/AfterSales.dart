import 'dart:convert';
import 'package:RekaChain/WebUser/dasboard.dart';
import 'package:RekaChain/WebAdmin/data_model.dart';
import 'package:RekaChain/WebUser/inputdokumen.dart';
import 'package:RekaChain/WebUser/inputkebutuhanmaterial.dart';
import 'package:RekaChain/WebAdmin/login.dart';
import 'package:RekaChain/WebUser/notification.dart';
import 'package:RekaChain/WebUser/perencanaan.dart';
import 'package:RekaChain/WebUser/profile.dart';
import 'package:RekaChain/WebUser/reportsttpp.dart';
import 'package:RekaChain/WebUser/viewaftersales.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AfterSales extends StatefulWidget {
  final Map<String, dynamic>? newProject;
  final DataModel data;
  final String nip;
  const AfterSales(
      {Key? key, this.newProject, required this.data, required this.nip})
      : super(key: key);
  @override
  State<AfterSales> createState() => _AfterSalesState();
}

class _AfterSalesState extends State<AfterSales> {
  int _selectedIndex = 0;
  bool isViewVisible = false;
  late double screenWidth;
  late double screenHeight;

  List _listdata = [];
  bool _isloading = true;

  String _searchQuery = '';

  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  Future _getdata() async {
    try {
      final response = await http.get(
        Uri.parse(
          'http://192.168.11.107/ProjectWebAdminRekaChain/lib/Project/readlot.php',
        ),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        final filteredData = data
            .where((item) =>
                item['saran'] != null && item['saran'].toString().isNotEmpty)
            .toList();

        setState(() {
          _listdata = filteredData;
          _isloading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getdata();
    super.initState();
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
              builder: (context) => AfterSales(
                data: widget.data,
                nip: widget.nip,
              ),
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
                      'After Sales',
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
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 8),
                                Expanded(
                                  child: TextField(
                                    onChanged: _updateSearchQuery,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Cari',
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.search,
                                    size: 30,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
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
                                        nip: widget.nip, data: widget.data)),
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
  }

  Widget _buildMainTable() {
    List filteredData = _listdata.where((data) {
      String id_lot = data['id_lot'] ?? '';
      String id_project = data['id_project'] ?? '';
      String namaProject = data['namaProject'] ?? '';
      String kodeLot = data['kodeLot'] ?? '';
      String noProduk = data['noProduk'] ?? '';
      String targetMulai = data['targetMulai'] ?? '';
      return id_lot.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          id_project.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          namaProject.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          kodeLot.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          noProduk.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          targetMulai.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
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
              columnSpacing: 100.0,
              horizontalMargin: 110.0,
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
                      'Nomor Produk',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                DataColumn(
                  label: Center(
                    child: Text(
                      'Tanggal Project',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                DataColumn(
                  label: Center(
                    child: Text(
                      'View',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ],
              rows: filteredData
                  .asMap()
                  .map(
                    (index, data) => MapEntry(
                      index,
                      DataRow(
                        cells: [
                          DataCell(
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                alignment: Alignment.center,
                                child: Text((index + 1).toString()),
                              ),
                            ),
                          ),
                          DataCell(
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(data['namaProject'] ?? ''),
                              ),
                            ),
                          ),
                          DataCell(
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(data['kodeLot'] ?? ''),
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
                                child: Text(data['targetMulai'] ?? ''),
                              ),
                            ),
                          ),
                          DataCell(
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Center(
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.visibility),
                                      onPressed: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ViewAfterSales(
                                              nip: widget.nip,
                                              data: widget.data,
                                              selectedProject: {
                                                "id_lot": filteredData[index]
                                                    ['id_lot'],
                                                "kodeLot": filteredData[index]
                                                    ['kodeLot'],
                                                "id_project":
                                                    filteredData[index]
                                                        ['id_project'],
                                                "noProduk": filteredData[index]
                                                    ['noProduk'],
                                                "namaProject":
                                                    filteredData[index]
                                                        ['namaProject'],
                                                "targetMulai":
                                                    filteredData[index]
                                                        ['targetMulai'],
                                                "detail_kerusakan":
                                                    filteredData[index]
                                                        ['detail_kerusakan'],
                                                "item": filteredData[index]
                                                    ['item'],
                                                "keterangan":
                                                    filteredData[index]
                                                        ['keterangan'],
                                                "saran": filteredData[index]
                                                    ['saran'],
                                              },
                                            ),
                                          ),
                                        ).then((result) {
                                          if (result != null && result) {}
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .values
                  .toList(),
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
