import 'package:crud/controller/pengaduan_controller.dart';
import 'package:get/get.dart';

import '../controller/Masyarakatcontroller.dart';

class BindingsData extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => Masyarakatcontroller());
    Get.lazyPut(() => PengaduanController());
  }

}