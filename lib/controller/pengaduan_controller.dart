import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:crud/controller/upload_image_controller.dart';
import 'package:crud/model/pengaduan_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class PengaduanController extends GetxController {
  TextEditingController isiLaporanField = TextEditingController();

  RxBool loading = false.obs;
  Rx<List<Pengaduan>> pengaduanList = Rx<List<Pengaduan>>([]);

  @override
  void onInit() {
    getPengaduan();
    super.onInit();
  }

  getPengaduan () async {
    try {
      loading.value = true;
      pengaduanList.value.clear();
      var data = await http.get(Uri.parse('http://localhost:5000/pengaduan'));
      if ( data.statusCode == 200) {
        final content = jsonDecode(data.body);
        for(Map<String, dynamic> i in content) {
          pengaduanList.value.add(Pengaduan.fromJson(i));
          if(kDebugMode) {
            // print(i);
          }
        }
        loading.value = false;
        // if(kDebugMode) {
        //   print('${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}');
        // }
      } else {
        loading.value = false;
        print('Something Happened With Status ${data.statusCode}');
      }
    } catch(error) {
      loading.value = false;
      print(error.toString());
    }
  }

  int _getLastId() {
    if(pengaduanList.value.isNotEmpty) {
      List<Pengaduan> list = pengaduanList.value.toList()..sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));
      return list.first.id ?? 0;
    } else {
      return 1;
    }
  }

  String _generateMd5Hash(String filename, String extension) {
    final String file = '$filename.$extension';
    final List<int> bytes = utf8.encode(file);
    final Digest md5Result = md5.convert(bytes);
    return md5Result.toString();
  }

  Future<void> postPengaduan(Uint8List imageData, dynamic data) async{
    try{
      loading.value = true; // Create a multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://localhost:5000/pengaduan'),
      );

      // Add JSON data
      request.fields['laporan'] = isiLaporanField.text;
      UploadImageController datas = Get.find<UploadImageController>();

      // Add the file to the request
      if (kIsWeb) {
        // Check if fileInWebsite is not null before adding it to the request
        if (datas.pickedImage.value != null) {
          request.files.add(
            http.MultipartFile.fromBytes(
              'file',
             datas.pickedImage.value!.bytes!, filename: datas.pickedImage.value!.name
            ),
          );
        }
      }

      final viewData = {
        'id' : _getLastId() + 1,
        'isi_laporan' : isiLaporanField.text,
        'tgl_pengaduan' : '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}'
      };
      if(kDebugMode) {print(request.files);}
      // Send the request
      var sendData = await http.Response.fromStream(await request.send());
      if(sendData.statusCode == 201) {
        final newData = Pengaduan.fromJson(viewData);
        pengaduanList.value.add(newData);
        loading.value = false;
        Get.back();
      } else if (sendData.statusCode == 400) {
        loading.value = false;
        print('Must Include Image');
      }
      else {
        loading.value = false;
        print('Cant POST !!!');
        print(sendData.statusCode);
      }
    } catch(error) {
      loading.value = false;
      print(error);
    }
  }

  Future<void> updatePengaduan(int? id, String? tglPengaduan, String? url) async{
    try{
      UploadImageController image = Get.find<UploadImageController>();
      loading.value = true;
      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse('http://localhost:5000/pengaduan/$id')
      );

      request.fields['laporan'] = isiLaporanField.text;

      final viewData = {
        'id' : id,
        'isi_laporan' : isiLaporanField.text,
        'tgl_pengaduan' : tglPengaduan
      };

      if(kIsWeb) {
        if(image.pickedImage.value != null) {
          final String filename = image.pickedImage.value!.name ?? 'NULL';
          final String extension = image.pickedImage.value!.extension ?? 'png';
          request.files.add(
            http.MultipartFile.fromBytes('file', image.pickedImage.value!.bytes!, filename: image.pickedImage.value!.name)
          );
          viewData['url'] = 'http://localhost:5000/images/${_generateMd5Hash(filename, extension)}';
        } else {
          viewData['url'] = url;
        }
      }
      var sendData = await http.Response.fromStream(await request.send());
      if(sendData.statusCode == 200) {
        final updatedData = Pengaduan.fromJson(viewData);
        final index = pengaduanList.value.indexWhere((data) => data.id == id);
        if(index != -1) {
          pengaduanList.value[index] = updatedData;
        }
        loading.value = false;
        Get.back();
      } else {
        loading.value = false;
        print('Error');
      }
    } catch(error) {
      loading.value = false;
      print(error);
    }
  }

  Future<void> deletePengaduan(String id) async {
    try {
      PengaduanController controller = Get.find<PengaduanController>();
      loading.value = true;
      final deleteData = await http.delete(Uri.parse('http://localhost:5000/pengaduan/$id'));
      if(deleteData.statusCode == 200) {
        // getPengaduan();
        // pengaduanList.value.removeWhere((element) => element.id.toString() == id);
        loading.value = false;
        print('Delete Success for id : $id');
      } else {
        loading.value = false;
        print('error with status code :');
        print(deleteData.statusCode);
      }
    } catch(error) {
      loading.value = false;
      print(error.toString());
    }
  }
}