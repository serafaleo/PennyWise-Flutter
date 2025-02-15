import 'package:json_annotation/json_annotation.dart';

part 'token_response_dto.g.dart';

@JsonSerializable()
class TokenResponseDto {
  final String accessToken;
  final String refreshToken;

  TokenResponseDto(this.accessToken, this.refreshToken);

  factory TokenResponseDto.fromJson(Map<String, dynamic> json) => _$TokenResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TokenResponseDtoToJson(this);
}
