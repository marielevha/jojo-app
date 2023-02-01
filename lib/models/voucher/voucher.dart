class Voucher {
  late int id;
  late int status;
  late int value;
  late String code;

  Voucher({
    required this.id,
    required this.status,
    required this.value,
    required this.code,
  });

  Voucher.init();

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      id: json['id'],
      status: json['status'],
      value: json['value'],
      code: json['code'],
    );
  }
}