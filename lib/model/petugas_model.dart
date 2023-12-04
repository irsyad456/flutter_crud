class Petugas {
  int? id;
  String? namaPetugas;
  String? username;
  String? password;
  String? telp;
  String? level;
  String? createdAt;
  String? updatedAt;

  Petugas(
      {this.id,
        this.namaPetugas,
        this.username,
        this.password,
        this.telp,
        this.level,
        this.createdAt,
        this.updatedAt});

  Petugas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaPetugas = json['nama_petugas'];
    username = json['username'];
    password = json['password'];
    telp = json['telp'];
    level = json['level'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_petugas'] = this.namaPetugas;
    data['username'] = this.username;
    data['password'] = this.password;
    data['telp'] = this.telp;
    data['level'] = this.level;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
