import 'package:json_annotation/json_annotation.dart';

part 'login_response_dto.g.dart';

@JsonSerializable()
final class LoginResponseDto {
  final String userId;
  final String userName;
  final String accessToken;
  final String refreshToken;

  LoginResponseDto({
    required this.userName,
    required this.userId,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) => _$LoginResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseDtoToJson(this);
}
