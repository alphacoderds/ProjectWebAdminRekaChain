class DataModel {
  String kode_staff;
  String nama;
  String jabatan;
  String unit_kerja;
  String departemen;
  String divisi;
  String email;
  String noTelp;
  String nip;
  String status;
  String password;
  String konfirmasi_password;

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
      'konfirmasi_password': konfirmasi_password
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
        konfirmasi_password: json['konfirmasi_password']);
  }
}
