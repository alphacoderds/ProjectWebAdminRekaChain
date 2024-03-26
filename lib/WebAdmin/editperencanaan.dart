import 'dart:convert';
import 'package:RekaChain/WebAdmin/AfterSales.dart';
import 'package:RekaChain/WebAdmin/Cetak.dart';
import 'package:RekaChain/WebUser/dasboard.dart';
import 'package:RekaChain/WebAdmin/inputdokumen.dart';
import 'package:RekaChain/WebAdmin/inputkebutuhanmaterial.dart';
import 'package:RekaChain/WebAdmin/login.dart';
import 'package:RekaChain/WebAdmin/notification.dart';
import 'package:RekaChain/WebAdmin/perencanaan.dart';
import 'package:RekaChain/WebAdmin/profile.dart';
import 'package:RekaChain/WebAdmin/reportsttpp.dart';
import 'package:RekaChain/WebAdmin/tambahproject.dart';
import 'package:RekaChain/WebAdmin/tambahstaff.dart';
import 'package:RekaChain/WebUser/viewperencanaan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditPerencanaan extends StatefulWidget {
  final Map<String, dynamic> selectedProject;
  const EditPerencanaan({Key? key, this.selectedProject = const {}})
      : super(key: key);

  @override
  State<EditPerencanaan> createState() => _EditPerencanaanState();
}

class _EditPerencanaanState extends State<EditPerencanaan> {
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;
  bool isViewVisible = false;

  int _selectedIndex = 0;
  String? selectedValue1;
  String? selectedValue2;

  List<TableRowData> rowsData = [];
  List<Map<String, dynamic>> _listdata = [];

  TextEditingController idProjectcontroller = TextEditingController();
  TextEditingController noProdukcontroller = TextEditingController();
  TextEditingController noSeriAwalcontroller = TextEditingController();
  TextEditingController namaProdukcontroller = TextEditingController();
  TextEditingController jumlahLotcontroller = TextEditingController();
  TextEditingController kodeLotcontroller = TextEditingController();
  TextEditingController noSeriAkhircontroller = TextEditingController();
  TextEditingController tglMulaicontroller = TextEditingController();
  TextEditingController tglSelesaicontroller = TextEditingController();
  TextEditingController alurProsescontroller = TextEditingController();
  TextEditingController kategoricontroller = TextEditingController();
  TextEditingController detailcontroller = TextEditingController();

  void fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.9.3/ProjectWebAdminRekaChain/lib/Project/edit.php?id_project=${widget.selectedProject['id_project']}&kodeLot=${widget.selectedProject['kodeLot']}'),
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

//===========================================================Widget Tambah Table Alur===========================================================//
  void addRow() {
    setState(() {
      // Inisialisasi controller baru untuk setiap baris baru
      TextEditingController newalurprosesController = TextEditingController();
      TextEditingController newkategoriController = TextEditingController();
      TextEditingController newdetailController = TextEditingController();
      rowsData.add(TableRowData(
        alurProsescontroller: newalurprosesController,
        kategoricontroller: newkategoriController,
        detailcontroller: newdetailController,
      ));
    });
  }

  @override
  void initState() {
    super.initState();
    noProdukcontroller = TextEditingController(
        text: widget.selectedProject['noIndukProduk'] ?? '');
    idProjectcontroller =
        TextEditingController(text: widget.selectedProject['id_project'] ?? '');
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
    alurProsescontroller =
        TextEditingController(text: widget.selectedProject['alurProses'] ?? '');
    kategoricontroller =
        TextEditingController(text: widget.selectedProject['kategori'] ?? '');
    detailcontroller =
        TextEditingController(text: widget.selectedProject['keterangan'] ?? '');

    fetchData();

    noProdukcontroller.addListener(_calculateKodeLot);
    jumlahLotcontroller.addListener(_calculateKodeLot);
    addRow();
  }

  @override
  void dispose() {
    noProdukcontroller.dispose();
    jumlahLotcontroller.dispose();
    kodeLotcontroller.dispose();
    super.dispose();
  }

  void _calculateKodeLot() {
    setState(() {
      kodeLotcontroller.text =
          '${noProdukcontroller.text} - ${jumlahLotcontroller.text}';
    });
  }

  // Fungsi untuk memperbarui nilai dropdown Alur Proses
  void onAlurProsesChanged(String? newValue, int index) {
    setState(() {
      rowsData[index].alurProsescontroller.text = newValue ?? '';
    });
  }

// Fungsi untuk memperbarui nilai dropdown Kategori
  void onKategoriChanged(String? newValue, int index) {
    setState(() {
      rowsData[index].kategoricontroller.text = newValue ?? '';
    });
  }

