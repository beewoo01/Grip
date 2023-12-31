import 'dart:collection';
import 'dart:convert';
import 'dart:ffi';

import 'package:grip/model/content_detail_model.dart';
import 'package:grip/model/content_image_model.dart';
import 'package:grip/model/inquiry_model.dart';
import 'package:grip/screen/category/dto/dto_category_content.dart';
import 'package:grip/screen/home/dto/dto_sub_category.dart';
import 'package:grip/screen/home/dto/dto_wedding.dart';
import 'package:grip/screen/myinfo/dto/dto_account.dart';
import 'package:grip/screen/myinfo/widget/like/dto/dto_my_like_content.dart';
import 'package:grip/screen/myinfo/widget/review/dto/dto_remaining_review.dart';
import 'package:http/http.dart' as http;

import '../common/url/grip_url.dart';
import '../model/content_model.dart';
import '../model/premium_model.dart';
import '../model/purchase_model.dart';
import '../model/reservation_model.dart';
import '../model/review_model.dart';
import '../model/sub_category_model.dart';

import '../screen/home/vo/vo_event.dart';
import '../screen/myinfo/vo/vo_account.dart';
import '../screen/myinfo/widget/myinfo/reservation/dto/dto_revervation_history.dart';
import '../screen/myinfo/widget/review/dto/dto_remaining_review.dart';

//import '../screen/myinfo/widget/review/dto/dto_wrote_review.dart.dart';
import 'package:grip/screen/myinfo/widget/review/dto/dto_wrote_review.dart';

class ApiService {
  String BASE_URL = GripUrl.serverUrl;

  Future<int> login(String id, String pw) async {
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
      return int.parse(response.body);
    }

