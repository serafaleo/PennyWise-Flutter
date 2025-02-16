import 'package:json_annotation/json_annotation.dart';
import 'package:pennywise/features/auth/domain/entities/signup_request_entity.dart';

part 'signup_request_dto.g.dart';

@JsonSerializable()
class SignUpRequestDto {
  final String email;
  final String password;
  final String passwordConfirmation;

  SignUpRequestDto({
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  factory SignUpRequestDto.fromJson(Map<String, dynamic> json) => _$SignUpRequestDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpRequestDtoToJson(this);

  factory SignUpRequestDto.fromDomain(SignupRequestEntity signUpEntity) {
    return SignUpRequestDto(
      email: signUpEntity.email,
      password: signUpEntity.password,
      passwordConfirmation: signUpEntity.passwordConfirmation,
    );
  }

  SignupRequestEntity toDomain() {
    return SignupRequestEntity(
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
  }
}
