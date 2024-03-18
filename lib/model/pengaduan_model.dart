class Pengaduan {
  int? id;
  String? tglPengaduan;
  int? nik;
  String? isiLaporan;
  String? foto;
  String? url;
  String? status;
  String? createdAt;
  String? updatedAt;

  Pengaduan(
      {this.id,
        this.tglPengaduan,
        this.nik,
        this.isiLaporan,
        this.foto,
        this.url,
        this.status,
        this.createdAt,
        this.updatedAt});

  Pengaduan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tglPengaduan = json['tgl_pengaduan'];
    nik = json['nik'];
    isiLaporan = json['isi_laporan'];
    foto = json['foto'];
    url = json['url'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['tgl_pengaduan'] = tglPengaduan;
    data['nik'] = nik;
    data['isi_laporan'] = isiLaporan;
    data['foto'] = foto;
    data['url'] = url;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
