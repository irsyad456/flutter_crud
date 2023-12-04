import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:crud/controller/Masyarakatcontroller.dart';
import 'package:crud/masyarakat/homepage.dart';

class Tambahdata extends StatelessWidget {
  const Tambahdata({super.key});

  @override
  Widget build(BuildContext context) {
    Masyarakatcontroller Mc = Get.put(Masyarakatcontroller());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0), // Adjust the value as needed
        child: Column(
          children: [
            SizedBox(height: 10,),
            TextFormField(
              controller: Mc.addDataNik,
              decoration: InputDecoration(
                labelText: 'Nik',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 8,),
            TextFormField(
              controller: Mc.addNama,
              decoration: InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 13,),
            TextFormField(
              controller: Mc.addPasword,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 13,),
            TextFormField(
              controller: Mc.addUsername,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 13,),
            TextFormField(
              controller: Mc.addTelp,
              decoration: InputDecoration(
                labelText: 'Telepon',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),

            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final data = {
                  'nik': Mc.addDataNik.text,
                  'nama': Mc.addNama.text,
                  'username': Mc.addPasword.text,
                  'pass': Mc.addUsername.text,
                  'telp': Mc.addTelp.text
                };
                Mc.addDataNik.clear();
                Mc.addNama.clear();
                Mc.addPasword.clear();
                Mc.addUsername.clear();
                Mc.addTelp.clear();
                Mc.postData(data).then((value) {
                  // Navigasi ke halaman beranda setelah berhasil menambahkan data
                  Get.off(HomePage()); // Ganti HomePage() dengan nama halaman beranda Anda
                });
              },
              child: Text('submit'),
            ),
          ],
        ),
      ),
    );
  }
}
