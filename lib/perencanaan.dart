import 'package:RekaChain/dasboard.dart';
import 'package:RekaChain/inputdokumen.dart';
import 'package:RekaChain/inputkebutuhanmaterial.dart';
import 'package:RekaChain/login.dart';
import 'package:RekaChain/notification.dart';
import 'package:RekaChain/profile.dart';
import 'package:RekaChain/reportsttpp.dart';
import 'package:RekaChain/viewperencanaan.dart';
import 'package:flutter/material.dart';

class Perencanaan extends StatefulWidget {
  const Perencanaan({super.key});

  @override
  State<Perencanaan> createState() => _PerencanaanState();
}

class _PerencanaanState extends State<Perencanaan> {
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;
  bool isViewVisible = false;

  int _selectedIndex = 0;
  late List<String> dropdownItems;
  String? selectedValue;

  late List<String> dropdownItemsAlurProses;
  String? selectedValueAlurProses;

  late List<String> dropdownItemsKategori;
  String? selectedValueKategori;

  List<TableRowData> rowsData = [];

//===========================================================Widget Tambah Table Alur===========================================================//
  void addRow() {
    setState(() {
      rowsData.add(TableRowData(
        selectedAlurProses: null,
        selectedKategori: null,
        detail: '',
      ));
    });
  }

  void initState() {
    super.initState();
    // Tambahkan satu baris awal
    rowsData.add(TableRowData(
      selectedAlurProses: null,
      selectedKategori: null,
      detail: '',
    ));
  }

  // Fungsi untuk memperbarui nilai dropdown Alur Proses
  void onAlurProsesChanged(String? newValue) {
    setState(() {
      selectedValueAlurProses = newValue;
    });
  }

// Fungsi untuk memperbarui nilai dropdown Kategori
  void onKategoriChanged(String? newValue) {
    setState(() {
      selectedValueKategori = newValue;
    });
  }

  TextEditingController tglMulaicontroller = TextEditingController();
  TextEditingController tglSelesaicontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    dropdownItems = ['R22-PT. Nugraha Jasa', 'PT. INDAH JAYA'];

    dropdownItemsAlurProses = ['PPC', 'Produksi'];

    dropdownItemsKategori = ['Produk', 'Material'];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => const Perencanaan(),
            );
          default:
            return null;
        }
      },
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 244, 249, 255),
        body: Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDrawer(),
              Expanded(
                  child: Scaffold(
//===========================================================Appbar===========================================================//
                      appBar: AppBar(
                        backgroundColor: const Color.fromRGBO(43, 56, 86, 1),
                        toolbarHeight: 65,
                        title: Padding(
                          padding: EdgeInsets.only(left: screenHeight * 0.01),
                          child: Text(
                            'Input Proses',
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
                            padding:
                                EdgeInsets.only(right: screenHeight * 0.13),
                            child: Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Vperencanaan(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'View',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor:
                                        Color.fromARGB(255, 89, 100, 122),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 3),
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth * 0.005,
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.notifications_active,
                                    size: 33,
                                    color: Colors.white,
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
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Profile(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),

//===========================================================Body Tambah Project===========================================================//
                      body: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.05,
                              horizontal: screenWidth * 0.02),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: screenWidth * 0.6,
                                height: screenHeight * 0.8,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: screenHeight * 0.05,
                                      horizontal: screenWidth * 0.05),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Project',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15),
                                                ),
                                                Container(
                                                  width: 225,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                              Colors.black54),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3)),
                                                  child: DropdownButton<String>(
                                                    alignment: Alignment.center,
                                                    hint: Text(
                                                        '--Pilih Nama/Kode Project--',
                                                        style: TextStyle(
                                                            fontSize: 15)),
                                                    value: selectedValue,
                                                    underline: SizedBox(),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    items: dropdownItems
                                                        .map((String value) {
                                                      return DropdownMenuItem<
                                                              String>(
                                                          value: value,
                                                          child: Text(value));
                                                    }).toList(),
                                                    onChanged: (newValue) {
                                                      setState(() {
                                                        selectedValue =
                                                            newValue;
                                                      });
                                                    },
                                                    dropdownColor: Colors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 40),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'No Induk Finish Produk',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15),
                                                ),
                                                SizedBox(
                                                  width: 220,
                                                  height: 40,
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        2),
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3),
                                                            borderSide:
                                                                BorderSide(
                                                                    width: 1))),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 120),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'No Seri Awal',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15),
                                                ),
                                                SizedBox(
                                                  width: 150,
                                                  height: 40,
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        15,
                                                                    vertical:
                                                                        2),
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            borderSide:
                                                                BorderSide(
                                                                    width: 1))),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 30),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Target Mulai',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15),
                                                ),
                                                SizedBox(
                                                  height: 40,
                                                  width: 150,
                                                  child: TextField(
                                                      textAlignVertical:
                                                          TextAlignVertical
                                                              .center,
                                                      textAlign: TextAlign
                                                          .center,
                                                      controller:
                                                          tglMulaicontroller,
                                                      readOnly: true,
                                                      onTap: () {
                                                        _selectDate(
                                                            tglMulaicontroller);
                                                      },
                                                      decoration: InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          15,
                                                                      vertical:
                                                                          2),
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              borderSide:
                                                                  BorderSide(
                                                                      width:
                                                                          1)))),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(width: screenWidth * 0.2),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Nama Produk',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15),
                                                ),
                                                SizedBox(
                                                  width: 220,
                                                  height: 40,
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        2),
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3),
                                                            borderSide:
                                                                BorderSide(
                                                                    width: 1))),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 40),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Jumlah dalam 1 lot',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15),
                                                ),
                                                SizedBox(
                                                  width: 220,
                                                  height: 40,
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        2),
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3),
                                                            borderSide:
                                                                BorderSide(
                                                                    width: 1))),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 30),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Kode Lot',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15),
                                                ),
                                                Container(
                                                    height: 40,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15),
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.black45),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: Text(''))
                                              ],
                                            ),
                                            SizedBox(height: 30),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'No Seri Akhir',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15),
                                                ),
                                                SizedBox(
                                                  height: 40,
                                                  width: 150,
                                                  child: TextField(
                                                      decoration: InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          15,
                                                                      vertical:
                                                                          2),
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              borderSide:
                                                                  BorderSide(
                                                                      width:
                                                                          1)))),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 30),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Target Selesai',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15),
                                                ),
                                                SizedBox(
                                                  height: 40,
                                                  width: 150,
                                                  child: TextField(
                                                      textAlignVertical:
                                                          TextAlignVertical
                                                              .center,
                                                      textAlign: TextAlign
                                                          .center,
                                                      controller:
                                                          tglSelesaicontroller,
                                                      readOnly: true,
                                                      onTap: () {
                                                        _selectDate(
                                                            tglSelesaicontroller);
                                                      },
                                                      decoration: InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          15,
                                                                      vertical:
                                                                          2),
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              borderSide:
                                                                  BorderSide(
                                                                      width:
                                                                          1)))),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),

