import 'package:crud/bindings/bindingsData.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crud/route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: Routes.routes,
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsData(),
    );
  }
}
