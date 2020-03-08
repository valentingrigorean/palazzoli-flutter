import 'package:json_annotation/json_annotation.dart';

part 'mail_info.g.dart';

const int InfoTypePrice = 1;
const int InfoTypeMessage = 2;

@JsonSerializable()
class MailInfo {
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String email;
  final String phone;
  final int type;
  @JsonKey(name: 'code_product')
  final String codeProduct;
  final String message;

  MailInfo(
      {this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.type,
      this.codeProduct,
      this.message});

  factory MailInfo.fromJson(Map<String, dynamic> json) =>
      _$MailInfoFromJson(json);

  Map<String, dynamic> toJson() => _$MailInfoToJson(this);
}
