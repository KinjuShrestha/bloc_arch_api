import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_container.freezed.dart';
part 'user_container.g.dart';

@freezed
class UserContainer with _$UserContainer {
  const factory UserContainer({
    @Default(0) int page,
    @Default(0) int perPage,
    @Default(0) int total,
    @Default(0) int totalPages,
    required List<UserData> data,
  }) = _UserContainer;

  factory UserContainer.fromJson(Map<String, dynamic> json) =>
      _$UserContainerFromJson(json);
}

@freezed
class UserData with _$UserData {
  const factory UserData({
    required int id,
    required String email,
    required String firstName,
    required String lastName,
    required String avatar,
  }) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}