import 'package:RekaChain/WebUser/profile.dart';
import 'package:RekaChain/WebAdmin/data_model.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  final DataModel data;
  final String nip;
  const EditProfile({super.key, required this.data, required this.nip});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController namaLengkapController = TextEditingController();
  TextEditingController jabatanController = TextEditingController();
  TextEditingController unitKerjaController = TextEditingController();
  TextEditingController departemenController = TextEditingController();
  TextEditingController divisiController = TextEditingController();
  TextEditingController nomorTeleponController = TextEditingController();
  TextEditingController niController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) =>
                  EditProfile(data: widget.data, nip: widget.nip),
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Profile(data: widget.data, nip: widget.nip),
                            ),
                          );
                        },
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
            // Main content
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
                label: ' Nama Lengkap',
                text: '',
                controller: namaLengkapController),
            _buildTextView(
                label: ' Jabatan', text: '', controller: jabatanController),
            _buildTextView(
                label: ' Unit Kerja',
                text: '',
                controller: unitKerjaController),
            _buildTextView(
                label: ' Departemen',
                text: '',
                controller: departemenController),
            _buildTextView(
                label: ' Divisi', text: '', controller: divisiController),
            _buildTextView(
                label: ' Nomor Telepon',
                text: '',
                controller: nomorTeleponController),
            _buildTextView(label: ' NIP', text: '', controller: niController),
            _buildTextView(
                label: ' Password', text: '', controller: passwordController),
            _buildTextView(
                label: ' Status', text: '', controller: statusController),
            const SizedBox(height: 16.0),
          ],
        ),
      ],
    );
  }

  Widget _buildTextView(
      {required String label,
      required String text,
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
          controller: controller,
          decoration: InputDecoration(
            hintText: text,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: Colors.grey,
      thickness: 1.0,
      height: 16.0,
    );
  }

  Widget _buildAvatar() {
    return Container(
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
        image: const DecorationImage(
          fit: BoxFit.cover,
          alignment: Alignment.center,
          image: AssetImage('assets/images/profile-illustration.png'),
        ),
      ),
    );
  }
}
