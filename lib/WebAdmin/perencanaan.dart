import 'dart:convert';
import 'package:RekaChain/WebAdmin/AfterSales.dart';
import 'package:RekaChain/WebAdmin/dasboard.dart';
import 'package:RekaChain/WebAdmin/data_model.dart';
import 'package:RekaChain/WebAdmin/inputdokumen.dart';
import 'package:RekaChain/WebAdmin/inputkebutuhanmaterial.dart';
import 'package:RekaChain/WebAdmin/login.dart';
import 'package:RekaChain/WebAdmin/notification.dart';
import 'package:RekaChain/WebAdmin/profile.dart';
import 'package:RekaChain/WebAdmin/reportsttpp.dart';
import 'package:RekaChain/WebAdmin/tambahproject.dart';
import 'package:RekaChain/WebAdmin/tambahstaff.dart';
import 'package:RekaChain/WebAdmin/viewperencanaan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Perencanaan extends StatefulWidget {
  final DataModel data;
  final String nip;
  const Perencanaan({super.key, required this.data, required this.nip});

  @override
  State<Perencanaan> createState() => _PerencanaanState();
}

class _PerencanaanState extends State<Perencanaan> {
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;
  bool isViewVisible = false;

  int _selectedIndex = 0;
  late List<String> dropdownItemsnamaProject = [];
  String? selectedValuenamaProject;

  List<String> dropdownItemsAlurProses1 = [
    'PPC',
    'Produksi',
    'Mekanik',
    'Elektronik'
  ];
  String? selectedValueAlurProses1;

  List<String> dropdownItemsKategori1 = ['Produk', 'Material'];
  String? selectedValueKategori1;

  List<String> dropdownItemsAlurProses2 = [
    'PPC',
    'Produksi',
    'Mekanik',
    'Elektronik'
  ];
  String? selectedValueAlurProses2;

  List<String> dropdownItemsKategori2 = ['Produk', 'Material'];
  String? selectedValueKategori2;

  List<String> dropdownItemsAlurProses3 = [
    'PPC',
    'Produksi',
    'Mekanik',
    'Elektronik'
  ];
  String? selectedValueAlurProses3;

  List<String> dropdownItemsKategori3 = ['Produk', 'Material'];
  String? selectedValueKategori3;

  List<String> dropdownItemsAlurProses4 = [
    'PPC',
    'Produksi',
    'Mekanik',
    'Elektronik'
  ];
  String? selectedValueAlurProses4;

  List<String> dropdownItemsKategori4 = ['Produk', 'Material'];
  String? selectedValueKategori4;

  List<String> dropdownItemsAlurProses5 = [
    'PPC',
    'Produksi',
    'Mekanik',
    'Elektronik'
  ];
  String? selectedValueAlurProses5;

  List<String> dropdownItemsKategori5 = ['Produk', 'Material'];
  String? selectedValueKategori5;

  List<String> dropdownItemsAlurProses6 = [
    'PPC',
    'Produksi',
    'Mekanik',
    'Elektronik'
  ];
  String? selectedValueAlurProses6;

  List<String> dropdownItemsKategori6 = ['Produk', 'Material'];
  String? selectedValueKategori6;

  List<String> dropdownItemsAlurProses7 = [
    'PPC',
    'Produksi',
    'Mekanik',
    'Elektronik'
  ];
  String? selectedValueAlurProses7;

  List<String> dropdownItemsKategori7 = ['Produk', 'Material'];
  String? selectedValueKategori7;

  List<String> dropdownItemsAlurProses8 = [
    'PPC',
    'Produksi',
    'Mekanik',
    'Elektronik'
  ];
  String? selectedValueAlurProses8;

  List<String> dropdownItemsKategori8 = ['Produk', 'Material'];
  String? selectedValueKategori8;

  List<String> dropdownItemsAlurProses9 = [
    'PPC',
    'Produksi',
    'Mekanik',
    'Elektronik'
  ];
  String? selectedValueAlurProses9;

  List<String> dropdownItemsKategori9 = ['Produk', 'Material'];
  String? selectedValueKategori9;

  List<String> dropdownItemsAlurProses10 = [
    'PPC',
    'Produksi',
    'Mekanik',
    'Elektronik'
  ];
  String? selectedValueAlurProses10;

  List<String> dropdownItemsKategori10 = ['Produk', 'Material'];
  String? selectedValueKategori10;

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

