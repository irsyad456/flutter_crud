import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD Pengaduan Masyarakat'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () => Get.toNamed('/masyarakat'), child: const Text('Masyarakat')),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: () => Get.toNamed('/pengaduan'), child: const Text('Pengaduan')),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: () => Get.toNamed('/petugas'), child: const Text('Petugas')),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: () => Get.toNamed('/tanggapan'), child: const Text('tanggapan')),
          ],
        ),
      ),
    );
  }
}
