import 'package:crud/model/tanggapan_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TanggapanController extends GetxController{
  TextEditingController tanggapanField = TextEditingController();
  TextEditingController idPengaduanField = TextEditingController();
  
  RxBool loading = false.obs;
  Rx<List<Tanggapan>> tanggapanList = Rx<List<Tanggapan>>([]);

  void resetFields() {
    tanggapanField.clear();
    idPengaduanField.clear();
  }

  int _getLastId() {
    if(tanggapanList.value.isNotEmpty) {
      List<Tanggapan> list = tanggapanList.value.toList()..sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));
      return list.first.id ?? 0;
    } else {
      return 1;
    }
  }
  
  @override
  void onInit() {
    // TODO: implement onInit
    getTanggapan();
    super.onInit();
  }

  getTanggapan() async {
    try {
      loading.value = true;
      var response =
      await http.get(Uri.parse('http://localhost:5000/tanggapan'));
      if (response.statusCode == 200) {
        final content = jsonDecode(response.body);
        for (Map<String, dynamic> i in content) {
          tanggapanList.value.add(Tanggapan.fromJson(i));
        }
        loading.value = false;
      } else {
        loading.value = false;
      }
    } catch (e) {
      loading.value = false;
    }
  }

  Future<void> postTanggapan(Map<String, dynamic> data, String id) async {
    try {
      loading.value = true;
      final response = await http.post(
        Uri.parse('http://localhost:5000/tanggapan?id=$id'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 201) {
        final viewData = {
          'id' : _getLastId() + 1,
          'id-pengaduan' : data['id_pengaduan'],
          'tanggapan' : data['tanggapan'],
          'tgl_tanggapan' : '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}'
        };
        final newData = Tanggapan.fromJson(viewData);
        tanggapanList.value.add(newData);
        loading.value = false;
        Get.back();
      } else if(response.statusCode == 400) {
        loading.value = false;
        Get.back();
        Get.snackbar('Warning', "Pengaduan Doesn't Exist", duration: const Duration(seconds: 5));
      } else if(response.statusCode == 204) {
        loading.value = false;
        Get.back();
        Get.snackbar('Warning', 'Pengaduan Already Solved', duration: const Duration(seconds: 5));
      } else {
        loading.value = false;
        Get.back();
      }
    } catch (e) {
      loading.value = false;
    }
  }

  Future<void> updateTanggapan(Map<String, dynamic> data, String id) async {
    try {
      loading.value = true;
      final response = await http.patch(
        Uri.parse('http://localhost:5000/tanggapan?id=$id'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final tanggapanData = Tanggapan.fromJson(data);
        final index = tanggapanList.value.indexWhere((item) => item.id.toString() == id);
        if (index != -1) {
          tanggapanList.value[index] =
              tanggapanData; // Perbarui data di daftar di Flutter
        }
        loading.value = false;
        Get.back();
      } else {
        loading.value = false;
      }
    } catch (e) {
      loading.value = false;
    }
  }

  Future<void> deleteTanggapan(String id) async {
    try {
      loading.value = true;
      final response = await http.delete(
        Uri.parse(
            'http://localhost:5000/tanggapan/$id'), // Ganti dengan URL endpoint Node.js Anda.
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        tanggapanList.value.removeWhere((item) => item.id.toString() == id);
        loading.value = false;
      } else {
        loading.value = false;
      }
    } catch (e) {
      loading.value = false;
    }
  }
}