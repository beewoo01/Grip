import 'package:grip/api/ApiService.dart';
import 'package:grip/model/premium_model.dart';

class HomeViewModel {
  final ApiService apiService = ApiService();
  List<PremiumModel>? premiumList = [];

  Future<List<PremiumModel>?> selectPremiumModel(int accountIdx) async {
    List<PremiumModel>? list = await apiService.selectPremium(accountIdx);
    if(list != null) {
      premiumList?.clear();
      premiumList?.addAll(list);
      return list;
    }

    return null;

  }


}