import 'package:json_annotation/json_annotation.dart';
import 'package:pennywise/features/auth/domain/entities/signup_request_entity.dart';

part 'signup_request_dto.g.dart';

@JsonSerializable()
final class SignUpRequestDto extends SignupRequestEntity {
  SignUpRequestDto({
    required super.name,
    required super.email,
    required super.password,
    required super.passwordConfirmation,
  });

  factory SignUpRequestDto.fromJson(Map<String, dynamic> json) => _$SignUpRequestDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpRequestDtoToJson(this);

  factory SignUpRequestDto.fromDomain(SignupRequestEntity signUpEntity) {
    return SignUpRequestDto(
      name: signUpEntity.name,
      email: signUpEntity.email,
      password: signUpEntity.password,
      passwordConfirmation: signUpEntity.passwordConfirmation,
    );
  }

  SignupRequestEntity toDomain() {
    return SignupRequestEntity(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
  }
}
