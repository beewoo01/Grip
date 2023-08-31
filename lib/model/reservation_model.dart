class ReservationModel {
  int reservation_idx;
  int account_account_idx;
  int content_content_idx;
  String reservation_name;
  String reservation_date;
  String reservation_start_time;
  String reservation_end_time;
  String reservation_phone;
  String reservation_email;
  String reservation_etc;

  ReservationModel(
      this.reservation_idx,
      this.account_account_idx,
      this.content_content_idx,
      this.reservation_name,
      this.reservation_date,
      this.reservation_start_time,
      this.reservation_end_time,
      this.reservation_phone,
      this.reservation_email,
      this.reservation_etc);

  ReservationModel.withOutReservationIdx(
    int account_account_idx,
    int content_content_idx,
    String reservation_name,
    String reservation_date,
    String reservation_start_time,
    String reservation_end_time,
    String reservation_phone,
    String reservation_email,
    String reservation_etc,
  ) : this(
          0,
          account_account_idx,
          content_content_idx,
          reservation_name,
          reservation_date,
          reservation_start_time,
          reservation_end_time,
          reservation_phone,
          reservation_email,
          reservation_etc,
        );
}