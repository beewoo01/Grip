import 'package:grip/api/ApiService.dart';

import '../dto/dto_remaining_review.dart';
import '../dto/dto_wrote_review.dart';
import '../vo/vo_remaining_review.dart';
import '../vo/vo_wrote_review.dart';

class ReviewViewModel {
  ApiService apiService = ApiService();

  Future<List<RemainingReviewVO>> selectPossibleWriteReview(
      int accountIdx) async {
    print("selectPossibleWriteReview111");
    List<RemainingReviewDTO> list =
        await apiService.selectPossibleWriteReview(accountIdx) ?? [];
    print("selectPossibleWriteReview222");
    List<RemainingReviewVO> result = [];
    for (var model in list) {
      result.add(RemainingReviewVO(
        model.reservation_idx,
        model.content_idx,
        model.content_title,
        model.content_description,
        model.reservation_name,
        model.reservation_date,
        model.reservation_etc,
        model.content_img_url
      ));
    }
    return result;
  }

  Future<List<WroteReviewVO>?> selectWroteReview(int accountIdx) async {
    List<WroteReviewDto> list = await apiService.selectWroteReview(
        accountIdx) ?? [];
    List<WroteReviewVO> result = [];

    for (var model in list) {
      result.add(WroteReviewVO(
        model.content_idx,
        model.review_idx,
        model.content_title,
        model.content_description,
        model.content_img_url,
        model.review_title,
        model.review_description,
        model.review_img_url,
        model.account_name,
        model.review_createtime
      )
      );
    }

    return result;
  }

  Future<List<String>?> selectReviewImg(int reviewIdx) async {
    print("selectReviewImg111");
    List<String> list = await apiService.selectReviewImg(reviewIdx) ?? [];
    print("$list");
    print("selectReviewImg222");
    return list;
  }


}
