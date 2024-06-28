import 'dart:html';
import 'dart:io';
import 'dart:typed_data';
import 'package:RekaChain/WebAdmin/profile.dart';
import 'package:RekaChain/WebAdmin/provider/user_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:RekaChain/WebAdmin/data_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:uuid/uuid.dart';
import 'package:mime/mime.dart';

class EditProfile extends StatefulWidget {
  final String nip;
  final String savedPassword;
  final DataModel data;
  const EditProfile(
      {Key? key,
      required this.nip,
      required this.data,
      required this.savedPassword})
      : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late double screenWidth;
  late double screenHeight;
  late TextEditingController kodeStaffController =
      TextEditingController(text: widget.data.kode_staff);
  late TextEditingController namaController =
      TextEditingController(text: widget.data.nama);
  late TextEditingController jabatanController =
      TextEditingController(text: widget.data.jabatan);
  late TextEditingController unitKerjaController =
      TextEditingController(text: widget.data.unit_kerja);
  late TextEditingController departemenController =
      TextEditingController(text: widget.data.departemen);
  late TextEditingController divisiController =
      TextEditingController(text: widget.data.divisi);
  late TextEditingController emailController =
      TextEditingController(text: widget.data.email);
  late TextEditingController noTelpController =
      TextEditingController(text: widget.data.noTelp);
  late TextEditingController nipController =
      TextEditingController(text: widget.data.nip);
  late TextEditingController statusController =
      TextEditingController(text: widget.data.status);
  late TextEditingController passwordController =
      TextEditingController(text: widget.savedPassword);
  late TextEditingController konfirmasiPasswordController =
      TextEditingController(text: widget.savedPassword);
  late TextEditingController profileController =
      TextEditingController(text: widget.data.profile);

