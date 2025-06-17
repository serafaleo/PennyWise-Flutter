import 'package:json_annotation/json_annotation.dart';

enum ECategoryType {
  @JsonValue(0)
  expense,

  @JsonValue(1)
  income,
}
