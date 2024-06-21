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

class Subnotifikasi extends StatefulWidget {
  final Map<String, dynamic> selectedProject;
  final DataModel data;
  final String nip;
  const Subnotifikasi(
      {Key? key,
      this.selectedProject = const {},
      required this.nip,
      required this.data})
      : super(key: key);

  @override
  State<Subnotifikasi> createState() => _SubnotifikasiState();
}

class _SubnotifikasiState extends State<Subnotifikasi> {
  int _selectedIndex = 0;

  late double screenWidth;
  late double screenHeight;

  List _listdataProduk = [];
  List _listdataMaterial = [];
  bool _isloading = true;

  TextEditingController namaProjectcontroller = TextEditingController();
  TextEditingController kodeLotcontroller = TextEditingController();
  TextEditingController noProdukcontroller = TextEditingController();
  TextEditingController namaProdukcontroller = TextEditingController();
  TextEditingController kodeMaterialcontroller = TextEditingController();
  TextEditingController deskripsicontroller = TextEditingController();
  TextEditingController specTechcontroller = TextEditingController();
  TextEditingController qtycontroller = TextEditingController();
  TextEditingController unitcontroller = TextEditingController();
  TextEditingController nipcontroller = TextEditingController();

  TextEditingController alurProses1controller = TextEditingController();
  TextEditingController kategori1controller = TextEditingController();
  TextEditingController detail1controller = TextEditingController();
  TextEditingController nip1controller = TextEditingController();
  TextEditingController tanggalMulai1controller = TextEditingController();
  TextEditingController tanggalSelesai1controller = TextEditingController();
  TextEditingController keteranganProduk1controller = TextEditingController();

  TextEditingController alurProses2controller = TextEditingController();
  TextEditingController kategori2controller = TextEditingController();
  TextEditingController detail2controller = TextEditingController();
  TextEditingController nip2controller = TextEditingController();
  TextEditingController tanggalMulai2controller = TextEditingController();
  TextEditingController tanggalSelesai2controller = TextEditingController();
  TextEditingController keteranganProduk2controller = TextEditingController();

  TextEditingController alurProses3controller = TextEditingController();
  TextEditingController kategori3controller = TextEditingController();
  TextEditingController detail3controller = TextEditingController();
  TextEditingController nip3controller = TextEditingController();
  TextEditingController tanggalMulai3controller = TextEditingController();
  TextEditingController tanggalSelesai3controller = TextEditingController();
  TextEditingController keteranganProduk3controller = TextEditingController();

  TextEditingController alurProses4controller = TextEditingController();
  TextEditingController kategori4controller = TextEditingController();
  TextEditingController detail4controller = TextEditingController();
  TextEditingController nip4controller = TextEditingController();
  TextEditingController tanggalMulai4controller = TextEditingController();
  TextEditingController tanggalSelesai4controller = TextEditingController();
  TextEditingController keteranganProduk4controller = TextEditingController();

  TextEditingController alurProses5controller = TextEditingController();
  TextEditingController kategori5controller = TextEditingController();
  TextEditingController detail5controller = TextEditingController();
  TextEditingController nip5controller = TextEditingController();
  TextEditingController tanggalMulai5controller = TextEditingController();
  TextEditingController tanggalSelesai5controller = TextEditingController();
  TextEditingController keteranganProduk5controller = TextEditingController();

  TextEditingController alurProses6controller = TextEditingController();
  TextEditingController kategori6controller = TextEditingController();
  TextEditingController detail6controller = TextEditingController();
  TextEditingController nip6controller = TextEditingController();
  TextEditingController tanggalMulai6controller = TextEditingController();
  TextEditingController tanggalSelesai6controller = TextEditingController();
  TextEditingController keteranganProduk6controller = TextEditingController();

  TextEditingController alurProses7controller = TextEditingController();
  TextEditingController kategori7controller = TextEditingController();
  TextEditingController detail7controller = TextEditingController();
  TextEditingController nip7controller = TextEditingController();
  TextEditingController tanggalMulai7controller = TextEditingController();
  TextEditingController tanggalSelesai7controller = TextEditingController();
  TextEditingController keteranganProduk7controller = TextEditingController();

