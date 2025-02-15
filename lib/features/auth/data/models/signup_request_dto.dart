import 'package:json_annotation/json_annotation.dart';

part 'signup_request_dto.g.dart';

@JsonSerializable()
class SignUpRequestDto {
  final String email;
  final String password;
  final String passwordConfirmation;

  SignUpRequestDto(this.passwordConfirmation, {required this.email, required this.password});

  factory SignUpRequestDto.fromJson(Map<String, dynamic> json) => _$SignUpRequestDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpRequestDtoToJson(this);
}
