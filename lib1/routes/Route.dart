import 'package:crud/bindings/DataBinding.dart';
import 'package:crud/index.dart';
import 'package:get/get.dart';

class Routes {
  static final routes = [
    GetPage(name: '/data', page: () => Index(), binding: DataBinding()),
  ];
}