    return -1;
  }

  Future<AccountDTO?> getAccountInfo(String id, String pw) async {
    print("getAccountInfo");
    Uri uri = Uri.parse("${BASE_URL}getAccountInfo");

    var response = await http
        .post(uri, body: {'account_email': id, 'account_password': pw});

    if (response.statusCode == 200) {
      print("getAccountInfo 200");
      print(response.body);
      return AccountDTO.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<int> join(String email, String name, String password, String identify,
      String phone) async {
    Uri uri = Uri.parse('${BASE_URL}joinAccount');

    var response = await http.post(uri, body: {
      'account_email': email,
      'account_name': name,
      'account_password': password,
      'account_identify_number': identify,
      'account_phone': phone
    });

    if (response.statusCode == 200) {
      print('Join 200');
      print(response.body);
      return int.parse(response.body);
    } else {
      print('Join not 200');
      var statusCode = response.statusCode;
      var responseHeaders = response.headers;
      var responseBody = response.body;
      print("stautsCode: ${statusCode}");
      print("responseHeaders: ${responseHeaders}");
      print("responseBody: ${responseBody}");

      return -5;
    }
  }

  Future<Map<String, dynamic>?> duplicateCheck(String email, String name,
      String password, String identify, String phone) async {
    Uri uri = Uri.parse('${BASE_URL}duplicateCheck');

    var response = await http.post(uri, body: {
      'account_email': email,
      'account_name': name,
      'account_password': password,
      'account_identify_number': identify,
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
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson
          .map((json) => SubCategoryModel.fromJson(json))
          .toList();
    }
    return null;
  }

  Future<List<ContentModel>?> selectContent(int subCategoryIdx) async {
    Map<String, String> param = {'sub_category_idx': subCategoryIdx.toString()};
    Uri uri =
        Uri.parse('${BASE_URL}selectContent').replace(queryParameters: param);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((json) => ContentModel.fromJson(json)).toList();
    }

    return null;
  }

  Future<List<CategoryContentDTO>?> selectCategoryContent(int subCategoryIdx, int accountIdx) async {

    final param = {
      'sub_category_idx': subCategoryIdx.toString(),
      'account_idx': accountIdx.toString()
    };
    Uri uri = Uri.parse('${BASE_URL}selectCategoryContent')
        .replace(queryParameters: param);

    print(uri.toString());
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print('response.statusCode == 200');
      List responseJson = json.decode(response.body);
      return responseJson
          .map((json) => CategoryContentDTO.fromJson(json))
          .toList();
    }

    return null;
  }

  Future<List<ReviewModel>?> selectReview() async {
    Uri uri = Uri.parse('${BASE_URL}selectReview');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((json) => ReviewModel.fromJson(json)).toList();
    }

    return null;
  }

  Future<WroteReviewDto?> selectOneWroteReview(int reviewIdx) async {
    Uri uri = Uri.parse("${BASE_URL}selectOneWroteReview").replace(queryParameters: {"reviewIdx" : reviewIdx.toString()});
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      WroteReviewDto result = WroteReviewDto.fromJson(map);
      return result;
    }
    return null;
  }

  Future<ContentDetailModel?> selectContentDetail(int contentIdx) async {
    Map<String, String> param = {'contentIdx': contentIdx.toString()};
    Uri uri = Uri.parse('${BASE_URL}selectContentDetail')
        .replace(queryParameters: param);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      ContentDetailModel responseJson = ContentDetailModel.fromJson(map);
      return responseJson;
    }
    return null;
  }

  Future<List<ContentImageModel>?> selectContentImage(int contentIdx) async {
    Map<String, String> param = {'contentIdx': contentIdx.toString()};
    Uri uri = Uri.parse('${BASE_URL}selectContentImage')
        .replace(queryParameters: param);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson
          .map((json) => ContentImageModel.fromJson(json))
          .toList();
    }

    return null;
  }

  Future<int?> insertReservation(ReservationModel model) async {
    Uri uri = Uri.parse('${BASE_URL}insertReservation');

    var response = await http.post(uri, body: {
      'account_account_idx': model.account_account_idx.toString(),
      'content_content_idx': model.content_content_idx.toString(),
      'reservation_name': model.reservation_name,
      'reservation_date': model.reservation_date,
      'reservation_start_time': model.reservation_start_time,
      'reservation_end_time': model.reservation_end_time,
      'reservation_phone': model.reservation_phone,
      'reservation_email': model.reservation_email,
      'reservation_etc': model.reservation_etc,
    });

    var statusCode = response.statusCode;

    if (statusCode == 200) {
      var result = response.body;
      try {
        var parsedResult = int.parse(result);
        return parsedResult;
      } catch (e) {
        print('$e');
      }
      return result as int;
    } else {
      print('insertReservation fail');
    }

    return null;
  }

  Future<List<PurchaseModel>?> selectPurchaseList(int accountIdx) async {
    print('apiService selectPurchaseList111');
    var param = {'account_idx': accountIdx.toString()};
    Uri uri = Uri.parse('${BASE_URL}selectPurchaseList')
        .replace(queryParameters: param);
    print('apiService selectPurchaseList222');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((json) => PurchaseModel.fromJson(json)).toList();
    }
    return null;
  }

  Future<int?> insertReview(ReviewModel reviewModel) async {
    var param = {
      'review_title': reviewModel.review_title,
      'review_description': reviewModel.review_description,
      'account_account_idx': reviewModel.account_idx.toString(),
      'content_idx': reviewModel.content_idx.toString()
    };

    Uri uri = Uri.parse('${BASE_URL}insertReview');

    var response = await http.post(uri, body: param);

    if (response.statusCode == 200) {
      print('insertReview 200');
      print(response.body);
      return int.parse(response.body);
    } else {
      return -1;
    }
  }

  Future<int?> insertReviewImages(List<String> names, int reviewIdx) async {
    String namesStr = names.toString();
    print(namesStr);
    final Map<String, String> param = {
      'images': namesStr,
      'reviewIdx': reviewIdx.toString()
    };

    final headers = {
      'Content-Type': 'application/json',
    };

    Uri uri = Uri.parse('${BASE_URL}insertReviewImages');

    final response = await http.post(uri, body: param);

    if (response.statusCode == 200) {
      print('POST요청 성공');

      return int.parse(response.body);
    } else {
      print('POST요청 실패');
      return null;
    }
  }

  Future<List<InquiryModel>?> selectInquiry() async {
    Uri uri = Uri.parse('${BASE_URL}selectInquiry');
    final response = await http.get(uri);
    print('selectInquiry statusCode is ${response.statusCode}');

    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      print(responseJson);
      return responseJson.map((json) => InquiryModel.fromJson(json)).toList();
    }

    return null;
  }

  Future<int> insertInquiry(
      int sub_category_idx,
      int account_idx,
      String inquiry_title,
      String inquiry_description,
      List<String>? names) async {
    Uri uri = Uri.parse('${BASE_URL}insertInquiry');
    String inquirt_images = names.toString();

    final response = await http.post(uri, body: {
      'sub_category_idx': sub_category_idx.toString(),
      'account_idx': account_idx.toString(),
      'inquiry_title': inquiry_title,
      'inquiry_description': inquiry_description,
      'inquirt_images': inquirt_images
    });

    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      return -1;
    }
  }

  Future<List<PremiumModel>?> selectPremium(int accountIdx) async {
    final param = {'account_idx': accountIdx.toString()};
    Uri uri =
        Uri.parse('${BASE_URL}selectPremium').replace(queryParameters: param);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print('selectPremium response.statusCode == 200');
      List responseJson = json.decode(response.body);
      print('responseJson $responseJson');
      return responseJson.map((json) => PremiumModel.fromJson(json)).toList();
    }

    return null;
  }

  Future<int> insertLike(int contentIdx, int accountIdx) async {
    final param = {"contentIdx": contentIdx, "accountIdx": accountIdx};
    Uri uri =
        Uri.parse('${BASE_URL}insertLike').replace(queryParameters: param);
    final response = await http.post(uri, body: param);
    if (response.statusCode == 200) {
      return int.parse(response.body);
    }

    return -1;
  }

  Future<int> deleteLike(int likeIdx) async {
    final param = {"likeIdx": likeIdx.toString()};
    Uri uri =
        Uri.parse('${BASE_URL}deleteLike').replace(queryParameters: param);
    final response = await http.post(uri, body: param);

    print("apiService deleteLike");
    if (response.statusCode == 200) {
      print("apiService deleteLike statusCode == 200");
      print(response.body);
      return int.parse(response.body);
    }

    return -1;
  }

  Future<List<Event>?> selectEvent() async {
    Uri uri = Uri.parse('${BASE_URL}selectEvent');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      print('selectEvent responseJson $responseJson');
      return responseJson.map((json) => Event.fromJson(json)).toList();
    }

    return null;
  }

  Future<List<WeddingDTO>?> selectWeddingPhoto() async {
    Uri uri = Uri.parse('${BASE_URL}selectWeddingPhoto');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      print('selectWeddingPhoto responseJson $responseJson');
      return responseJson.map((json) => WeddingDTO.fromJson(json)).toList();
    } else {
      print("response.statusCode is not 200");
      print("response.statusCode is ${response.statusCode}");

    }

    return null;
  }

  Future<List<WeddingDTO>?> selectPicturesByCategory(int categoryIdx) async {
    Uri uri = Uri.parse('${BASE_URL}selectPicturesByCategory')
        .replace(queryParameters: {"category_idx": categoryIdx.toString()});
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      print('selectPicturesByCategory responseJson $responseJson');
      return responseJson.map((json) => WeddingDTO.fromJson(json)).toList();
    } else {
      print('selectPicturesByCategory responseJson else');
    }

    return null;
  }

  Future<List<SubCategoryDTO>?> selectSubCategory(int categoryIdx) async {
    Uri uri = Uri.parse('${BASE_URL}selectSubCategory')
        .replace(queryParameters: {"category_idx": categoryIdx.toString()});
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      print('selectSubCategory responseJson $responseJson');
      return responseJson.map((json) => SubCategoryDTO.fromJson(json)).toList();
    } else {}

    return null;
  }

  Future<List<WeddingDTO>?> selectFindModel() async {
    Uri uri = Uri.parse("${BASE_URL}selectFindModel");

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print("apiService selectFindModel");
      List responseJson = json.decode(response.body);
      print("apiService selectFindModel $responseJson");
      return responseJson.map((json) => WeddingDTO.fromJson(json)).toList();
    }

    return null;
  }

  Future<List<WeddingDTO>?> selectHotSpace() async {
    Uri uri = Uri.parse("${BASE_URL}selectHotSpace");

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print("apiService selectHotspace");
      List responseJson = json.decode(response.body);
      print("apiService selectHotspace $responseJson");
      return responseJson.map((json) => WeddingDTO.fromJson(json)).toList();
    }

    return null;
  }

  Future<List<ReservationHistoryDTO>?> selectReservationList(
      int accountIdx) async {
    Uri uri = Uri.parse("${BASE_URL}selectReservationList")
        .replace(queryParameters: {"accountIdx": accountIdx.toString()});

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      print("selectReservationList response.statusCode == 200");
      List responseJson = json.decode(response.body);
      return responseJson
          .map((json) => ReservationHistoryDTO.fromJson(json))
          .toList();
    }
  }

  Future<int?> updateUserinfo(String account_email, String identity_num,
      String account_phone, int account_idx) async {
    Uri uri = Uri.parse("${BASE_URL}updateUserinfo");
    final response = await http.post(uri, body: {
      'account_email': account_email,
      'identity_num': identity_num,
      'account_phone': account_phone,
      'account_idx': account_idx.toString()
    });

    if (response.statusCode == 200) {
      return int.parse(response.body);
    }
    return 0;
  }

  Future<int?> deleteAccount(int accountIdx) async {
    Uri uri = Uri.parse("${BASE_URL}deleteAccount");
    final response =
        await http.post(uri, body: {"accountIdx": accountIdx.toString()});
    if (response.statusCode == 200) {
      return int.parse(response.body);
    }

    return 0;
  }

  Future<List<RemainingReviewDTO>?> selectPossibleWriteReview(
      int accountIdx) async {
    Uri uri = Uri.parse("${BASE_URL}selectPossibleWriteReview")
        .replace(queryParameters: {"accountIdx": accountIdx.toString()});
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      print("response.statusCode == 200");
      List responseJson = json.decode(response.body);
      return responseJson
          .map((json) => RemainingReviewDTO.fromJson(json))
          .toList();
    }
    return null;
  }

  Future<List<WroteReviewDto>?> selectWroteReview(int accountIdx) async {
    Uri uri = Uri.parse("${BASE_URL}selectWroteReview")
        .replace(queryParameters: {"accountIdx": accountIdx.toString()});
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print("response.statusCode == 200");
      List responseJson = json.decode(response.body);
      return responseJson.map((json) => WroteReviewDto.fromJson(json)).toList();
    }
    return null;
  }

  Future<List<String>?> selectReviewImg(int reviewIdx) async {
    Uri uri = Uri.parse("${BASE_URL}selectReviewImg")
        .replace(queryParameters: {"reviewIdx": reviewIdx.toString()});
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print("apiService selectReviewImg");
      print("response.body");
      print("${response.body}");
      List responseJson = json.decode(response.body);
      return responseJson.map((e) => e.toString()).toList();
    }
    return null;
  }

  Future<List<MyLikeContentDTO>?> selectMyLike(
      int categoryIdx, int accountIdx) async {
    Uri uri = Uri.parse("${BASE_URL}selectMyLike").replace(queryParameters: {
      "categoryIdx": categoryIdx.toString(),
      "accountIdx": accountIdx.toString()
    });

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((e) => MyLikeContentDTO.fromJson(e)).toList();
    }

    return null;
  }
}