  TextEditingController alurProses8controller = TextEditingController();
  TextEditingController kategori8controller = TextEditingController();
  TextEditingController detail8controller = TextEditingController();
  TextEditingController nip8controller = TextEditingController();
  TextEditingController tanggalMulai8controller = TextEditingController();
  TextEditingController tanggalSelesai8controller = TextEditingController();
  TextEditingController keteranganProduk8controller = TextEditingController();

  TextEditingController alurProses9controller = TextEditingController();
  TextEditingController kategori9controller = TextEditingController();
  TextEditingController detail9controller = TextEditingController();
  TextEditingController nip9controller = TextEditingController();
  TextEditingController tanggalMulai9controller = TextEditingController();
  TextEditingController tanggalSelesai9controller = TextEditingController();
  TextEditingController keteranganProduk9controller = TextEditingController();

  TextEditingController alurProses10controller = TextEditingController();
  TextEditingController kategori10controller = TextEditingController();
  TextEditingController detail10controller = TextEditingController();
  TextEditingController nip10controller = TextEditingController();
  TextEditingController tanggalMulai10controller = TextEditingController();
  TextEditingController tanggalSelesai10controller = TextEditingController();
  TextEditingController keteranganProduk10controller = TextEditingController();

  void fetchDataProduk() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.10.102/ProjectWebAdminRekaChain/lib/Project/read_notifproduk.php?kodeLot=${widget.selectedProject['kodeLot']}'),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          _listdataProduk = responseData;
        });
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void fetchDataMaterial() async {
    try {
      final kodeLot = widget.selectedProject['kodeLot'];
      print('kodeLot: $kodeLot');

      final response = await http.get(
        Uri.parse(
          'http://192.168.10.102/ProjectWebAdminRekaChain/lib/Project/read_notifmaterial.php?kodeLot=$kodeLot',
        ),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData.isNotEmpty) {
          final firstItem = responseData[0];

          setState(() {
            kodeMaterialcontroller.text = firstItem['kodeMaterial'] ?? '';
            deskripsicontroller.text = firstItem['deskripsi'] ?? '';
            specTechcontroller.text = firstItem['specTech'] ?? '';
            qtycontroller.text = firstItem['qty'] ?? '';
            unitcontroller.text = firstItem['unit'] ?? '';
            nipcontroller.text = firstItem['nama'] ?? '';
            _listdataMaterial = responseData;
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

  @override
  void initState() {
    super.initState();
    fetchDataProduk();
    fetchDataMaterial();

    namaProjectcontroller =
        TextEditingController(text: widget.selectedProject['nama'] ?? '');
    kodeLotcontroller =
        TextEditingController(text: widget.selectedProject['kodeLot'] ?? '');
    namaProdukcontroller =
        TextEditingController(text: widget.selectedProject['namaProduk'] ?? '');

    noProdukcontroller =
        TextEditingController(text: widget.selectedProject['noProduk'] ?? '');

    alurProses1controller =
        TextEditingController(text: widget.selectedProject['ap1'] ?? '');
    kategori1controller =
        TextEditingController(text: widget.selectedProject['kategori1'] ?? '');
    detail1controller = TextEditingController(
        text: widget.selectedProject['keterangan1'] ?? '');
    nip1controller =
        TextEditingController(text: widget.selectedProject['nip1'] ?? '');
    tanggalMulai1controller = TextEditingController(
        text: widget.selectedProject['tanggal_mulai1'] ?? '');
    tanggalSelesai1controller = TextEditingController(
        text: widget.selectedProject['tanggal_selesai1'] ?? '');
    keteranganProduk1controller = TextEditingController(
        text: widget.selectedProject['keterangan_produk1'] ?? '');

    alurProses2controller =
        TextEditingController(text: widget.selectedProject['ap2'] ?? '');
    kategori2controller =
        TextEditingController(text: widget.selectedProject['kategori2'] ?? '');
    detail2controller = TextEditingController(
        text: widget.selectedProject['keterangan2'] ?? '');
    nip2controller =
        TextEditingController(text: widget.selectedProject['nip2'] ?? '');
    tanggalMulai2controller = TextEditingController(
        text: widget.selectedProject['tanggal_mulai2'] ?? '');
    tanggalSelesai2controller = TextEditingController(
        text: widget.selectedProject['tanggal_selesai2'] ?? '');
    keteranganProduk1controller = TextEditingController(
        text: widget.selectedProject['keterangan_produk2'] ?? '');

    alurProses3controller =
        TextEditingController(text: widget.selectedProject['ap3'] ?? '');
    kategori3controller =
        TextEditingController(text: widget.selectedProject['kategori3'] ?? '');
    detail3controller = TextEditingController(
        text: widget.selectedProject['keterangan3'] ?? '');
    nip3controller =
        TextEditingController(text: widget.selectedProject['nip3'] ?? '');
    tanggalMulai3controller = TextEditingController(
        text: widget.selectedProject['tanggal_mulai3'] ?? '');
    tanggalSelesai3controller = TextEditingController(
        text: widget.selectedProject['tanggal_selesai3'] ?? '');
    keteranganProduk3controller = TextEditingController(
        text: widget.selectedProject['keterangan_produk3'] ?? '');

    alurProses4controller =
        TextEditingController(text: widget.selectedProject['ap4'] ?? '');
    kategori4controller =
        TextEditingController(text: widget.selectedProject['kategori4'] ?? '');
    detail4controller = TextEditingController(
        text: widget.selectedProject['keterangan4'] ?? '');
    nip4controller =
        TextEditingController(text: widget.selectedProject['nip4'] ?? '');
    tanggalMulai4controller = TextEditingController(
        text: widget.selectedProject['tanggal_mulai4'] ?? '');
    tanggalSelesai4controller = TextEditingController(
        text: widget.selectedProject['tanggal_selesai4'] ?? '');
    keteranganProduk4controller = TextEditingController(
        text: widget.selectedProject['keterangan_produk4'] ?? '');

    alurProses5controller =
        TextEditingController(text: widget.selectedProject['ap5'] ?? '');
    kategori5controller =
        TextEditingController(text: widget.selectedProject['kategori5'] ?? '');
    detail5controller = TextEditingController(
        text: widget.selectedProject['keterangan5'] ?? '');
    nip5controller =
        TextEditingController(text: widget.selectedProject['nip5'] ?? '');
    tanggalMulai5controller = TextEditingController(
        text: widget.selectedProject['tanggal_mulai5'] ?? '');
    tanggalSelesai5controller = TextEditingController(
        text: widget.selectedProject['tanggal_selesai5'] ?? '');
    keteranganProduk5controller = TextEditingController(
        text: widget.selectedProject['keterangan_produk5'] ?? '');

    alurProses6controller =
        TextEditingController(text: widget.selectedProject['ap6'] ?? '');
    kategori6controller =
        TextEditingController(text: widget.selectedProject['kategori6'] ?? '');
    detail6controller = TextEditingController(
        text: widget.selectedProject['keterangan6'] ?? '');
    nip6controller =
        TextEditingController(text: widget.selectedProject['nip6'] ?? '');
    tanggalMulai6controller = TextEditingController(
        text: widget.selectedProject['tanggal_mulai6'] ?? '');
    tanggalSelesai6controller = TextEditingController(
        text: widget.selectedProject['tanggal_selesai6'] ?? '');
    keteranganProduk6controller = TextEditingController(
        text: widget.selectedProject['keterangan_produk6'] ?? '');

    alurProses7controller =
        TextEditingController(text: widget.selectedProject['ap7'] ?? '');
    kategori7controller =
        TextEditingController(text: widget.selectedProject['kategori7'] ?? '');
    detail7controller = TextEditingController(
        text: widget.selectedProject['keterangan7'] ?? '');
    nip7controller =
        TextEditingController(text: widget.selectedProject['nip7'] ?? '');
    tanggalMulai7controller = TextEditingController(
        text: widget.selectedProject['tanggal_mulai7'] ?? '');
    tanggalSelesai7controller = TextEditingController(
        text: widget.selectedProject['tanggal_selesai7'] ?? '');
    keteranganProduk7controller = TextEditingController(
        text: widget.selectedProject['keterangan_produk7'] ?? '');

    alurProses8controller =
        TextEditingController(text: widget.selectedProject['ap8'] ?? '');
    kategori8controller =
        TextEditingController(text: widget.selectedProject['kategori8'] ?? '');
    detail8controller = TextEditingController(
        text: widget.selectedProject['keterangan8'] ?? '');
    nip8controller =
        TextEditingController(text: widget.selectedProject['nip8'] ?? '');
    tanggalMulai8controller = TextEditingController(
        text: widget.selectedProject['tanggal_mulai8'] ?? '');
    tanggalSelesai8controller = TextEditingController(
        text: widget.selectedProject['tanggal_selesai8'] ?? '');
    keteranganProduk8controller = TextEditingController(
        text: widget.selectedProject['keterangan_produk8'] ?? '');

    alurProses9controller =
        TextEditingController(text: widget.selectedProject['ap9'] ?? '');
    kategori9controller =
        TextEditingController(text: widget.selectedProject['kategori9'] ?? '');
    detail9controller = TextEditingController(
        text: widget.selectedProject['keterangan9'] ?? '');
    nip9controller =
        TextEditingController(text: widget.selectedProject['nip9'] ?? '');
    tanggalMulai9controller = TextEditingController(
        text: widget.selectedProject['tanggal_mulai9'] ?? '');
    tanggalSelesai9controller = TextEditingController(
        text: widget.selectedProject['tanggal_selesai9'] ?? '');
    keteranganProduk9controller = TextEditingController(
        text: widget.selectedProject['keterangan_produk9'] ?? '');

    alurProses10controller =
        TextEditingController(text: widget.selectedProject['ap10'] ?? '');
    kategori10controller =
        TextEditingController(text: widget.selectedProject['kategori10'] ?? '');
    detail10controller = TextEditingController(
        text: widget.selectedProject['keterangan10'] ?? '');
    nip10controller =
        TextEditingController(text: widget.selectedProject['nip10'] ?? '');
    tanggalMulai10controller = TextEditingController(
        text: widget.selectedProject['tanggal_mulai10'] ?? '');
    tanggalSelesai10controller = TextEditingController(
        text: widget.selectedProject['tanggal_selesai10'] ?? '');
    keteranganProduk10controller = TextEditingController(
        text: widget.selectedProject['keterangan_produk10'] ?? '');
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
                  Subnotifikasi(data: widget.data, nip: widget.nip),
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
                      'Detail Notifikasi',
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.001,
                        horizontal: screenWidth * 0.001),
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            margin: EdgeInsets.all(50.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  columnSpacing: 150.0,
                                  horizontalMargin: 70.0,
                                  columns: [
                                    DataColumn(
                                      label: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Nama Project',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Kode Lot',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Nama Produk',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: _listdataProduk.length > 0
                                      ? [
                                          DataRow(
                                            cells: [
                                              DataCell(Text(_listdataProduk[0]
                                                      ['nama'] ??
                                                  '')),
                                              DataCell(Text(_listdataProduk[0]
                                                      ['kodeLot'] ??
                                                  '')),
                                              DataCell(Text(_listdataProduk[0]
                                                      ['namaProduk'] ??
                                                  '')),
                                            ],
                                          ),
                                        ]
                                      : [],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 40),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            margin: EdgeInsets.all(50.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Container(child: _buildMainTable()),
                              ],
                            ),
                          ),
                          SizedBox(width: 40),
                          Container(
                            alignment: Alignment.center,
                            width: screenWidth * 0.9,
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.001,
                                horizontal: screenWidth * 0.001),
                            margin: EdgeInsets.all(50.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                columnSpacing: 95.0,
                                horizontalMargin: 70.0,
                                columns: [
                                  DataColumn(
                                    label: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Kode Material',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Deskripsi',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'SpecTech',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'QTY',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Unit',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Penerima',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                                rows: _listdataMaterial
                                    .map(
                                      (item) => DataRow(
                                        cells: [
                                          DataCell(Text(item['kodeMaterial'])),
                                          DataCell(Text(item['deskripsi'])),
                                          DataCell(Text(item['specTech'])),
                                          DataCell(Text(item['qty'])),
                                          DataCell(Text(item['unit'])),
                                          DataCell(Text(item['nama'])),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
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
    );
  }

  Widget _buildMainTable() {
    List<DataRow> generateRows() {
      List<DataRow> rows = [];
      int rowIndex = 1;

      List<Map<String, TextEditingController>> data = [
        {
          'alurProses': alurProses1controller,
          'keterangan_produk': keteranganProduk1controller,
          'nama': nip1controller,
          'tanggal_mulai': tanggalMulai1controller,
          'tanggal_selesai': tanggalSelesai1controller,
          'noProduk': noProdukcontroller,
        },
        {
          'alurProses': alurProses2controller,
          'keterangan_produk': keteranganProduk2controller,
          'nama': nip2controller,
          'tanggal_mulai': tanggalMulai2controller,
          'tanggal_selesai': tanggalSelesai2controller,
          'noProduk': noProdukcontroller,
        },
        {
          'alurProses': alurProses3controller,
          'keterangan_produk': keteranganProduk3controller,
          'nama': nip3controller,
          'tanggal_mulai': tanggalMulai3controller,
          'tanggal_selesai': tanggalSelesai3controller,
          'noProduk': noProdukcontroller,
        },
        {
          'alurProses': alurProses4controller,
          'keterangan_produk': keteranganProduk4controller,
          'nama': nip4controller,
          'tanggal_mulai': tanggalMulai4controller,
          'tanggal_selesai': tanggalSelesai4controller,
          'noProduk': noProdukcontroller,
        },
        {
          'alurProses': alurProses5controller,
          'keterangan_produk': keteranganProduk5controller,
          'nama': nip5controller,
          'tanggal_mulai': tanggalMulai5controller,
          'tanggal_selesai': tanggalSelesai5controller,
          'noProduk': noProdukcontroller,
        },
        {
          'alurProses': alurProses6controller,
          'keterangan_produk': keteranganProduk6controller,
          'nama': nip6controller,
          'tanggal_mulai': tanggalMulai6controller,
          'tanggal_selesai': tanggalSelesai6controller,
          'noProduk': noProdukcontroller,
        },
        {
          'alurProses': alurProses7controller,
          'keterangan_produk': keteranganProduk7controller,
          'nama': nip7controller,
          'tanggal_mulai': tanggalMulai7controller,
          'tanggal_selesai': tanggalSelesai7controller,
          'noProduk': noProdukcontroller,
        },
        {
          'alurProses': alurProses8controller,
          'keterangan_produk': keteranganProduk8controller,
          'nama': nip8controller,
          'tanggal_mulai': tanggalMulai8controller,
          'tanggal_selesai': tanggalSelesai8controller,
          'noProduk': noProdukcontroller,
        },
        {
          'alurProses': alurProses9controller,
          'keterangan_produk': keteranganProduk9controller,
          'nama': nip9controller,
          'tanggal_mulai': tanggalMulai9controller,
          'tanggal_selesai': tanggalSelesai9controller,
          'noProduk': noProdukcontroller,
        },
        {
          'alurProses': alurProses10controller,
          'keterangan_produk': keteranganProduk10controller,
          'nama': nip10controller,
          'tanggal_mulai': tanggalMulai10controller,
          'tanggal_selesai': tanggalSelesai10controller,
          'noProduk': noProdukcontroller,
        },
      ];
      for (var data in _listdataProduk) {
        final namaProduk = data['namaProduk'];

        for (var i = 1; i <= 10; i++) {
          final alurProsesKey = 'ap$i';
          final namaKey = 'nama$i';
          final tanggalMulaiKey = 'tanggal_mulai$i';
          final tanggalSelesaiKey = 'tanggal_selesai$i';
          final keteranganProdukKey = 'keterangan_produk$i';

          final alurProses = data[alurProsesKey];
          final nama = data[namaKey];
          final tanggalMulai = data[tanggalMulaiKey];
          final tanggalSelesai = data[tanggalSelesaiKey];
          final keteranganProduk = data[keteranganProdukKey];

          if (alurProses != null && alurProses.isNotEmpty) {
            rows.add(
              DataRow(cells: [
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
                      child: Text(alurProses ?? ''),
                    ),
                  ),
                ),
                DataCell(
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(tanggalMulai ?? ''),
                    ),
                  ),
                ),
                DataCell(
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(tanggalSelesai ?? ''),
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
                      child: Text(keteranganProduk ?? ''),
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

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - 50,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 95.0,
            horizontalMargin: 70.0,
            columns: [
              DataColumn(
                label: Center(
                  child: Text(
                    'No Produk',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              DataColumn(
                label: Center(
                  child: Text(
                    'Proses',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              DataColumn(
                label: Center(
                  child: Text(
                    'Tgl Mulai',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              DataColumn(
                label: Center(
                  child: Text(
                    'Tgl Selesai',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              DataColumn(
                label: Center(
                  child: Text(
                    'Personil',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              DataColumn(
                label: Center(
                  child: Text(
                    'Keterangan Produk',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
            rows: generateRows(),
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
