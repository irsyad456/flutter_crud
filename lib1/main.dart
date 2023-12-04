import 'package:crud/bindings/DataBinding.dart';
import 'package:crud/routes/Route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/data',
      initialBinding: DataBinding(),
      getPages: Routes.routes,
      title: 'Flutter CRUD',
    );
  }
}