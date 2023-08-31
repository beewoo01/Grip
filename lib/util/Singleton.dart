class Singleton {
  static Singleton? _instance;
  int? _accountIdx;

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
}