  Future<void> _simpan(BuildContext context) async {
    if (selectedValuenamaProject != null && alurProses1controller != null) {
      final response = await http.post(
        Uri.parse(
          "http://192.168.8.207/ProjectWebAdminRekaChain/lib/Project/create_perencanaan.php",
        ),
        body: {
          "nama": selectedValuenamaProject ?? '',
          "noIndukProduk": noProdukcontroller.text,
          "noSeriAwal": noSeriAwalcontroller.text,
          "targetMulai": tglMulaicontroller.text,
          "namaProduk": namaProdukcontroller.text,
          "jumlahLot": jumlahLotcontroller.text,
          "kodeLot": kodeLotcontroller.text,
          "noSeriAkhir": noSeriAkhircontroller.text,
          "targetSelesai": tglSelesaicontroller.text,
          "ap1": selectedValueAlurProses1 ?? '',
          "kategori1": selectedValueKategori1 ?? '',
          "keterangan1": detail1controller.text,
          "ap2": selectedValueAlurProses2 ?? '',
          "kategori2": selectedValueKategori2 ?? '',
          "keterangan2": detail2controller.text,
          "ap3": selectedValueAlurProses3 ?? '',
          "kategori3": selectedValueKategori3 ?? '',
          "keterangan3": detail3controller.text,
          "ap4": selectedValueAlurProses4 ?? '',
          "kategori4": selectedValueKategori4 ?? '',
          "keterangan4": detail4controller.text,
          "ap5": selectedValueAlurProses5 ?? '',
          "kategori5": selectedValueKategori5 ?? '',
          "keterangan5": detail5controller.text,
          "ap6": selectedValueAlurProses6 ?? '',
          "kategori6": selectedValueKategori6 ?? '',
          "keterangan6": detail6controller.text,
          "ap7": selectedValueAlurProses7 ?? '',
          "kategori7": selectedValueKategori7 ?? '',
          "keterangan7": detail7controller.text,
          "ap8": selectedValueAlurProses8 ?? '',
          "kategori8": selectedValueKategori8 ?? '',
          "keterangan8": detail8controller.text,
          "ap9": selectedValueAlurProses9 ?? '',
          "kategori9": selectedValueKategori9 ?? '',
          "keterangan9": detail9controller.text,
          "ap10": selectedValueAlurProses10 ?? '',
          "kategori10": selectedValueKategori10 ?? '',
          "keterangan10": detail10controller.text,
        },
      );

      if (response.statusCode == 200) {
        final newProjectData = {
          "id": response.body,
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
        };

        _showFinishDialog();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Vperencanaan(
                newProject: newProjectData, nip: widget.nip, data: widget.data),
          ),
        );
      } else {
        print('Gagal menyimpan data: ${response.statusCode}');
      }
    } else {
      print('Mohon lengkapi nama project.');
    }
  }

  Future<void> fetchProjectNames() async {
    final response = await http.get(Uri.parse(
        'http://192.168.8.207/ProjectWebAdminRekaChain/lib/Project/readproject.php'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      setState(() {
        dropdownItemsnamaProject = ['--Pilih Nama/Kode Project--'];
        dropdownItemsnamaProject
            .addAll(data.map((e) => e['idProject'].toString()));
      });
    } else {
      print('Failed to load project names: ${response.statusCode}');
    }
  }

  void initState() {
    super.initState();
    fetchProjectNames();

    namaProjectcontroller = TextEditingController();
    noProdukcontroller = TextEditingController();
    noSeriAwalcontroller = TextEditingController();
    namaProdukcontroller = TextEditingController();
    jumlahLotcontroller = TextEditingController();
    kodeLotcontroller = TextEditingController();
    noSeriAkhircontroller = TextEditingController();
    tglMulaicontroller = TextEditingController();
    tglSelesaicontroller = TextEditingController();

    alurProses1controller = TextEditingController();
    kategori1controller = TextEditingController();
    detail1controller = TextEditingController();

    alurProses2controller = TextEditingController();
    kategori2controller = TextEditingController();
    detail2controller = TextEditingController();

    alurProses3controller = TextEditingController();
    kategori3controller = TextEditingController();
    detail3controller = TextEditingController();

    alurProses4controller = TextEditingController();
    kategori4controller = TextEditingController();
    detail4controller = TextEditingController();

    alurProses5controller = TextEditingController();
    kategori5controller = TextEditingController();
    detail5controller = TextEditingController();

    alurProses6controller = TextEditingController();
    kategori6controller = TextEditingController();
    detail6controller = TextEditingController();

    alurProses7controller = TextEditingController();
    kategori7controller = TextEditingController();
    detail7controller = TextEditingController();

    alurProses8controller = TextEditingController();
    kategori8controller = TextEditingController();
    detail8controller = TextEditingController();

    alurProses9controller = TextEditingController();
    kategori9controller = TextEditingController();
    detail9controller = TextEditingController();

    alurProses10controller = TextEditingController();
    kategori10controller = TextEditingController();
    detail10controller = TextEditingController();

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
          '${noProdukcontroller.text}-${noSeriAwalcontroller.text}-${noSeriAkhircontroller.text}/$tahun';
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
                  builder: (context) =>
                      Perencanaan(data: widget.data, nip: widget.nip),
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
                                    IconButton(
                                      icon: Icon(
                                        Icons.list,
                                        size: 38,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Vperencanaan(
                                                      data: widget.data,
                                                      nip: widget.nip)),
                                        );
                                      },
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
                                            builder: (context) => Notifikasi(
                                                data: widget.data,
                                                nip: widget.nip),
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
                                            builder: (context) => Profile(
                                                data: widget.data,
                                                nip: widget.nip),
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
                                                          fontSize: 15),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: DropdownButton<
                                                          String>(
                                                        value:
                                                            selectedValuenamaProject,
                                                        hint: Text(
                                                            '--Pilih Nama Project--'),
                                                        onChanged: (newValue) {
                                                          setState(() {
                                                            selectedValuenamaProject =
                                                                newValue;
                                                          });
                                                        },
                                                        items:
                                                            dropdownItemsnamaProject
                                                                .map((String
                                                                    value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
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
                                                SizedBox(height: 30),
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
                                              DataCell(DropdownButton<String>(
                                                value: selectedValueAlurProses1,
                                                hint: Text(
                                                    '--Pilih Alur Proses--'),
                                                items: dropdownItemsAlurProses1
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedValueAlurProses1 =
                                                        newValue;
                                                  });
                                                },
                                                focusColor: Colors.white,
                                              )),
                                              DataCell(DropdownButton<String>(
                                                value: selectedValueKategori1,
                                                hint:
                                                    Text('--Pilih Kategori--'),
                                                items: dropdownItemsKategori1
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedValueKategori1 =
                                                        newValue;
                                                  });
                                                },
                                                focusColor: Colors.white,
                                              )),
                                              DataCell(Container(
                                                height: 100,
                                                width: 300,
                                                child: TextFormField(
                                                  controller: detail1controller,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.all(8),
                                                  ),
                                                  onChanged: (newValue) {
                                                    if (newValue.isNotEmpty) {
                                                      setState(() {
                                                        detail1controller.text =
                                                            newValue.substring(
                                                                0, 100000);
                                                      });
                                                    }
                                                  },
                                                ),
                                              )),
                                            ]),
                                            DataRow(cells: [
                                              DataCell(DropdownButton<String>(
                                                value: selectedValueAlurProses2,
                                                hint: Text(
                                                    '--Pilih Alur Proses--'),
                                                items: dropdownItemsAlurProses2
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedValueAlurProses2 =
                                                        newValue;
                                                  });
                                                },
                                                focusColor: Colors.white,
                                              )),
                                              DataCell(DropdownButton<String>(
                                                value: selectedValueKategori2,
                                                hint:
                                                    Text('--Pilih Kategori--'),
                                                items: dropdownItemsKategori2
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedValueKategori2 =
                                                        newValue;
                                                  });
                                                },
                                                focusColor: Colors.white,
                                              )),
                                              DataCell(Container(
                                                height: 100,
                                                width: 300,
                                                child: TextFormField(
                                                  controller: detail2controller,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.all(8),
                                                  ),
                                                  onChanged: (newValue) {
                                                    if (newValue.isNotEmpty) {
                                                      setState(() {
                                                        detail2controller.text =
                                                            newValue.substring(
                                                                0, 100000);
                                                      });
                                                    }
                                                  },
                                                ),
                                              )),
                                            ]),
                                            DataRow(cells: [
                                              DataCell(DropdownButton<String>(
                                                value: selectedValueAlurProses3,
                                                hint: Text(
                                                    '--Pilih Alur Proses--'),
                                                items: dropdownItemsAlurProses3
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedValueAlurProses3 =
                                                        newValue;
                                                  });
                                                },
                                                focusColor: Colors.white,
                                              )),
                                              DataCell(DropdownButton<String>(
                                                value: selectedValueKategori3,
                                                hint:
                                                    Text('--Pilih Kategori--'),
                                                items: dropdownItemsKategori3
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedValueKategori3 =
                                                        newValue;
                                                  });
                                                },
                                                focusColor: Colors.white,
                                              )),
                                              DataCell(Container(
                                                height: 100,
                                                width: 300,
                                                child: TextFormField(
                                                  controller: detail3controller,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.all(8),
                                                  ),
                                                  onChanged: (newValue) {
                                                    if (newValue.isNotEmpty) {
                                                      setState(() {
                                                        detail3controller.text =
                                                            newValue.substring(
                                                                0, 100000);
                                                      });
                                                    }
                                                  },
                                                ),
                                              )),
                                            ]),
                                            DataRow(cells: [
                                              DataCell(DropdownButton<String>(
                                                value: selectedValueAlurProses4,
                                                hint: Text(
                                                    '--Pilih Alur Proses--'),
                                                items: dropdownItemsAlurProses4
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedValueAlurProses4 =
                                                        newValue;
                                                  });
                                                },
                                                focusColor: Colors.white,
                                              )),
                                              DataCell(DropdownButton<String>(
                                                value: selectedValueKategori4,
                                                hint:
                                                    Text('--Pilih Kategori--'),
                                                items: dropdownItemsKategori4
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedValueKategori4 =
                                                        newValue;
                                                  });
                                                },
                                                focusColor: Colors.white,
                                              )),
                                              DataCell(Container(
                                                height: 100,
                                                width: 300,
                                                child: TextFormField(
                                                  controller: detail4controller,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.all(8),
                                                  ),
                                                  onChanged: (newValue) {
                                                    if (newValue.isNotEmpty) {
                                                      setState(() {
                                                        detail4controller.text =
                                                            newValue.substring(
                                                                0, 100000);
                                                      });
                                                    }
                                                  },
                                                ),
                                              )),
                                            ]),
                                            DataRow(cells: [
                                              DataCell(DropdownButton<String>(
                                                value: selectedValueAlurProses5,
                                                hint: Text(
                                                    '--Pilih Alur Proses--'),
                                                items: dropdownItemsAlurProses5
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedValueAlurProses5 =
                                                        newValue;
                                                  });
                                                },
                                                focusColor: Colors.white,
                                              )),
                                              DataCell(DropdownButton<String>(
                                                value: selectedValueKategori5,
                                                hint:
                                                    Text('--Pilih Kategori--'),
                                                items: dropdownItemsKategori5
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedValueKategori5 =
                                                        newValue;
                                                  });
                                                },
                                                focusColor: Colors.white,
                                              )),
                                              DataCell(Container(
                                                height: 100,
                                                width: 300,
                                                child: TextFormField(
                                                  controller: detail5controller,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.all(8),
                                                  ),
                                                  onChanged: (newValue) {
                                                    if (newValue.isNotEmpty) {
                                                      setState(() {
                                                        detail5controller.text =
                                                            newValue.substring(
                                                                0, 100000);
                                                      });
                                                    }
                                                  },
                                                ),
                                              )),
                                            ]),
                                            DataRow(cells: [
                                              DataCell(DropdownButton<String>(
                                                value: selectedValueAlurProses6,
                                                hint: Text(
                                                    '--Pilih Alur Proses--'),
                                                items: dropdownItemsAlurProses6
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedValueAlurProses6 =
                                                        newValue;
                                                  });
                                                },
                                                focusColor: Colors.white,
                                              )),
                                              DataCell(DropdownButton<String>(
                                                value: selectedValueKategori6,
                                                hint:
                                                    Text('--Pilih Kategori--'),
                                                items: dropdownItemsKategori6
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedValueKategori6 =
                                                        newValue;
                                                  });
                                                },
                                                focusColor: Colors.white,
                                              )),
                                              DataCell(Container(
                                                height: 100,
                                                width: 300,
                                                child: TextFormField(
                                                  controller: detail6controller,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.all(8),
                                                  ),
                                                  onChanged: (newValue) {
                                                    if (newValue.isNotEmpty) {
                                                      setState(() {
                                                        detail6controller.text =
                                                            newValue.substring(
                                                                0, 100000);
                                                      });
                                                    }
                                                  },
                                                ),
                                              )),
                                            ]),
                                            DataRow(cells: [
                                              DataCell(DropdownButton<String>(
                                                value: selectedValueAlurProses7,
                                                hint: Text(
                                                    '--Pilih Alur Proses--'),
                                                items: dropdownItemsAlurProses7
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedValueAlurProses7 =
                                                        newValue;
                                                  });
                                                },
                                                focusColor: Colors.white,
                                              )),
                                              DataCell(DropdownButton<String>(
                                                value: selectedValueKategori7,
                                                hint:
                                                    Text('--Pilih Kategori--'),
                                                items: dropdownItemsKategori7
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedValueKategori7 =
                                                        newValue;
                                                  });
                                                },
                                                focusColor: Colors.white,
                                              )),
                                              DataCell(Container(
                                                height: 100,
                                                width: 300,
                                                child: TextFormField(
                                                  controller: detail7controller,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.all(8),
                                                  ),
                                                  onChanged: (newValue) {
                                                    if (newValue.isNotEmpty) {
                                                      setState(() {
                                                        detail7controller.text =
                                                            newValue.substring(
                                                                0, 100000);
                                                      });
                                                    }
                                                  },
                                                ),
                                              )),
                                            ]),
                                            DataRow(cells: [
                                              DataCell(DropdownButton<String>(
                                                value: selectedValueAlurProses8,
                                                hint: Text(
                                                    '--Pilih Alur Proses--'),
                                                items: dropdownItemsAlurProses8
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedValueAlurProses8 =
                                                        newValue;
                                                  });
                                                },
                                                focusColor: Colors.white,
                                              )),
                                              DataCell(DropdownButton<String>(
                                                value: selectedValueKategori8,
                                                hint:
                                                    Text('--Pilih Kategori--'),
                                                items: dropdownItemsKategori8
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedValueKategori8 =
                                                        newValue;
                                                  });
                                                },
                                                focusColor: Colors.white,
                                              )),
                                              DataCell(Container(
                                                height: 100,
                                                width: 300,
                                                child: TextFormField(
                                                  controller: detail8controller,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.all(8),
                                                  ),
                                                  onChanged: (newValue) {
                                                    if (newValue.isNotEmpty) {
                                                      setState(() {
                                                        detail8controller.text =
                                                            newValue.substring(
                                                                0, 100000);
                                                      });
                                                    }
                                                  },
                                                ),
                                              )),
                                            ]),
                                            DataRow(cells: [
                                              DataCell(DropdownButton<String>(
                                                value: selectedValueAlurProses9,
                                                hint: Text(
                                                    '--Pilih Alur Proses--'),
                                                items: dropdownItemsAlurProses9
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedValueAlurProses9 =
                                                        newValue;
                                                  });
                                                },
                                                focusColor: Colors.white,
                                              )),
                                              DataCell(DropdownButton<String>(
                                                value: selectedValueKategori9,
                                                hint:
                                                    Text('--Pilih Kategori--'),
                                                items: dropdownItemsKategori9
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedValueKategori9 =
                                                        newValue;
                                                  });
                                                },
                                                focusColor: Colors.white,
                                              )),
                                              DataCell(Container(
                                                height: 100,
                                                width: 300,
                                                child: TextFormField(
                                                  controller: detail9controller,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.all(8),
                                                  ),
                                                  onChanged: (newValue) {
                                                    if (newValue.isNotEmpty) {
                                                      setState(() {
                                                        detail9controller.text =
                                                            newValue.substring(
                                                                0, 100000);
                                                      });
                                                    }
                                                  },
                                                ),
                                              )),
                                            ]),
                                            DataRow(cells: [
                                              DataCell(DropdownButton<String>(
                                                value:
                                                    selectedValueAlurProses10,
                                                hint: Text(
                                                    '--Pilih Alur Proses--'),
                                                items: dropdownItemsAlurProses10
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedValueAlurProses10 =
                                                        newValue;
                                                  });
                                                },
                                                focusColor: Colors.white,
                                              )),
                                              DataCell(DropdownButton<String>(
                                                value: selectedValueKategori10,
                                                hint:
                                                    Text('--Pilih Kategori--'),
                                                items: dropdownItemsKategori10
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedValueKategori10 =
                                                        newValue;
                                                  });
                                                },
                                                focusColor: Colors.white,
                                              )),
                                              DataCell(Container(
                                                height: 100,
                                                width: 300,
                                                child: TextFormField(
                                                  controller:
                                                      detail10controller,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.all(8),
                                                  ),
                                                  onChanged: (newValue) {
                                                    if (newValue.isNotEmpty) {
                                                      setState(() {
                                                        detail10controller
                                                                .text =
                                                            newValue.substring(
                                                                0, 100000);
                                                      });
                                                    }
                                                  },
                                                ),
                                              )),
                                            ]),
                                          ]),
                                    ),
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            _simpan(context);
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
                  MaterialPageRoute(
                      builder: (context) =>
                          Vperencanaan(data: widget.data, nip: widget.nip)),
                );
              },
              child: Text("Ya", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
