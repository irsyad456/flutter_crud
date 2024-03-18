import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crud/controller/Masyarakatcontroller.dart';
import 'package:crud/masyarakat/homepage.dart';

class Tambahdata extends StatelessWidget {
  const Tambahdata({super.key});

  @override
  Widget build(BuildContext context) {
    Masyarakatcontroller controller = Get.put(Masyarakatcontroller());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjust the value as needed
        child: Column(
          children: [
            const SizedBox(height: 10,),
            TextFormField(
              controller: controller.addDataNik,
              decoration: InputDecoration(
                labelText: 'Nik',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 8,),
            TextFormField(
              controller: controller.addNama,
              decoration: InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 13,),
            TextFormField(
              controller: controller.addPasword,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 13,),
            TextFormField(
              controller: controller.addUsername,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 13,),
            TextFormField(
              controller: controller.addTelp,
              decoration: InputDecoration(
                labelText: 'Telepon',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),

            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final data = {
                  'nik': controller.addDataNik.text,
                  'nama': controller.addNama.text,
                  'username': controller.addPasword.text,
                  'pass': controller.addUsername.text,
                  'telp': controller.addTelp.text
                };
                controller.addDataNik.clear();
                controller.addNama.clear();
                controller.addPasword.clear();
                controller.addUsername.clear();
                controller.addTelp.clear();
                controller.postData(data).then((value) {
                  // Navigasi ke halaman beranda setelah berhasil menambahkan data
                  Get.off(const HomePage()); // Ganti HomePage() dengan nama halaman beranda Anda
                });
              },
              child: const Text('submit'),
            ),
          ],
        ),
      ),
    );
  }
}
