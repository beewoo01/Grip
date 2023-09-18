import 'package:grip/screen/myinfo/widget/myinfo/reservation/dto/dto_revervation_history.dart';

import '../../../../../../api/ApiService.dart';
import '../vo/vo_reservation_history.dart';

class ReservationViewModel {
  final ApiService apiService = ApiService();

  List<ReservationHistoryVO> photoReservationList = [];
  List<ReservationHistoryVO> placeReservationList = [];
  List<ReservationHistoryVO> modelReservationList = [];

  Future<List<ReservationHistoryVO>> selectReservationHistory(
      int accountIdx) async {
    List<ReservationHistoryDTO> list = await apiService.selectReservationList(accountIdx) ?? [];
    List<ReservationHistoryVO> res = [];

    for (var model in list) {
      
      res.add(ReservationHistoryVO(
        model.reservation_idx,
        model.reservation_name,
        model.reservation_date,
        model.reservation_start_time,
        model.reservation_end_time,
        model.reservation_etc,
        model.reservation_createtime,
        model.content_title,));



    }

    return res;
  }


}