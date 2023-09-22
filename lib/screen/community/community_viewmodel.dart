import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:grip/api/ApiService.dart';
import 'package:grip/model/content_detail_model.dart';
import 'package:grip/model/inquiry_model.dart';
import 'package:grip/model/purchase_model.dart';
import 'package:grip/model/review_model.dart';
import 'package:grip/screen/myinfo/widget/review/dto/dto_wrote_review.dart';
import 'package:grip/screen/myinfo/widget/review/vo/vo_wrote_review.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ssh2/ssh2.dart';
import 'package:path/path.dart' as path;

import '../../model/content_image_model.dart';
import '../../model/sub_category_model.dart';


class CommunityViewModel {
  final ApiService apiService = ApiService();

  //List<ReviewModel> reviewList = [];
  List<InquiryModel>? inquiryList = [];
  ContentDetailModel? contentDetailModel;

  List<ContentImageModel> contentImageList = [];

  List<PurchaseModel>? purchaseList = [];
  List<SubCategoryModel>? subCategoryList = [];

  Future<List<ReviewModel>?> selectReview() async {
    List<ReviewModel>? reviewList = await apiService.selectReview();
    return reviewList;
  }

  Future<WroteReviewVO?> selectOneWroteReview(int reviewIdx) async {
    WroteReviewDto? model = await apiService.selectOneWroteReview(reviewIdx);
    if(model != null) {
      return WroteReviewVO(
        model.content_idx,
        model.review_idx,
        model.content_title,
        model.content_description,
        model.content_img_url,
        model.review_title,
        model.review_description,
        model.review_img_url,
        model.account_name,
        model.review_createtime,);
    }

    return null;

  }

  Future<ContentDetailModel?> selectContentDetail(int contentIdx) async {
    ContentDetailModel? contentDetailModel =
    await apiService.selectContentDetail(contentIdx);
    List<ContentImageModel>? contentImageList =
    await apiService.selectContentImage(contentIdx);
    if (contentDetailModel != null) {
      this.contentDetailModel = contentDetailModel;

      if (contentImageList != null) {
        this.contentImageList = contentImageList;
      }

      return contentDetailModel;
    }

    return null;
  }

  Future<List<ContentImageModel>?> selectContentImage(int contentIdx) async {
    List<ContentImageModel>? contentImageList =
    await apiService.selectContentImage(contentIdx);
    if (contentImageList != null) {
      this.contentImageList = contentImageList;
      return contentImageList;
    }

    return null;
  }

  Future<List<PurchaseModel>?> selectPurchaseList(int accountIdx) async {
    List<PurchaseModel>? list = await apiService.selectPurchaseList(accountIdx);
    purchaseList = list;
    return list;
  }

  Future<int?> insertReview(ReviewModel reviewModel) async {
    int? result = await apiService.insertReview(reviewModel);
    return result;
  }

  Future<int?> insertReviewImages(List<String> names, int reviewIdx) async {
    int? result = await apiService.insertReviewImages(names, reviewIdx);
    return result;
  }

  Future<void> saveFiles(List<XFile> fileList) async {
    //FTPConnect ftpConnect = FTPConnect('codebrosdev.cafe24.com', user: 'root', pass: 'code4554!', port: 8080);
    FTPConnect ftpConnect =
    FTPConnect('110.10.174.243', user: 'root', pass: 'code4554!', port: 22);
    //session = jSch.getSession("root", "110.10.174.243", 22);
    try {
      await ftpConnect.connect();
      ftpConnect.changeDirectory('/media/grip/');
      File file = File(fileList[0].path);
      bool res = await ftpConnect.uploadFileWithRetry(file, pRetryCount: 2);
      await ftpConnect.disconnect();
      print(res);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<String>?> saveFiles2(List<XFile> fileList, int accountIdx) async {
    String result = '';
    List<String> savedList = [];
    var client = SSHClient(
      host: '110.10.174.243',
      port: 22,
      username: 'root',
      passwordOrKey: 'code4554!',
    );

    try {
      result = await client.connect() ?? 'Null result';
      if (result == "session_connected") {
        result = await client.connectSFTP() ?? 'Null result';
        if (result == "sftp_connected") {
          for (var i = 0; i < fileList.length; i++) {
            //rename
            final file = File(fileList[i].path);
            String dir = path.dirname(fileList[i].path);
            final currentTime =
            DateFormat('yyyyMMddHHmmssSSS').format(DateTime.now());

            var fileName = '${currentTime}_${i}_$accountIdx.jpg';
            String newPath = path.join(dir, fileName);

            file.renameSync(newPath);

            savedList.add(fileName);

            String? uploadResult = await client.sftpUpload(
              path: newPath,
              toPath: "../var/lib/tomcat9/webapps/media/grip",
              callback: (progress) async {
                print(progress);
              },
            );

            if (uploadResult == null) {
              print('Upload Fail $i');
            }
          }

          return savedList;
        } else {
          print('sftp_connected else..');
        }
      } else {
        print('session_connected else..');
      }

      await client.disconnect();
    } on PlatformException catch (e) {
      String errorMessage = 'Error: ${e.code}\nError Message: ${e.message}';
      result = errorMessage;
      print(errorMessage);
    }
  }

  Future<List<SubCategoryModel>?> selectCategory() async {
    List<SubCategoryModel>? list = await apiService.selectCategory();
    subCategoryList = list;
    return list;
  }

  Future<List<InquiryModel>?> selectInquiry() async {
    List<InquiryModel>? list = await apiService.selectInquiry();
    if (list != null) {
      inquiryList = list;
      print(inquiryList.toString());
    }

    return list;
  }

  Future<int?> insertInquiry(int sub_category_idx, int account_idx,
      String inquiry_title, String inquiry_description,
      List<String>? names) async {
    int result = await apiService.insertInquiry(
        sub_category_idx, account_idx, inquiry_title, inquiry_description,
        names);

    return result;
  }
}
