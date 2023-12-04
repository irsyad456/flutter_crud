import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_masyrakat/controller/Masyarakatcontroller.dart';
import 'package:project_masyrakat/viewmasyarakat/tambahdata.dart';
import 'package:project_masyrakat/viewmasyarakat/updateM.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    Masyarakatcontroller dua = Get.put(Masyarakatcontroller());
    return Theme(
      data: ThemeData(
        primaryColor: Colors.blue,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Halaman Masyarakat"),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(Tambahdata());
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        body: Obx(() => dua.isLoading.value
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
          itemCount: dua.listmodel.value.length,
          itemBuilder: (BuildContext context, int index) {
            final item = dua.listmodel.value[index];

            return Card(
              elevation: 4,
              color: Colors.white,
              margin: EdgeInsets.all(16),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 30,
                  child: Text(
                    '${item.nik}',
                    style: TextStyle(
                      fontSize: 0.5 * 30, // 0.5 adalah faktor yang Anda dapat sesuaikan
                      color: Colors.white, // Warna teks
                    ),
                  ),
                ),
                title: Text(
                  '${item.nama}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  '${item.telp}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.edit_outlined,
                        size: 30,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        // Aksi Update
                        Get.to(updateData(item)); // Navigasi ke halaman Update
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        size: 30,
                        color: Colors.red, // Warna ikon yang berbeda
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Hapus Data'),
                              content: Text(
                                  'Apakah Anda yakin ingin menghapus data ini?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Tutup dialog
                                  },
                                  child: Text('Batal'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Aksi Delete data
                                    dua.deleteMasyarakat(item.nik.toString());
                                    Navigator.of(context).pop(); // Tutup dialog
                                  },
                                  child: Text('Hapus'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        ),
      ),
    );
  }
}
