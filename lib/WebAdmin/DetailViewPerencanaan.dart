import 'dart:convert';
import 'package:RekaChain/WebAdmin/AfterSales.dart';
import 'package:RekaChain/WebAdmin/Cetak1.dart';
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
import 'package:RekaChain/WebAdmin/viewperencanaan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class DetailViewPerencanaan extends StatefulWidget {
  final Map<String, dynamic> selectedProject;
  const DetailViewPerencanaan({Key? key, this.selectedProject = const {}})
      : super(key: key);

  @override
  State<DetailViewPerencanaan> createState() => _DetailViewPerencanaanState();
}

class _DetailViewPerencanaanState extends State<DetailViewPerencanaan> {
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;
  bool isViewVisible = false;

  int _selectedIndex = 0;

  List<Map<String, dynamic>> _listdata = [];

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
            'http://192.168.11.182/ProjectWebAdminRekaChain/lib/Project/edit_perencanaan.php?nama=${widget.selectedProject['nama']}&kodeLot=${widget.selectedProject['kodeLot']}'),
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

  @override
  void initState() {
    super.initState();
    fetchData();
    noProdukcontroller = TextEditingController(
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

    jumlahLotcontroller.addListener(_batasiNoSeriAkhir);

    noProdukcontroller.addListener(_calculateKodeLot);
    noSeriAwalcontroller.addListener(_calculateKodeLot);
    noSeriAkhircontroller.addListener(_calculateKodeLot);
    tglMulaicontroller.addListener(_calculateKodeLot);
  }

  @override
  void dispose() {
    noProdukcontroller.dispose();
    noSeriAwalcontroller.dispose();
    noSeriAkhircontroller.dispose();
    tglMulaicontroller.dispose();
    kodeLotcontroller.dispose();
    super.dispose();
  }

  void _calculateKodeLot() {
    setState(() {
      final tahun = tglMulaicontroller.text.substring(6);

      kodeLotcontroller.text =
          '${noProdukcontroller.text} - ${noSeriAwalcontroller.text} - ${noSeriAkhircontroller.text} / $tahun';
    });
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
        final formattedDate = DateFormat('dd-MM-yy').format(_picked);
        controller.text = formattedDate;
      });
    }
  }

  void _batasiNoSeriAkhir() {
    int jumlahLot = int.tryParse(jumlahLotcontroller.text) ?? 0;
    int noSeriAkhir = int.tryParse(noSeriAkhircontroller.text) ?? 0;

    if (noSeriAkhir > jumlahLot) {
      setState(() {
        noSeriAkhircontroller.text = jumlahLot.toString();
      });
    }
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
                  builder: (context) => const DetailViewPerencanaan(),
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
                                                            namaProjectcontroller,
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
                                                        fontSize: 15,
                                                      ),
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
                                                      width: 220,
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
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable(
                                          columnSpacing: 100.0,
                                          horizontalMargin: 30.0,
                                          columns: [
                                            DataColumn(
                                              label: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.0),
                                                child: Text(
                                                  'Alur Proses',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20.0),
                                                child: Text(
                                                  'Kategori',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.0),
                                                child: Text(
                                                  'Detail/Keterangan',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                          rows: [
                                            DataRow(cells: [
                                              DataCell(
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        alurProses1controller
                                                            .text),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        kategori1controller
                                                            .text),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        detail1controller.text),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                            DataRow(cells: [
                                              DataCell(
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        alurProses2controller
                                                            .text),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        kategori2controller
                                                            .text),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        detail2controller.text),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                            DataRow(cells: [
                                              DataCell(
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        alurProses3controller
                                                            .text),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        kategori3controller
                                                            .text),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        detail3controller.text),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                            DataRow(cells: [
                                              DataCell(
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        alurProses4controller
                                                            .text),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        kategori4controller
                                                            .text),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        detail4controller.text),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                            DataRow(cells: [
                                              DataCell(
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        alurProses5controller
                                                            .text),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        kategori5controller
                                                            .text),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        detail5controller.text),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                            DataRow(cells: [
                                              DataCell(
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        alurProses6controller
                                                            .text),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        kategori6controller
                                                            .text),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        detail6controller.text),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                            DataRow(cells: [
                                              DataCell(
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        alurProses7controller
                                                            .text),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        kategori7controller
                                                            .text),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        detail7controller.text),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                            DataRow(cells: [
                                              DataCell(
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        alurProses8controller
                                                            .text),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        kategori8controller
                                                            .text),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        detail8controller.text),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                            DataRow(cells: [
                                              DataCell(
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        alurProses9controller
                                                            .text),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        kategori9controller
                                                            .text),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        detail9controller.text),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                            DataRow(cells: [
                                              DataCell(
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        alurProses10controller
                                                            .text),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        kategori10controller
                                                            .text),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        detail10controller
                                                            .text),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                          ]),
                                    ),
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(width: 20),
                                        ElevatedButton(
                                          onPressed: () {
                                            _updateData();
                                          },
                                          child: Text(
                                            'Kembali',
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

  void _updateData() async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://192.168.11.182/ProjectWebAdminRekaChain/lib/Project/edit_perencanaan.php'),
        body: {
          "nama": namaProjectcontroller.text,
          "noIndukProduk": noProdukcontroller.text,
          "noSeriAwal": noSeriAwalcontroller.text,
          "targetMulai": tglMulaicontroller.text,
          "namaProduk": namaProdukcontroller.text,
          "jumlahLot": jumlahLotcontroller.text,
          "kodeLot": kodeLotcontroller.text,
          "noSeriAkhir": noSeriAkhircontroller.text,
          "targetSelesai": tglSelesaicontroller.text,
          "ap1": alurProses1controller.text,
          "kategori1": kategori1controller.text,
          "keterangan1": detail1controller.text,
          "ap2": alurProses2controller.text,
          "kategori2": kategori2controller.text,
          "keterangan2": detail2controller.text,
          "ap3": alurProses3controller.text,
          "kategori3": kategori3controller.text,
          "keterangan3": detail3controller.text,
          "ap4": alurProses4controller.text,
          "kategori4": kategori4controller.text,
          "keterangan4": detail4controller.text,
          "ap5": alurProses5controller.text,
          "kategori5": kategori5controller.text,
          "keterangan5": detail5controller.text,
          "ap6": alurProses6controller.text,
          "kategori6": kategori6controller.text,
          "keterangan6": detail6controller.text,
          "ap7": alurProses7controller.text,
          "kategori7": kategori7controller.text,
          "keterangan7": detail7controller.text,
          "ap8": alurProses8controller.text,
          "kategori8": kategori8controller.text,
          "keterangan8": detail8controller.text,
          "ap9": alurProses9controller.text,
          "kategori9": kategori9controller.text,
          "keterangan9": detail9controller.text,
          "ap10": alurProses10controller.text,
          "kategori10": kategori10controller.text,
          "keterangan10": detail10controller.text,
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
