class ReservationHistoryDTO {
  int reservation_idx;
  String reservation_name;
  String reservation_date;
  String reservation_start_time;
  String reservation_end_time;
  String? reservation_etc;
  String reservation_createtime;
  String content_title;

  ReservationHistoryDTO(
      {required this.reservation_idx,
      required this.reservation_name,
      required this.reservation_date,
      required this.reservation_start_time,
      required this.reservation_end_time,
      required this.reservation_etc,
      required this.reservation_createtime,
      required this.content_title});

  factory ReservationHistoryDTO.fromJson(Map<String, dynamic> map) {
    return ReservationHistoryDTO(
        reservation_idx : map["reservation_idx"],
        reservation_name : map["reservation_name"],
        reservation_date : map["reservation_date"],
        reservation_start_time : map["reservation_start_time"],
        reservation_end_time : map["reservation_end_time"],
        reservation_etc : map["reservation_etc"],
        reservation_createtime : map["reservation_createtime"],
        content_title : map["content_title"],
    );
  }
}
