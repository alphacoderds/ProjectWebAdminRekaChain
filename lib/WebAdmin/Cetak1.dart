import 'package:RekaChain/AfterSales/AfterSales.dart';
import 'package:RekaChain/WebAdmin/Cetak.dart';
import 'package:RekaChain/WebAdmin/DetailViewPerencanaan.dart';
import 'package:RekaChain/WebAdmin/dasboard.dart';
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

class Cetak1 extends StatefulWidget {
  @override
  State<Cetak1> createState() => _Cetak1State();
}

class _Cetak1State extends State<Cetak1> {
  int _selectedIndex = 0;

  List<String> dropdownItems = [
    '--Pilih Nama/Kode Project--',
    'R22-PT. Nugraha Jasa',
    'PT. INDAH JAYA'
  ];
  String? selectedValue;

  bool isViewVisible = false;
  late double screenWidth;
  late double screenHeight;

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
              builder: (context) => Cetak1(),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [],
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
                                  builder: (context) => Notifikasi(),
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
                                    builder: (context) => Profile()),
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
                                        'PT. Nugroho Jasa',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Container(child: _buildMainTable()),
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Cetak(),
                            ),
                          );
                        },
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
                              builder: (context) => DetailP(),
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
            columnSpacing: 182.0,
            horizontalMargin: 182.0,
            columns: [
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
                        'No Produk',
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
                        'QR Code',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('xxxxxx xxx xxxx')),
                DataCell(Text('xxxxxxxxxxxxxx')),
                DataCell(Icon(
                  Icons.qr_code_2,
                  size: 50,
                )),
              ]),
            ],
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
                builder: (context) => AdminDashboard(),
              ),
            );
          } else if (index == 6) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AfterSales(),
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
                builder: (context) => ReportSTTPP(),
              ),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Perencanaan(),
              ),
            );
          } else if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InputMaterial(),
              ),
            );
          } else if (index == 5) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InputDokumen(),
              ),
            );
          } else if (index == 7) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TambahProject(),
              ),
            );
          } else if (index == 8) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TambahStaff(),
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
                  MaterialPageRoute(builder: (context) => const LoginPage()),
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
