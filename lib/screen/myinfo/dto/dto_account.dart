class AccountDTO {
  int? account_idx;
  String? account_email;
  String? account_password;
  String? account_name;
  String? account_identify_number;
  String? account_phone;
  String? account_createtime;
  String? account_updatetime;

  AccountDTO(
      {required this.account_idx,
      required this.account_email,
      required this.account_password,
      required this.account_name,
      required this.account_identify_number,
      required this.account_phone,
      required this.account_createtime,
      required this.account_updatetime});

  factory AccountDTO.fromJson(Map<String, dynamic> map) {
    return AccountDTO(
        account_idx : map["account_idx"],
        account_email : map["account_email"],
        account_password : map["account_password"],
        account_name : map["account_name"],
        account_identify_number : map["account_identify_number"],
        account_phone : map["account_phone"],
        account_createtime : map["account_createtime"],
        account_updatetime : map["account_updatetime"],
    );
  }

}
