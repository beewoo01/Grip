import 'package:grip/api/ApiService.dart';
import 'package:grip/screen/myinfo/widget/like/dto/dto_my_like_content.dart';
import 'package:grip/screen/myinfo/widget/like/vo/vo_my_like_content.dart';

class LikeContentViewModel {
  ApiService apiService = ApiService();

  Future<List<MyLikeContentVO>> selectMyLike(
      int categoryIdx, int accountIdx) async {
    List<MyLikeContentDTO> list =
        await apiService.selectMyLike(categoryIdx, accountIdx) ?? [];
    List<MyLikeContentVO> result = [];
    for (var model in list) {
      result.add(MyLikeContentVO(model.content_idx, model.content_title,
          model.content_description, model.like_idx, model.content_img_url));
    }

    return result;
  }


  Future<int> deleteLike(int likeIdx) async {
    int result = await apiService.deleteLike(likeIdx);
    return result;
  }

  Future<int> insertLike(int contentIdx, int accountIdx) async {
    int result = await apiService.insertLike(contentIdx, accountIdx);
    return result;
  }
}
