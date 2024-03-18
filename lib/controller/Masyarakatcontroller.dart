import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:crud/model/masyarakatmodel.dart';
import 'package:http/http.dart' as http;

class Masyarakatcontroller extends GetxController {
  TextEditingController addDataNik = TextEditingController();
  TextEditingController addNama = TextEditingController();
  TextEditingController addPasword = TextEditingController();
  TextEditingController addUsername = TextEditingController();
  TextEditingController addTelp = TextEditingController();

  RxBool isLoading = false.obs;
  Rx<List<MasyarakatModel>> listmodel = Rx<List<MasyarakatModel>>([]);

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    try {
      isLoading.value = true;
      var response =
          await http.get(Uri.parse('http://localhost:5000/masyarakat'));
      if (response.statusCode == 200) {
        final content = jsonDecode(response.body);
        for (Map<String, dynamic> i in content) {
          listmodel.value.add(MasyarakatModel.fromJson(i));
        }
        isLoading.value = false;
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future<void> postData(Map<String, dynamic> data) async {
    try {
      isLoading.value = true;
      final response = await http.post(
        Uri.parse('http://localhost:5000/masyarakat'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 201) {
        final newData = MasyarakatModel.fromJson(data);
        listmodel.value.add(newData);
        isLoading.value = false;
        Get.back();
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future<void> updateData(Map<String, dynamic> data, String nik) async {
    try {
      isLoading.value = true;
      final response = await http.patch(
        Uri.parse('http://localhost:5000/masyarakat?nik=$nik'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final updatedData = MasyarakatModel.fromJson(data);
        final index = listmodel.value.indexWhere((item) => item.nik == nik);
        if (index != -1) {
          listmodel.value[index] =
              updatedData; // Perbarui data di daftar di Flutter
        }
        isLoading.value = false;
        Get.back();
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future<void> deleteMasyarakat(String nik) async {
    try {
      isLoading.value = true;
      final response = await http.delete(
        Uri.parse(
            'http://localhost:5000/masyarakat?nik=$nik'), // Ganti dengan URL endpoint Node.js Anda.
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        listmodel.value.removeWhere((item) => item.nik == nik);
        isLoading.value = false;
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
    }
  }
}
