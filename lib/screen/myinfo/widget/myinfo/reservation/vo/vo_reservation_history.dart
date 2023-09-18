class ReservationHistoryVO {
  final int reservation_idx;
  final String reservation_name;
  final String reservation_date;
  final String reservation_start_time;
  final String reservation_end_time;
  final String? reservation_etc;
  final String reservation_createtime;
  final String content_title;

  ReservationHistoryVO(
      this.reservation_idx,
      this.reservation_name,
      this.reservation_date,
      this.reservation_start_time,
      this.reservation_end_time,
      this.reservation_etc,
      this.reservation_createtime,
      this.content_title);
}