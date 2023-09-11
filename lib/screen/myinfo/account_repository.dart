import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:grip/api/ApiService.dart';
import 'package:http/http.dart' as http;

class AccountRepository extends ChangeNotifier {
  final ApiService apiService = ApiService();
  Map<String, dynamic>? _duplicateMap;
  String? _duplicateResult;

  Map<String, dynamic>? get duplicateMap => _duplicateMap;
  String? get duplicateResult => _duplicateResult;

  Future<http.Response> login(String id, String pw) {
    return apiService.login(id, pw);
  }

  Future<HashMap<String, dynamic>?>? duplicateCheck(String email, String name, String password,
      String identify, String phone) async {
    Map<String, dynamic>? map = await apiService.duplicateCheck(email, name, password, identify, phone);
    if (map != null) {
      print('map changed in viewModel');
      _duplicateMap = map;
      if(map['icnState'] == -1) {
        _duplicateResult = '이미 가입된 정보입니다.';
        notifyListeners();
      } else if (map['emailState'] == -1) {
        _duplicateResult = '이미 가입된 이메일입니다.';
        notifyListeners();
      } else if (map['phoneState'] == -1) {
        _duplicateResult = '이미 가입된 휴대폰 번호 입니다.';
        notifyListeners();
      } else {
        join(email, name, password, identify, phone);
      }

    }

     //duplicateMap = apiService.duplicateCheck(email, name, password, identify, phone) ;
    return null;
  }

  Future<int> join(String email, String name, String password,
      String identify, String phone) async {
    int result = await apiService.join(email, name, password, identify, phone);
    if (result > 0) {
      _duplicateResult = '회원가입에 성공하셨습니다.';
    }
    return result;
  }
}