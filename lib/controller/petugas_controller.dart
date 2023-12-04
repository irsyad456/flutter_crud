import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:crud/model/petugas_model.dart';
import 'package:http/http.dart' as http;

class PetugasController extends GetxController {
  TextEditingController namaField = TextEditingController();
  TextEditingController usernameField = TextEditingController();
  TextEditingController passwordField = TextEditingController();
  TextEditingController telpField = TextEditingController();

  RxBool loading = false.obs;
  Rx<List<Petugas>> petugasList = Rx<List<Petugas>>([]);
  RxString selectedLevel = 'admin'.obs;
  
  @override
  void onInit() {
    // TODO: implement onInit
    getPetugas();
    super.onInit();
  }

  // void updateLevel(String initialLevel, String newLevel) {
  //   if(initialLevel.isNotEmpty) {
  //     selectedLevel.value = initialLevel;
  //   } else {
  //     selectedLevel.value = newLevel;
  //   }
  // }

  // Resetting Field And It's Initial Value
  // Only Work In Corresponding Controller
  void resetFields() {
    namaField.clear();
    usernameField.clear();
    telpField.clear();
    passwordField.clear();
    selectedLevel.value = 'admin';
  }

  int _getLastId() {
    if(petugasList.value.isNotEmpty) {
      List<Petugas> list = petugasList.value.toList()..sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));
      return list.first.id ?? 0;
    } else {
      return 1;
    }
  }

  getPetugas() async {
    try {
      loading.value = true;
      var response =
      await http.get(Uri.parse('http://localhost:5000/petugas'));
      if (response.statusCode == 200) {
        final content = jsonDecode(response.body);
        for (Map<String, dynamic> i in content) {
          petugasList.value.add(Petugas.fromJson(i));
          // print(petugasList.value.length);
        }
        loading.value = false;
      } else {
        loading.value = false;
        print('Error, Status Code: ${response.statusCode}');
      }
    } catch (e) {
      loading.value = false;
      print(e.toString());
    }
  }

  Future<void> postPetugas(Map<String, dynamic> data) async {
    try {
      data['id'] = (_getLastId() + 1).toString();
      /**
       * body petugas:
       * nama_petugas
       * username
       * pass
       * telp
       * level
       * tipe data string semua
       * */
      loading.value = true;
      final response = await http.post(
        Uri.parse('http://localhost:5000/petugas'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 201) {
        data['id'] = _getLastId() + 1;
        final newData = Petugas.fromJson(data);
        petugasList.value.add(newData);
        loading.value = false;
        print('data berhasil ditambahkan');
        Get.back();
      } else {
        loading.value = false;
        print('data gagal ditambahkan');
      }
    } catch (e) {
      loading.value = false;
      print('Terjadi kesalahan: $e');
    }
  }

  Future<void> updatePetugas(Map<String, dynamic> data, String id) async {
    try {
      /**
       * body petugas:
       * nama_petugas
       * username
       * telp
       * level
       * tipe data string semua
       * */
      loading.value = true;
      final response = await http.patch(
        Uri.parse('http://localhost:5000/petugas?id=$id'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final updatedData = Petugas.fromJson(data);
        final index = petugasList.value.indexWhere((item) => item.id.toString() == id);
        if (index != -1) {
          petugasList.value[index] =
              updatedData; // Perbarui data di daftar di Flutter
        }
        loading.value = false;
        print('Data berhasil diperbarui.');
        Get.back();
      } else {
        loading.value = false;
        print('Gagal memperbarui data dengan status code: ${response.statusCode}');
      }
    } catch (e) {
      loading.value = false;
      print('Terjadi kesalahan: $e');
    }
  }

  Future<void> deletePetugas(String id) async {
    try {
      loading.value = true;
      final response = await http.delete(
        Uri.parse(
            'http://localhost:5000/petugas?id=$id'), // Ganti dengan URL endpoint Node.js Anda.
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        petugasList.value.removeWhere((item) => item.id.toString() == id);
        loading.value = false;
        print('Data berhasil dihapus.');
      } else {
        loading.value = false;
        print('Gagal menghapus data. Status: ${response.statusCode}');
      }
    } catch (e) {
      loading.value = false;
      print('Terjadi kesalahan: $e');
    }
  }
}