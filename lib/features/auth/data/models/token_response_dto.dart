import 'package:json_annotation/json_annotation.dart';
import 'package:pennywise/features/auth/domain/entities/token_response_entity.dart';

part 'token_response_dto.g.dart';

@JsonSerializable()
class TokenResponseDto extends TokenResponseEntity {
  TokenResponseDto({required super.accessToken, required super.refreshToken});

  factory TokenResponseDto.fromJson(Map<String, dynamic> json) => _$TokenResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TokenResponseDtoToJson(this);

  factory TokenResponseDto.fromDomain(TokenResponseEntity tokenEntity) {
    return TokenResponseDto(
      accessToken: tokenEntity.accessToken,
      refreshToken: tokenEntity.refreshToken,
    );
  }

  TokenResponseEntity toDomain() {
    return TokenResponseEntity(accessToken: accessToken, refreshToken: refreshToken);
  }
}
