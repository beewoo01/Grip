import 'package:grip/api/ApiService.dart';

import '../dto/dto_remaining_review.dart';
import '../vo/vo_remaining_review.dart';

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
        model.content_content_idx,
        model.content_title,
        model.reservation_name,
        model.reservation_date,
        model.reservation_etc,
      ));
    }
    return result;
  }
}
