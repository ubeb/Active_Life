class registerData {
  final String name;
  final String email;
  int phone;

  registerData({
    required this.name,
    required this.email,
    required this.phone,
  });
}

class registerDataApi {
  registerData? _registerData; // Variabel untuk menyimpan data pengguna

  // Singleton pattern
  factory registerDataApi() {
    return _instance;
  }
  registerDataApi._internal();
  static final registerDataApi _instance = registerDataApi._internal();

  // Simpan data pengguna
  void saveregisterData(registerData registerData) {
    _registerData = registerData;
  }

  // Ambil data pengguna
  registerData? getregisterData() {
    return _registerData;
  }
}
