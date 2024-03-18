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
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['nama_petugas'] = namaPetugas;
    data['username'] = username;
    data['password'] = password;
    data['telp'] = telp;
    data['level'] = level;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
