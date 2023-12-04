import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project_masyrakat/model/masyarakatmodel.dart';
import 'package:http/http.dart' as http;

class Masyarakatcontroller extends GetxController{
  TextEditingController addDataNik = TextEditingController();
  TextEditingController addNama = TextEditingController();
  TextEditingController addPasword = TextEditingController();
  TextEditingController addUsername = TextEditingController();
  TextEditingController addTelp = TextEditingController();

  RxBool isLoading= false.obs;
  Rx<List<masyarakat_model>> listmodel = Rx<List<masyarakat_model>>([]);

  void onInit(){
    getData();
    super.onInit();
  }

  getData() async{
    try{
      isLoading.value = true;
      var response = await http.get(Uri.parse('http://192.168.232.84:5000/masyarakat'));
      if(response.statusCode == 200) {
        isLoading.value = false;
        final content = jsonDecode(response.body);
        for (Map<String,dynamic> i in content){
          listmodel.value.add(masyarakat_model.fromJson(i));
          print(listmodel.value.length);
        }

      }else{
        isLoading.value=false;
        print("terjadi kesalahan");
      }
    }catch(e){
      isLoading.value=false;
      print(e.toString());
    }
  }

  Future<void> postData(Map<String, dynamic> data) async {
    try{
      isLoading.value= true;
      final response = await http.post(Uri.parse('http://192.168.232.84:5000/masyarakat'),
        body:jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 201) {
        final newData = masyarakat_model.fromJson(data);
        listmodel.value.add(newData);
        isLoading.value = false;
        print('data berhasil ditambahkan');
        Get.back();
      }else {
        isLoading.value= false;
        print('data gagal ditambahkan');
      }
    }catch (e) {
      isLoading.value = false;
      print('Terjadi kesalahan: $e');
    }
  }
  Future<void> updateData(Map<String, dynamic> data, String nik) async {
    try {
      isLoading.value = true;
      final response = await http.patch(
        Uri.parse('http://192.168.232.84:5000/masyarakat/$nik'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final updatedData = masyarakat_model.fromJson(data);
        final index = listmodel.value.indexWhere((item) => item.nik == nik);
        if (index != -1) {
          listmodel.value[index] = updatedData; // Perbarui data di daftar di Flutter
        }
        isLoading.value = false;
        print('Data berhasil diperbarui.');
        Get.back();
      } else {
        isLoading.value = false;
        print('Gagal memperbarui data.');
      }
    } catch (e) {
      isLoading.value = false;
      print('Terjadi kesalahan: $e');
    }
  }

   Future<void> deleteMasyarakat(String nik) async {
    try {
      isLoading.value = true;
      final response = await http.delete(
        Uri.parse('http://192.168.232.84:5000/masyarakat/$nik'), // Ganti dengan URL endpoint Node.js Anda.
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        listmodel.value.removeWhere((item) => item.nik == nik);
        isLoading.value = false;
        print('Data berhasil dihapus.');
      } else {
        isLoading.value = false;
        print('Gagal menghapus data.');
      }
    } catch (e) {
      isLoading.value = false;
      print('Terjadi kesalahan: $e');
    }
  }
}


