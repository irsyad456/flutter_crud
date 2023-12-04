import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:project_masyrakat/viewpengaduan/tambah.dart';

import 'controller/pengaduancontroller.dart';

class Pengaduan extends StatelessWidget {
  const Pengaduan({super.key});

  @override
  Widget build(BuildContext context) {
    PengaduanController pengaduan = Get.put(PengaduanController());
    return Scaffold(
        appBar: AppBar(
          title: Text("Halaman Pengaduan"),
          actions: [
            IconButton(
              onPressed: () {
                // Get.to(tambahPengaduan());
              },
              icon: Icon(Icons.add_a_photo),
            ),
          ],
        ),
        body: Obx(
          () => pengaduan.isLoading1.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: pengaduan.listPengaduan.value.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = pengaduan.listPengaduan.value[index];

                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Text('${item.idPengaduan}'),
                        ),
                        title: Text(
                          '${item.tglPengaduan}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Isi Laporan: ${item.isiLaporan}',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              'Status: ${item.status}',
                              style: TextStyle(color: Colors.grey),
                            ),
                            if (item.url != null && item.url!.isNotEmpty)
                              Image.network(
                                item.url ?? '',
                              )
                            else
                              Container(
                                color: Colors
                                    .white, // or any color you want for an empty image
                              ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                // Handle edit action
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                // Aksi Delete
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Hapus Data'),
                                      content: Text(
                                        'Apakah Anda yakin ingin menghapus data ini?',
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Tutup dialog
                                          },
                                          child: Text('Batal'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // Handle delete action
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
        ));
  }
}
