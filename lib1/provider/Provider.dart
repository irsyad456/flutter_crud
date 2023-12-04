import 'package:crud/controllers/DataController.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Provider extends GetConnect {
  Future<dynamic> getMasyarakat() async {
    // get('http://lan-ip:port/path')
    final response = await get('http://192.168.232.63:5000/masyarakat');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }

  // Future<dynamic> registerMasyarakat() async{
  //   final response = await post(
  //     'http://192.168.40.150:5000/masyarakat',
  //     {
  //       'nama': 'COntoh Nama',
  //       'username': 'contoh',
  //       'pass': '1234',
  //       'telp': '081293821'
  //     }
  //   );
  // }

  // fungsi dibawah digunakan untuk membuat fungsi get all masyarakat
  void GetMasyarakat() async {
    final response = await get('http://192.168.232.63:5000/masyarakat');

    if (kDebugMode) {
      print(response.body);
    }
  }

  void postMasyarakat(String nik, String nama, String username, String password,
      String telp) async {
    final response = await post('http://192.168.232.63:5000/masyarakat', {
      'nik': nik,
      'nama': nama,
      'username': username,
      'pass': password,
      'telp': telp,
    });
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    }
  }

  void updateMasyarakat(String nik, String nama, String username, String telp) async {
    try {
      print(nik);
      final response = await patch('http://192.168.232.63:5000/masyarakat?nik=$nik', {
        'nik': nik,
        'nama': nama,
        'username': username,
        'telp': telp,
      });
      print(response.bodyString);

      if (response.body == null) {
        // Handle empty response
        return Future.error('Empty response from the server');
      }

      if(response.status.hasError) {

        return Future.error(response.statusText!);
      }
      final data = Masyarakat(nik: nik, nama: nama, telp: telp);

      DataController().updateMasyarakat(nik, data);
      // Handle the response here
    } catch (e) {
      // Log or display the error
      print('$e');
    }
  }

  void deleteMasyarakat(String? nik) async {
    final response =
        await delete('http://192.168.232.63:5000/masyarakat?id=${nik}');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    }
  }
}
