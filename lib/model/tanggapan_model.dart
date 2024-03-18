class Tanggapan {
  int? id;
  int? idPengaduan;
  int? idPetugas;
  String? tglTanggapan;
  String? tanggapan;
  String? createdAt;
  String? updatedAt;

  Tanggapan(
      {this.id,
        this.idPengaduan,
        this.idPetugas,
        this.tglTanggapan,
        this.tanggapan,
        this.createdAt,
        this.updatedAt});

  Tanggapan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idPengaduan = json['id_pengaduan'];
    idPetugas = json['id_petugas'];
    tglTanggapan = json['tgl_tanggapan'];
    tanggapan = json['tanggapan'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_pengaduan'] = idPengaduan;
    data['id_petugas'] = idPetugas;
    data['tgl_tanggapan'] = tglTanggapan;
    data['tanggapan'] = tanggapan;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