  late Uint8List _selectedImage = Uint8List(0);
  late String _originalFileName = '';

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
    _getdata();
    fetchData();
  }

  Future<void> _pickImage() async {
    FileUploadInputElement uploadInput = FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files!.isNotEmpty) {
        final reader = FileReader();
        reader.readAsArrayBuffer(files[0]);
        reader.onLoadEnd.listen((e) async {
          setState(() {
            _selectedImage = reader.result as Uint8List;
            _originalFileName = files[0].name; // Save the original file name
          });
          await _saveProfileImage(_selectedImage);
        });
      }
    });
  }

  Future<void> _loadProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? base64Image = prefs.getString('profile');
    if (base64Image != null) {
      setState(() {
        _selectedImage = base64Decode(base64Image);
      });
    }
  }

  Future<void> _saveProfileImage(Uint8List image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String base64Image = base64Encode(image);
    await prefs.setString('profile', base64Image);

    final formData = FormData.fromMap({
      'profile': MultipartFile.fromBytes(
        image,
        filename: _originalFileName, // Provide a filename
        contentType: MediaType('image', 'jpeg'),
      ),
    });

    final response = await Dio().post(
      'http://192.168.8.26/ProjectWebAdminRekaChain/lib/Project/edit_profile.php',
      data: formData,
      options: Options(
        contentType: 'multipart/form-data',
      ),
    );

    if (response.statusCode == 200) {
      print('Image uploaded successfully');
    } else {
      print('Failed to upload image: ${response.statusCode}');
    }
  }

  Future _getdata() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.8.26/ProjectWebAdminRekaChain/lib/Project/readdataprofile.php'));
      if (response.statusCode == 200) {
        try {
          final data = jsonDecode(response.body);
          setState(() {
            kodeStaffController.text = data['kode_staff'] ?? '';
            namaController.text = data['nama'] ?? '';
            jabatanController.text = data['jabatan'] ?? '';
            unitKerjaController.text = data['unit_kerja'] ?? '';
            departemenController.text = data['departemen'] ?? '';
            divisiController.text = data['divisi'] ?? '';
            noTelpController.text = data['no_telp'] ?? '';
            nipController.text = data['nip'] ?? '';
            passwordController.text =
                context.read<UserProvider>().savedPassword;
            statusController.text = data['status'] ?? '';
            // profileController.text = data['profile'] ?? '';
            _saveProfileImage(data['profile'] ?? '');
          });
        } catch (e) {
          print('Error parsing JSON: $e');
          print('Response body: ${response.body}');
        }
      } else {
        print('Failed to load data: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> _simpan() async {
    final uri = Uri.parse(
        'http://192.168.8.26/ProjectWebAdminRekaChain/lib/Project/edit_profile.php');
    final request = http.MultipartRequest('POST', uri);

    request.fields['nip'] = widget.data.nip;
    request.fields['nama'] = namaController.text;
    request.fields['jabatan'] = jabatanController.text;
    request.fields['unit_kerja'] = unitKerjaController.text;
    request.fields['departemen'] = departemenController.text;
    request.fields['divisi'] = divisiController.text;
    request.fields['email'] = emailController.text; // Tambahkan email
    request.fields['no_telp'] = noTelpController.text;
    request.fields['status'] = statusController.text;
    request.fields['password'] = passwordController.text;
    request.fields['konfirmasi_password'] = konfirmasiPasswordController.text;

    if (_selectedImage.isNotEmpty) {
      request.files.add(http.MultipartFile.fromBytes(
        'profile',
        _selectedImage,
        filename: _originalFileName, // Provide a filename
        contentType: MediaType('image', 'jpeg'),
      ));
    }

    request.fields['kode_staff'] = kodeStaffController.text;
    request.fields['nama'] = namaController.text;
    request.fields['jabatan'] = jabatanController.text;
    request.fields['departemen'] = departemenController.text;
    request.fields['unit_kerja'] = unitKerjaController.text;
    request.fields['divisi'] = divisiController.text;
    request.fields['no_telp'] = noTelpController.text;
    request.fields['status'] = statusController.text;
    request.fields['nip'] = nipController.text;
    request.fields['password'] = passwordController.text;
    request.fields['profile'] = profileController.text;

    var response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      print('Data berhasil diperbarui: $responseBody');
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Profile(data: widget.data, nip: widget.nip)),
      );
    } else {
      print('Gagal memperbarui data: ${response.statusCode}');
      final responseBody = await response.stream.bytesToString();
      print('Response: $responseBody');
    }
  }

  Future<void> fetchData() async {
    String? nip = await getNipFromSharedPreferences();
    if (nip != null) {
      DataModel? data = await getUserDataByNip(nip);
      if (data != null) {
        setState(() {
          namaController.text = data.nama;
          jabatanController.text = data.jabatan;
          unitKerjaController.text = data.unit_kerja;
          departemenController.text = data.departemen;
          divisiController.text = data.divisi;
          noTelpController.text = data.noTelp;
          nipController.text = data.nip.toString();
          passwordController.text = widget.savedPassword;
          statusController.text = data.status;
          profileController.text = data.profile;
        });
      }
    }
  }

  Future<String?> getNipFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('nip');
  }

  Future<DataModel?> getUserDataByNip(String nip) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? dataKaryawanJson = prefs.getString('dataKaryawan');
    if (dataKaryawanJson != null) {
      Map<String, dynamic> userMap = jsonDecode(dataKaryawanJson);
      if (userMap['nip'] == nip) {
        return DataModel.getDataFromJson(userMap);
      }
    }
    return null;
  }

  Future<void> _update() async {
    final response = await http.post(
      Uri.parse(
          'http://192.168.8.26/ProjectWebAdminRekaChain/lib/Project/create_tambahstaff.php'),
      body: {
        "nama": namaController.text,
        "jabatan": jabatanController.text,
        "unit_kerja": unitKerjaController.text,
        "departemen": departemenController.text,
        "divisi": divisiController.text,
        "no_telp": noTelpController.text,
        "nip": nipController.text,
        "password": passwordController.text,
        "status": statusController.text,
        "profile": profileController.text
      },
    );
    if (response.statusCode == 200) {
      print('Data berhasil diperbarui');
    } else {
      print('Gagal memperbarui data: ${response.statusCode}');
    }
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
              builder: (context) => EditProfile(
                  nip: widget.nip,
                  data: widget.data,
                  savedPassword: widget.savedPassword),
            );
          default:
            return null;
        }
      },
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset(
                'assets/images/logoREKA.png',
                width: 250,
                height: 300,
              ),
              const SizedBox(width: 10),
            ],
          ),
          toolbarHeight: 100.0,
        ),
        body: Row(
          children: [
            Container(
              width: 270,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAvatar(),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed:
                            _simpan, // Panggil metode _simpan saat tombol ditekan
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color.fromRGBO(43, 56, 86, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                        ),
                        child: const Text('Simpan'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: _buildRightSection(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRightSection() {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: const Color.fromRGBO(43, 56, 86, 1),
              padding: const EdgeInsets.only(top: 3.5, left: 15.0),
              child: const Text(
                'PROFIL SAYA',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Donegal One',
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 16.0),
            // Letak widget content
            _buildTextView(
                isEnable: true,
                label: ' Nama Lengkap',
                text: '',
                controller: namaController),
            _buildTextView(
                isEnable: true,
                label: ' Jabatan',
                text: '',
                controller: jabatanController),
            _buildTextView(
                isEnable: true,
                label: ' Unit Kerja',
                text: '',
                controller: unitKerjaController),
            _buildTextView(
                isEnable: true,
                label: ' Departemen',
                text: '',
                controller: departemenController),
            _buildTextView(
                isEnable: true,
                label: ' Divisi',
                text: '',
                controller: divisiController),
            _buildTextView(
                isEnable: true,
                label: ' Nomor Telepon',
                text: '',
                controller: noTelpController),
            _buildTextView(
                isEnable: true,
                label: ' NIP',
                text: '',
                controller: nipController),
            _buildTextView(
                isEnable: true,
                label: ' Password',
                text: '',
                controller: passwordController),
            _buildTextView(
                isEnable: true,
                label: ' Status',
                text: '',
                controller: statusController),
            const SizedBox(height: 16.0),
          ],
        ),
      ],
    );
  }

  Widget _buildTextView(
      {required String label,
      required String text,
      required bool isEnable,
      required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          enabled: isEnable,
          controller: controller,
          decoration: InputDecoration(
            hintText: text,
          ),
        ),
      ],
    );
  }

  Future<void> _updateDataAndNavigateToProfile() async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://192.168.8.26/ProjectWebAdminRekaChain/lib/Project/edit_profile.php'),
      );

      if (_selectedImage.isNotEmpty) {
        request.files.add(http.MultipartFile.fromBytes(
          'profile',
          _selectedImage,
          filename: _originalFileName,
        ));
      }

      request.fields['kode_staff'] = kodeStaffController.text;
      request.fields['nama'] = namaController.text;
      request.fields['jabatan'] = jabatanController.text;
      request.fields['departemen'] = departemenController.text;
      request.fields['unit_kerja'] = unitKerjaController.text;
      request.fields['divisi'] = divisiController.text;
      request.fields['no_telp'] = noTelpController.text;
      request.fields['status'] = statusController.text;
      request.fields['nip'] = nipController.text;
      request.fields['password'] = passwordController.text;
      request.fields['profile'] = profileController.text;

      var response = await request.send();

      if (response.statusCode == 200) {
        String new_filename = '${Uuid().v4()}_${_originalFileName}';
        var responseBody = await response.stream.bytesToString();
        print('Update successful: $responseBody');
        var newProfileUrl =
            'http://192.168.8.26/ProjectWebAdminRekaChain/lib/Project/upload/$new_filename';
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('profile', newProfileUrl);
        DataModel updatedData = DataModel(
          kode_staff: kodeStaffController.text,
          nama: namaController.text,
          jabatan: jabatanController.text,
          unit_kerja: unitKerjaController.text,
          departemen: departemenController.text,
          divisi: divisiController.text,
          email: emailController.text,
          noTelp: noTelpController.text,
          nip: nipController.text,
          status: statusController.text,
          password: passwordController.text,
          konfirmasi_password: konfirmasiPasswordController.text,
          profile: profileController.text,
        );

        String dataKaryawanJson = jsonEncode(updatedData.toJson());
        await prefs.setString('dataKaryawan', dataKaryawanJson);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Profile(nip: widget.nip, data: widget.data)));
      } else {
        print('Failed to update data: ${response.statusCode}');
        var responseBody = await response.stream.bytesToString();
        print('Response: $responseBody');
      }
    } catch (e) {
      print('Error updating data: $e');
    }
  }

  Widget _buildDivider() {
    return const Divider(
      color: Colors.grey,
      thickness: 1.0,
      height: 16.0,
      indent: 0,
      endIndent: 0,
    );
  }

  Widget _buildAvatar() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 125.0,
          decoration: BoxDecoration(
            border: Border.all(width: 4, color: Colors.white),
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 10,
                color: Colors.black.withOpacity(0.1),
              ),
            ],
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              alignment: Alignment.center,
              image: _selectedImage.isNotEmpty
                  ? MemoryImage(_selectedImage)
                  : NetworkImage(widget.data.profile) as ImageProvider,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 80,
          child: InkWell(
            onTap: () {
              _pickImage();
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 4,
                  color: Colors.white,
                ),
                color: const Color.fromARGB(255, 17, 46, 70),
              ),
              child: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