//===========================================================Body Tambah Kolom dan Button===========================================================//

                              SizedBox(width: 40),
                              Container(
                                alignment: Alignment.center,
                                width: screenWidth * 0.6,
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                margin: EdgeInsets.all(50.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: _buildMainTable(),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        addRow();
                                      },
                                      child: Text(
                                        'Tambah Kolom',
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor:
                                            const Color.fromRGBO(43, 56, 86, 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Vperencanaan(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Simpan',
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor:
                                            const Color.fromRGBO(43, 56, 86, 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ])
                            ],
                          ),
                        ),
                      )))
            ],
          ),
        ),
      ),
    );
  }

//===========================================================Widget DatePicker===========================================================//
  Future<void> _selectDate(TextEditingController controller) async {
    DateTime? _picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (_picked != null) {
      setState(() {
        controller.text = _picked.toString().split(" ")[0];
      });
    }
  }

//===========================================================Widget Table Alur===========================================================//
  Widget _buildMainTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - 50,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 100.0,
            horizontalMargin: 30.0,
            columns: [
              DataColumn(
                label: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Alur Proses',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataColumn(
                label: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Kategori',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataColumn(
                label: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Detail/Keterangan',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
            rows: rowsData.map((TableRowData rowData) {
              return DataRow(cells: [
                DataCell(DropdownButton<String>(
                  value: rowData.selectedAlurProses,
                  hint: Text('--Pilih Alur Proses--'),
                  items: dropdownItemsAlurProses.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      rowData.selectedAlurProses = newValue;
                    });
                  },
                  focusColor: Colors.white,
                )),
                DataCell(DropdownButton<String>(
                  value: rowData.selectedKategori,
                  hint: Text('--Pilih Kategori--'),
                  items: dropdownItemsKategori.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      rowData.selectedKategori = newValue;
                    });
                  },
                  focusColor: Colors.white,
                )),
                DataCell(Container(
                  height: 100,
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    maxLines: 5,
                    onChanged: (newValue) {
                      setState(() {
                        rowData.detail = newValue;
                      });
                    },
                  ),
                )),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildViewTable() {
    return DataTable(
      columnSpacing: 70.0,
      horizontalMargin: 90.0,
      columns: [
        DataColumn(label: Text('Item')),
        DataColumn(label: Text('Item')),
        DataColumn(label: Text('Keterangan')),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text('')),
          DataCell(Text('')),
          DataCell(Text('')),
        ]),
        DataRow(cells: [
          DataCell(Text('')),
          DataCell(Text('')),
          DataCell(Text('')),
        ]),
      ],
    );
  }

//===========================================================Widget Sidebar===========================================================//
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
          _buildListTile('Logout', Icons.logout, 7, 35),
        ],
      ),
    );
  }

  Widget _buildListTile(String title, IconData icon, int index, int size) {
    return ListTile(
      title: Text(title),
      leading: Icon(
        color: Color.fromARGB(255, 6, 37, 55),
        icon,
        size: size.toDouble(),
      ),
      onTap: () {
        if (index == 7) {
          _showLogoutDialog();
        } else {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Dashboard(),
              ),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Perencanaan(),
              ),
            );
          } else {
            Navigator.pop(context);
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
      ),
      onTap: () {
        if (index == 7) {
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
            Navigator.pop(context);
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

class TableRowData {
  String? selectedAlurProses;
  String? selectedKategori;
  String detail;

  TableRowData(
      {this.selectedAlurProses, this.selectedKategori, required this.detail});
}
