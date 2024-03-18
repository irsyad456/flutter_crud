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
    GetPage(name: '/', page: () => const Index()),
    GetPage(name: '/masyarakat', page: () => const HomePage()),
    GetPage(name: '/pengaduan', page: () => const Pengaduan()),
    GetPage(name: '/pengaduan/add', page: () => const AddPengaduan()),
    GetPage(name: '/pengaduan/edit', page: () => UpdatePengaduan()),
    GetPage(name: '/petugas', page: () => const ViewPetugas()),
    GetPage(name: '/tanggapan', page: () => const ViewTanggapan()),
  ];
}