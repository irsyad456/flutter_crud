import 'package:crud/provider/Provider.dart';
import 'package:get/get.dart';

class DataController extends GetxController with StateMixin<dynamic> {
  RxList<Masyarakat> masyarakatList = RxList<Masyarakat>();
  RxBool loading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    loading.value = true;
    super.onInit();
    Provider().getMasyarakat().then((value) {
      final List<Masyarakat> data = (value as List<dynamic>)
          .map<Masyarakat>((e) => Masyarakat.fromJson(e))
          .toList();
      masyarakatList.addAll(data);
      change(masyarakatList, status: RxStatus.success());
    }, onError: (error) {
      change(null, status: RxStatus.error(error.toString()));
    }).whenComplete(() => loading.value = false);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void insertMasyarakat(Masyarakat newData) {
    masyarakatList.add(newData);
  }

  void updateMasyarakat(String nik, Masyarakat data) {
    final index = masyarakatList.indexWhere((element) => element.nik == nik);
    if(index != -1) {
      masyarakatList[index] = data;
    }
  }
}

class Masyarakat {
  String? nik;
  String? nama;
  String? telp;
  String? username;
  String? password;

  Masyarakat({this.nik, this.nama, this.telp, this.password, this.username});

  Masyarakat.fromJson(Map<String, dynamic> json) {
    nik = json['nik'];
    nama = json['nama'];
    username = json['username'];
    telp = json['telp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nik'] = this.nik;
    data['nama'] = this.nama;
    data['username'] = this.username;
    data['telp'] = this.telp;
    return data;
  }
}
