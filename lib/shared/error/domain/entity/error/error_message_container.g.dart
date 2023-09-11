// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_message_container.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorMessageContainer _$ErrorMessageContainerFromJson(
        Map<String, dynamic> json) =>
    ErrorMessageContainer(
      (json['errors'] as List<dynamic>)
          .map((e) => ErrorMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
     
    );

Map<String, dynamic> _$ErrorMessageContainerToJson(
        ErrorMessageContainer instance) =>
    <String, dynamic>{
  
      'errors': instance.errors,
    };
