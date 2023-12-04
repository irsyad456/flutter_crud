class Tanggapan {
  int? id;
  int? idPengaduan;
  Null? idPetugas;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_pengaduan'] = this.idPengaduan;
    data['id_petugas'] = this.idPetugas;
    data['tgl_tanggapan'] = this.tglTanggapan;
    data['tanggapan'] = this.tanggapan;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
