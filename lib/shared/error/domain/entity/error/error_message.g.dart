// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorMessage _$ErrorMessageFromJson(Map<String, dynamic> json) => ErrorMessage(
      json['title'] as String? ?? '',
      json['detail'] as String? ?? '',
      json['code'] as int? ?? 0,
    );

Map<String, dynamic> _$ErrorMessageToJson(ErrorMessage instance) =>
    <String, dynamic>{
      'title': instance.title,
      'detail': instance.message,
      'code': instance.code,
    };
