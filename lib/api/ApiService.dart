import 'dart:collection';
import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;

import '../model/content_model.dart';
import '../model/review_model.dart';
import '../model/sub_category_model.dart';

class ApiService {
  String BASE_URL = "http://192.168.0.137:8080/project/";

  Future<http.Response> login(String id, String pw) async {
    Uri uri = Uri.parse('${BASE_URL}login');

    var response = await http
        .post(uri, body: {'account_email': id, 'account_password': pw});

    var statusCode = response.statusCode;
    var responseHeaders = response.headers;
    var responseBody = response.body;

    print("stautsCode: ${statusCode}");
    print("responseHeaders: ${responseHeaders}");
    print("responseBody: ${responseBody}");

    if (response.statusCode == 200) {
      print('statusCode == 200');
      print(response.body);
    } else {
      print(response.statusCode);
    }

    return response;
  }

  Future<int> join(String email, String name, String password,
      String identify, String phone) async {

    Uri uri = Uri.parse('${BASE_URL}joinAccount');

    var response = await http.post(uri, body: {
      'account_email' : email,
      'account_name' : name,
      'account_password' : password,
      'account_identify_number' : identify,
      'account_phone': phone
    });

    if (response.statusCode == 200) {
      print('Join 200');
      print(response.body);
      return response.body as int;
    } else {
      print('Join not 200');
      print(response.statusCode);

    }

    var statusCode = response.statusCode;
    var responseHeaders = response.headers;
    var responseBody = response.body;

    print("stautsCode: ${statusCode}");
    print("responseHeaders: ${responseHeaders}");
    print("responseBody: ${responseBody}");


    return -1;
  }


  Future<Map<String, dynamic>?> duplicateCheck(String email, String name, String password,
      String identify, String phone) async {
    Uri uri = Uri.parse('${BASE_URL}duplicateCheck');

    var response = await http.post(uri, body: {
      'account_email' : email,
      'account_name' : name,
      'account_password' : password,
      'account_identify_number' : identify,
      'account_phone': phone
    });

    var statusCode = response.statusCode;
    if (statusCode == 200) {
      print(response.body);
      Map<String, dynamic> data = jsonDecode(response.body);
      print('emailState ${data['emailState']}');
      print('icnState ${data['icnState']}');
      print('phoneState ${data['phoneState']}');
      return data;

    } else {
      print('Duplicate check fail');
    }


    return null;

  }


  Future<List<SubCategoryModel>?> selectCategory() async {
    Uri uri = Uri.parse('${BASE_URL}selectCategory');
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((json) => SubCategoryModel.fromJson(json)).toList();
    }
    return null;
  }

  Future<List<ContentModel>?> selectContent(int subCategoryIdx) async {
    Map<String, String> param = {'sub_category_idx' : subCategoryIdx.toString()};
    Uri uri = Uri.parse('${BASE_URL}selectContent').replace(queryParameters: param);
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((json) => ContentModel.fromJson(json)).toList();
    }

    return null;
  }

  Future<List<ReviewModel>?> selectReview() async {
    Uri uri = Uri.parse('${BASE_URL}selectReview');
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((json) => ReviewModel.fromJson(json)).toList();
    }

    return null;
  }
}