  void onDetailChanged(String? newValue, int index) {
    setState(() {
      rowsData[index].detailcontroller.text = newValue ?? '';
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
                  builder: (context) => const EditPerencanaan(),
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
                            backgroundColor:
                                const Color.fromRGBO(43, 56, 86, 1),
                            toolbarHeight: 65,
                            title: Padding(
                              padding:
                                  EdgeInsets.only(left: screenHeight * 0.01),
                              child: Text(
                                'Detail Proses',
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
                                            builder: (context) =>
                                                Vperencanaan(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'View',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor:
                                            Color.fromARGB(255, 89, 100, 122),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
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
                                    width: screenWidth * 0.7,
                                    height: screenHeight * 0.8,
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 220,
                                                      height: 40,
                                                      child: TextFormField(
                                                        controller:
                                                            idProjectcontroller,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          2),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3),
                                                            borderSide:
                                                                BorderSide(
                                                                    width: 1),
                                                          ),
                                                        ),
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
                                                      'No Induk Finish Produk',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 15),
                                                    ),
                                                    SizedBox(
                                                      width: 220,
                                                      height: 40,
                                                      child: TextFormField(
                                                        controller:
                                                            noProdukcontroller,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          2),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3),
                                                            borderSide:
                                                                BorderSide(
                                                                    width: 1),
                                                          ),
                                                        ),
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
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 220,
                                                      height: 40,
                                                      child: TextFormField(
                                                        controller:
                                                            noSeriAwalcontroller,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          2),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3),
                                                            borderSide:
                                                                BorderSide(
                                                                    width: 1),
                                                          ),
                                                        ),
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
                                                      width: 225,
                                                      child: TextField(
                                                          textAlignVertical:
                                                              TextAlignVertical
                                                                  .center,
                                                          textAlign:
                                                              TextAlign.center,
                                                          controller:
                                                              tglMulaicontroller,
                                                          readOnly: true,
                                                          onTap: () {
                                                            _selectDate(
                                                                tglMulaicontroller);
                                                          },
                                                          decoration: InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
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
                                                      child: TextFormField(
                                                        controller:
                                                            namaProdukcontroller,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          2),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3),
                                                            borderSide:
                                                                BorderSide(
                                                                    width: 1),
                                                          ),
                                                        ),
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
                                                      child: TextFormField(
                                                        controller:
                                                            jumlahLotcontroller,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          2),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3),
                                                            borderSide:
                                                                BorderSide(
                                                                    width: 1),
                                                          ),
                                                        ),
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
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 40,
                                                      width: 150,
                                                      child: TextFormField(
                                                        controller:
                                                            kodeLotcontroller,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          15),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .black45),
                                                          ),
                                                        ),
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
                                                      'No Seri Akhir',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 15),
                                                    ),
                                                    SizedBox(
                                                      width: 220,
                                                      height: 40,
                                                      child: TextFormField(
                                                        controller:
                                                            noSeriAkhircontroller,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          2),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3),
                                                            borderSide:
                                                                BorderSide(
                                                                    width: 1),
                                                          ),
                                                        ),
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
                                                      'Target Selesai',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 15),
                                                    ),
                                                    SizedBox(
                                                      height: 40,
                                                      width: 225,
                                                      child: TextField(
                                                          textAlignVertical:
                                                              TextAlignVertical
                                                                  .center,
                                                          textAlign:
                                                              TextAlign.center,
                                                          controller:
                                                              tglSelesaicontroller,
                                                          readOnly: true,
                                                          onTap: () {
                                                            _selectDate(
                                                                tglSelesaicontroller);
                                                          },
                                                          decoration: InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
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
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Cetak(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Cetak',
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    43, 56, 86, 1),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20),
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
                                                const Color.fromRGBO(
                                                    43, 56, 86, 1),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        ElevatedButton(
                                          onPressed: () {
                                            _updateDataAndNavigateToListProject();
                                          },
                                          child: Text(
                                            'Simpan',
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    43, 56, 86, 1),
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
      },
    );
  }

  void _updateDataAndNavigateToListProject() async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://192.168.9.3/ProjectWebAdminRekaChain/lib/Project/edit.php'),
        body: {
          "id_project": idProjectcontroller.text,
          "noIndukProduk": noProdukcontroller.text,
          "noSeriAwal": noSeriAwalcontroller.text,
          "targetMulai": tglMulaicontroller.text,
          "namaProduk": namaProdukcontroller.text,
          "jumlahLot": jumlahLotcontroller.text,
          "kodeLot": kodeLotcontroller.text,
          "noSeriAkhir": noSeriAkhircontroller.text,
          "targetSelesai": tglSelesaicontroller.text,
          "alurProses": alurProsescontroller.text,
          "kategori": kategoricontroller.text,
          "keterangan": detailcontroller.text,
        },
      );

      if (response.statusCode == 200) {
        _showFinishDialog();
      } else {
        print('Failed to update data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating data: $e');
    }
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
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                DataCell(Container(
                  height: 100,
                  width: 100,
                  child: TextFormField(
                    controller: rowData.alurProsescontroller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8),
                    ),
                    onChanged: (newValue) {
                      if (newValue.isNotEmpty) {
                        setState(() {
                          rowData.alurProsescontroller.text =
                              newValue.substring(0, 100000);
                        });
                      }
                    },
                  ),
                )),
                DataCell(Container(
                  height: 100,
                  width: 100,
                  child: TextFormField(
                    controller: rowData.kategoricontroller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8),
                    ),
                    onChanged: (newValue) {
                      if (newValue.isNotEmpty) {
                        setState(() {
                          rowData.kategoricontroller.text =
                              newValue.substring(0, 100000);
                        });
                      }
                    },
                  ),
                )),
                DataCell(Container(
                  height: 100,
                  width: 300,
                  child: TextFormField(
                    controller: rowData.detailcontroller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8),
                    ),
                    onChanged: (newValue) {
                      if (newValue.isNotEmpty) {
                        setState(() {
                          rowData.detailcontroller.text =
                              newValue.substring(0, 100000);
                        });
                      }
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
                builder: (context) => UserDashboard(),
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

  void _showFinishDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Simpan Data", style: TextStyle(color: Colors.white)),
          content: Text("Apakah Anda yakin ingin simpan data?",
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
                  MaterialPageRoute(builder: (context) => Vperencanaan()),
                );
              },
              child: Text("Ya", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
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
  TextEditingController alurProsescontroller;
  TextEditingController kategoricontroller;
  TextEditingController detailcontroller;
  TableRowData({
    required this.alurProsescontroller,
    required this.kategoricontroller,
    required this.detailcontroller,
  });
}
