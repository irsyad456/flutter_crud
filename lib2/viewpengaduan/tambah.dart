/// CREATE PENGADUAN
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/pengaduancontroller.dart';

class tambahPengaduan extends StatelessWidget {
  final PengaduanController pengaduan = Get.put(PengaduanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pengaduan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: pengaduan.id_pengaduan,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Masukkan id',
              ),
            ),
            TextField(
              controller: pengaduan.nik,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Masukkan NIK',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: pengaduan.isiLaporan,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Masukkan Isi Laporan',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: pengaduan.pickImage,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                textStyle: MaterialStateProperty.all(
                  const TextStyle(color: Colors.white),
                ),
              ),
              child: const Text('Pilih Gambar'),
            ),
            const SizedBox(height: 10),
            Obx(() {
              return pengaduan.pickedFile.value != null
                  ? Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: Image.memory(
                        Uint8List.fromList(pengaduan.pickedFile.value!.bytes!),
                        fit: BoxFit.cover,
                      ),
                    )
                  : const SizedBox.shrink();
            }),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: pengaduan.uploadPengaduan,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                textStyle: MaterialStateProperty.all(
                  const TextStyle(color: Colors.white),
                ),
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
