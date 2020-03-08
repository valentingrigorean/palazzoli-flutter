import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register.g.dart';

@JsonSerializable()
class Register extends Equatable {
  final String email;
  @JsonKey(name: 'first_name')
  final String name;
  @JsonKey(name: 'last_name')
  final String surname;
  @JsonKey(name: 'business_name')
  final String businessName;
  @JsonKey(name: 'activity_id')
  final String selectActivity;
  final String common;
  final String province;
  @JsonKey(name: 'country')
  final String nation;
  final String phone;

  Register(
      {this.email,
      this.name,
      this.surname,
      this.businessName,
      this.selectActivity,
      this.common,
      this.province,
      this.nation,
      this.phone})
      : super([
          email,
          name,
          surname,
          businessName,
          selectActivity,
          common,
          province,
          name,
          phone
        ]);

  factory Register.fromJson(Map<String, dynamic> json) =>
      _$RegisterFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterToJson(this);
}
