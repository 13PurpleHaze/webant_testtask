import 'package:json_annotation/json_annotation.dart';
import 'package:webant_testtask/src/features/photos/domain/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String displayName;

  UserModel({required this.displayName});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  User toEntity() {
    return User(name: displayName);
  }
}
