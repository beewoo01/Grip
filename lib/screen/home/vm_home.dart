import 'package:grip/api/ApiService.dart';
import 'package:grip/model/premium_model.dart';
import 'package:grip/screen/home/vo/vo_event.dart';

class HomeViewModel {
  final ApiService apiService = ApiService();
  List<PremiumModel>? premiumList = [];
  List<Event> eventList = [];

  Future<List<PremiumModel>?> selectPremiumModel(int accountIdx) async {
    List<PremiumModel>? list = await apiService.selectPremium(accountIdx);
    if (list != null) {
      premiumList?.clear();
      premiumList?.addAll(list);
      return list;
    }

    return null;
  }

  Future<int> insertLike(int contentIdx, int accountIdx) async {
    int result = await apiService.insertLike(contentIdx, accountIdx);
    return result;
  }

  Future<int> deleteLike(int likeIdx) async {
    int result = await apiService.deleteLike(likeIdx);
    return result;
  }

  Future<List<Event>> selectEvent() async {
    List<Event> list = await apiService.selectEvent() ?? [];
    eventList.clear();
    eventList.addAll(list.map((e) => Event(
          e.event_idx,
          e.event_title,
          e.event_description,
          e.event_img_idx,
          e.event_img_url,
        )));
    return list;
  }
}
