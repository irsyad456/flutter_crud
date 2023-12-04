import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_masyrakat/controller/Masyarakatcontroller.dart';
import 'package:project_masyrakat/model/masyarakatmodel.dart';

class updateData extends StatelessWidget {
  final Masyarakatcontroller masyarakatcontroller = Get.find();
  final masyarakat_model masyarakat;

  updateData(this.masyarakat);

  @override
  Widget build(BuildContext context) {
    TextEditingController addDataNik = TextEditingController(text: masyarakat.nik);
    TextEditingController addNama = TextEditingController(text: masyarakat.nama);
    TextEditingController addPasword = TextEditingController(text: masyarakat.password);
    TextEditingController addUsername = TextEditingController(text: masyarakat.username);
    TextEditingController addTelp = TextEditingController(text: masyarakat.telp);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 10,),
            TextFormField(
              controller: addDataNik,
              decoration: InputDecoration(
                labelText: 'Nik',
                // ...
              ),
            ),
            SizedBox(height: 8,),
            TextFormField(
              controller: addNama,
              decoration: InputDecoration(
                labelText: 'Nama',
                // ...
              ),
            ),
            SizedBox(height: 8,),
            TextFormField(
              controller: addPasword,
              decoration: InputDecoration(
                labelText: 'Username',
                // ...
              ),
            ),
            SizedBox(height: 8,),
            TextFormField(
              controller: addUsername,
              decoration: InputDecoration(
                labelText: 'Password',
                // ...
              ),
            ),
            SizedBox(height: 8,),
            TextFormField(
              controller: addTelp,
              decoration: InputDecoration(
                labelText: 'Telepon',
                // ...
              ),
            ),

            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final data = {
                  'nik': addDataNik.text,
                  'nama': addNama.text,
                  'username': addPasword.text,
                  'password': addUsername.text,
                  'telp': addTelp.text
                };
                masyarakatcontroller.updateData(data, masyarakat.nik.toString());
                // Di sini, Anda dapat menyimpan data ke Masyarakatcontroller jika diperlukan.
              },
              child: Text('submit'),
            ),
          ],
        ),
      ),
    );
  }
}
