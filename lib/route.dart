import 'package:crud/index.dart';
import 'package:crud/masyarakat/homepage.dart';
import 'package:crud/pengaduan/addPengaduan.dart';
import 'package:crud/pengaduan/index.dart';
import 'package:crud/pengaduan/update_pengaduan.dart';
import 'package:crud/petugas/view_petugas.dart';
import 'package:crud/tanggapan/view_tanggapan.dart';
import 'package:get/get.dart';

class Routes {
  static final routes = [
    GetPage(name: '/', page: () => Index()),
    GetPage(name: '/masyarakat', page: () => HomePage()),
    GetPage(name: '/pengaduan', page: () => Pengaduan()),
    GetPage(name: '/pengaduan/add', page: () => AddPengaduan()),
    GetPage(name: '/pengaduan/edit', page: () => UpdatePengaduan()),
    GetPage(name: '/petugas', page: () => ViewPetugas()),
    GetPage(name: '/tanggapan', page: () => ViewTanggapan()),
  ];
}