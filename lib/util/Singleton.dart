class Singleton {
  static Singleton? _instance;
  int? _accountIdx;
  String? _accountName;

  Singleton._();

  factory Singleton() {
    _instance ??= Singleton._();
    return _instance!;
  }

  void setAccountIdx(int idx) {
    _accountIdx = idx;
  }

  int? getAccountIdx() {
    return _accountIdx;
  }

  void setAccountName(String value) {
    _accountName = value;
  }

  String? getAccountName() {
    return _accountName;
  }
}