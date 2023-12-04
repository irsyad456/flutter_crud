class masyarakat_model {
  String? nik;
  String? nama;
  String? username;
  String? password;
  String? telp;
  String? createdAt;
  String? updatedAt;

  masyarakat_model(
      {this.nik,
        this.nama,
        this.username,
        this.password,
        this.telp,
        this.createdAt,
        this.updatedAt});

  masyarakat_model.fromJson(Map<String, dynamic> json) {
    nik = json['nik'];
    nama = json['nama'];
    username = json['username'];
    password = json['password'];
    telp = json['telp'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nik'] = nik;
    data['nama'] = nama;
    data['username'] = username;
    data['password'] = password;
    data['telp'] = telp;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}