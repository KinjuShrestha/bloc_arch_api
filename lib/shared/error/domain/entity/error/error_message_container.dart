
import 'package:bloc_api_app/shared/error/domain/entity/error/error_message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';



part 'error_message_container.g.dart';

@JsonSerializable()
class ErrorMessageContainer {
  ErrorMessageContainer(this.errors);


  @JsonKey(name: 'errors', includeIfNull: true)
  final List<ErrorMessage> errors;

  factory ErrorMessageContainer.fromJson(Map<String, dynamic> json) =>
      _$ErrorMessageContainerFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorMessageContainerToJson(this);
}
