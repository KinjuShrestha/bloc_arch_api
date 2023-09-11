
import 'package:json_annotation/json_annotation.dart';
part 'error_message.g.dart';

@JsonSerializable()
class ErrorMessage {
  ErrorMessage(this.title, this.message, this.code);

  @JsonKey(name: 'title', defaultValue: '', includeIfNull: true)
  final String title;

  @JsonKey(name: 'detail', defaultValue: '', includeIfNull: true)
  final String message;

    @JsonKey(name: 'code', defaultValue: 0, includeIfNull: true)
  final int code;

  factory ErrorMessage.fromJson(Map<String, dynamic> json) => _$ErrorMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorMessageToJson(this);
  
} 