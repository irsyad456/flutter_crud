import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';

import '../model/pengaduanmodel.dart';

class PengaduanController extends GetxController {
  final TextEditingController id_pengaduan = TextEditingController();
  final TextEditingController nik = TextEditingController();
  final TextEditingController isiLaporan = TextEditingController();
  final Rx<PlatformFile?> pickedFile = Rx<PlatformFile?>(null);
  final RxBool isLoading1 = false.obs;
  final Rx<List<Pengaduan>> listPengaduan = Rx<List<Pengaduan>>([]);

  var logger = Logger();

  void pickImage() async {
    FilePickerResult? result =
    await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      pickedFile.value = result.files.first;
    }
  }

  @override
  void onInit() {
    getPengaduan();
    super.onInit();
  }

  Future<void> getPengaduan() async {
    try {
      isLoading1.value = true;
      var response = await http.get(Uri.parse('http://192.168.40.79:5000/pengaduan'));
      logger.d(response.body);

      if (response.statusCode == 200) {
        isLoading1.value = false;
        final content = jsonDecode(response.body);

        listPengaduan.value.clear();
        for (Map<String, dynamic> i in content) {
          listPengaduan.value.add(Pengaduan.fromJson(i));
          logger.d(listPengaduan.value.length);
        }
      } else {
        isLoading1.value = false;
        logger.e("Terjadi kesalahan. Status code: ${response.statusCode}");
      }
    } catch (e) {
      isLoading1.value = false;
      logger.e("Terjadi kesalahan: $e");
    }
  }


  Future<void> uploadPengaduan() async {
    try {
      isLoading1.value = true;
      final data = {
        'id_pengaduan': id_pengaduan.text,
        'nik': nik.text,
        'isi_laporan': isiLaporan.text,
      };

      if (pickedFile.value != null) {
        http.MultipartFile file = http.MultipartFile.fromBytes(
          'image',
          pickedFile.value!.bytes!,
          filename: pickedFile.value!.name,
          contentType: MediaType('image', 'jpeg'),
        );

        var request = http.MultipartRequest(
          'POST',
          Uri.parse('http://192.168.40.79:5000/pengaduan'),
        )
          ..fields.addAll(data)
          ..files.add(file);

        var response =
        await http.Response.fromStream(await request.send());

        if (response.statusCode == 201) {
          final dataPengaduan =
          Pengaduan.fromJson(jsonDecode(response.body));
          listPengaduan.value.add(dataPengaduan);
          isLoading1.value = false;
          logger.d('Message: ${response.body}');
          await getPengaduan();

          Get.back();
        } else {
          isLoading1.value = false;
          logger.e("Error: ${response.body}");
        }
      } else {
        await createPengaduan(data);
      }
    } catch (e) {
      isLoading1.value = false;
      logger.e('Error: $e');
    }
  }

  Future<void> createPengaduan(Map<String, dynamic> data) async {
    try {
      isLoading1.value = true;
      final response = await http.post(
        Uri.parse('http://localhost:5000/pengaduan'),
        body: jsonEncode(data),
        headers: {'Content-type': 'application/json'},
      );

      if (response.statusCode == 201) {
        final dataPengaduan =
        Pengaduan.fromJson(jsonDecode(response.body));
        listPengaduan.value.add(dataPengaduan);
        isLoading1.value = false;
        debugPrint('Message: ${response.body}');
      } else {
        isLoading1.value = false;
        debugPrint("Error: ${response.body}");
      }
    } catch (e) {
      isLoading1.value = false;
      debugPrint('Error: $e');
    }
  }

  Future<void> updatePengaduan(int idPengaduan, String isiLaporan) async {
    try {
      isLoading1.value = true;

      final data = {'isi_laporan': isiLaporan};

      var response = await http.patch(
        Uri.parse('http://localhost:5000/pengaduan/$idPengaduan'),
        body: jsonEncode(data),
        headers: {'Content-type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final updatedData =
        Pengaduan.fromJson(jsonDecode(response.body));
        final index = listPengaduan.value
            .indexWhere((item) => item.idPengaduan == idPengaduan);
        if (index != -1) {
          listPengaduan.value[index] = updatedData;
        }

        await getPengaduan();
        Get.offNamed('/pengaduan');
        debugPrint('Message: ${response.body}');
      } else {
        isLoading1.value = false;
        debugPrint('Error: ${response.body}');
      }
    } catch (e) {
      isLoading1.value = false;
      debugPrint('Error: $e');
    }
  }

  Future<void> updatePengaduanWithImage(int idPengaduan, String isiLaporan) async {
    try {
      isLoading1.value = true;
      final data = {'isi_laporan': isiLaporan};

      if (pickedFile.value != null) {
        http.MultipartFile file = http.MultipartFile.fromBytes(
          'image',
          pickedFile.value!.bytes!,
          filename: pickedFile.value!.name,
          contentType: MediaType('image', 'jpeg'),
        );

        var request = http.MultipartRequest(
          'PATCH',
          Uri.parse('http://localhost:5000/pengaduan/$idPengaduan'),
        )
          ..fields.addAll(data)
          ..files.add(file);

        var response = await http.Response.fromStream(await request.send());

        if (response.statusCode == 200) {
          final updatedData =
          Pengaduan.fromJson(jsonDecode(response.body));
          final index = listPengaduan.value
              .indexWhere((item) => item.idPengaduan == idPengaduan);
          if (index != -1) {
            listPengaduan.value[index] = updatedData;
          }

          await getPengaduan();
          Get.offNamed('/pengaduan');
          debugPrint('Message: ${response.body}');
          pickedFile.value = null;
        } else {
          isLoading1.value = false;
          debugPrint('Error: ${response.body}');
        }
      } else {
        await updatePengaduan(idPengaduan, isiLaporan);
      }
    } catch (e) {
      isLoading1.value = false;
      debugPrint('Error: $e');
    }
  }

  Future<void> deletePengaduan(int idPengaduan) async {
    try {
      isLoading1.value = true;

      var response = await http.delete(
        Uri.parse('http://localhost:5000/pengaduan/$idPengaduan'),
      );

      if (response.statusCode == 200) {
        // Hapus data dari listPengaduan berdasarkan idPengaduan
        listPengaduan.value.removeWhere((pengaduan) => pengaduan.idPengaduan == idPengaduan);
        isLoading1.value = false;
        debugPrint('Message: ${response.body}');
      } else {
        isLoading1.value = false;
        debugPrint('Error: ${response.body}');
      }
    } catch (e) {
      isLoading1.value = false;
      debugPrint('Error: $e');
    }
  }

}