import 'package:crud/controller/pengaduan_controller.dart';
import 'package:crud/pengaduan/update_pengaduan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Pengaduan extends StatelessWidget {
  const Pengaduan({super.key});

  @override
  Widget build(BuildContext context) {
    PengaduanController pengaduan_controller = Get.find<PengaduanController>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pengaduan'),
          actions: [
            IconButton(
                onPressed: () => pengaduan_controller.getPengaduan(),
                icon: const Icon(Icons.access_alarm)),
            IconButton(
                onPressed: () => Get.toNamed('/pengaduan/add'),
                icon: const Icon(Icons.add))
          ],
        ),
        body:
            // Obx(() => controller.loading.value ? const Center(child: CircularProgressIndicator()) : ListView.builder(itemCount: controller.pengaduanList.value.length, itemBuilder: (BuildContext context, int index) {
            //   final pengaduan = controller.pengaduanList.value[index];
            //   return Card(elevation: 4, color: Colors.white, margin: const EdgeInsets.all(16), child: Image.network('${pengaduan.url}', scale: 0.5,),);
            // },))
            Obx(() => pengaduan_controller.loading.value
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: pengaduan_controller.pengaduanList.value.length,
                    itemBuilder: (BuildContext context, int index) {
                      final pengaduan =
                          pengaduan_controller.pengaduanList.value[index];

                      return Card(
                        elevation: 4,
                        color: Colors.white,
                        margin: const EdgeInsets.all(16),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: CircleAvatar(
                            backgroundColor: Colors.teal,
                            radius: 30,
                            child: Text('${pengaduan.id}'),
                          ),
                          title: Text('${pengaduan.isiLaporan}'),
                          subtitle: Text('${pengaduan.tglPengaduan}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () => Get.to(UpdatePengaduan(
                                        isiLaporan: pengaduan.isiLaporan,
                                        image: pengaduan.url,
                                        id: pengaduan.id,
                                        tglPengaduan: pengaduan.tglPengaduan,
                                        url: pengaduan.url,
                                      )),
                                  icon: const Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'Delete Pengaduan ?'),
                                            content: const Text(
                                                'You Sure To Delete This Data ?'),
                                            actions: <Widget>[
                                              TextButton(
                                                  onPressed: () => Get.back(),
                                                  child: const Text('Cancel')),
                                              TextButton(
                                                  onPressed: () async {
                                                    pengaduan_controller
                                                        .deletePengaduan(
                                                            pengaduan.id
                                                                .toString());
                                                    Get.back();
                                                    pengaduan_controller
                                                        .getPengaduan();
                                                  },
                                                  child: const Text('Delete'))
                                            ],
                                          );
                                        });
                                  },
                                  icon: const Icon(Icons.delete)),
                            ],
                          ),
                        ),
                      );
                    },
                  )));
  }
}
