import 'package:grip/api/ApiService.dart';
import 'package:grip/model/review_model.dart';

class CommunityViewModel {
  final ApiService apiService = ApiService();
  List<ReviewModel>? reviewList;

  Future<List<ReviewModel>?> selectReview() async {
    List<ReviewModel>? reviewList = await apiService.selectReview();
    this.reviewList = reviewList;
    if(reviewList != null) {
      print('reviewList');
      print(reviewList);
      return reviewList;
    }
    return null;
  }
}