class DataModel {
  final String kode_staff;
  final String nama;
  final String jabatan;
  final String unit_kerja;
  final String departemen;
  final String divisi;
  final String email;
  final String noTelp;
  String nip;
  final String status;
  final String password;
  final String konfirmasi_password;
  final String profile;

  DataModel({
    required this.kode_staff,
    required this.nama,
    required this.jabatan,
    required this.unit_kerja,
    required this.departemen,
    required this.divisi,
    required this.email,
    required this.nip,
    required this.noTelp,
    required this.status,
    required this.password,
    required this.konfirmasi_password,
    required this.profile
  });

  Map<String, dynamic> toJson() {
    return {
      'kode_staff': kode_staff,
      'nama': nama,
      'jabatan': jabatan,
      'unit_kerja': unit_kerja,
      'departemen': departemen,
      'divisi': divisi,
      'email': email,
      'nip': nip,
      'no_telp': noTelp,
      'status': status,
      'password': password,
      'konfirmasi_password': konfirmasi_password,
      'profile': profile
    };
  }

  factory DataModel.getDataFromJson(Map<String, dynamic> json) {
    return DataModel(
        kode_staff: json['kode_staff'],
        nama: json['nama'],
        jabatan: json['jabatan'],
        unit_kerja: json['unit_kerja'],
        departemen: json['departemen'],
        divisi: json['divisi'],
        email: json['email'],
        noTelp: json['no_telp'],
        nip: json['nip'],
        status: json['status'],
        password: json['password'],
        konfirmasi_password: json['konfirmasi_password'],
        profile: json['profile']);
  }
}
