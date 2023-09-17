import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:grip/api/ApiService.dart';
import 'package:grip/screen/myinfo/dto/dto_account.dart';
import 'package:grip/screen/myinfo/vo/vo_account.dart';
import 'package:grip/util/Singleton.dart';
import 'package:http/http.dart' as http;

class AccountRepository extends ChangeNotifier {
  final ApiService apiService = ApiService();
  Map<String, dynamic>? _duplicateMap;
  String? _duplicateResult;

  Map<String, dynamic>? get duplicateMap => _duplicateMap;
  String? get duplicateResult => _duplicateResult;

  Future<int> login(String id, String pw) async {
    return apiService.login(id, pw);
  }

  Future<AccountVO?> getAccountInfo(String id, String pw) async {
    AccountDTO? accountDTO = await apiService.getAccountInfo(id, pw);
    if(accountDTO != null) {
      Singleton().setAccountIdx(accountDTO.account_idx!);
      int idx = accountDTO.account_idx ?? 0;
      String name = accountDTO.account_name ?? "";
      return AccountVO(idx, name);
    }

    return null;
  }

  Future<int> duplicateCheck(String email, String name, String password,
      String identify, String phone) async {

    Map<String, dynamic>? map = await apiService.duplicateCheck(email, name, password, identify, phone);

    int notUseIdentity = -1;
    int notUseEmail = -2;
    int notUsePhoneNumber = -3;
    int error = -4;

    if(map == null) {
      return error;
    }

    if(map['icnState'] == -1) {
      //주민등록번호 곂침
      return notUseIdentity;
    }

    if (map['emailState'] == -1) {
      return notUseEmail;
    }

    if (map['phoneState'] == -1) {
      return notUsePhoneNumber;
    }

    return join(email, name, password, identify, phone);

  }

  Future<int> join(String email, String name, String password,
      String identify, String phone) async {
    int result = await apiService.join(email, name, password, identify, phone);
    return result;
  }
}