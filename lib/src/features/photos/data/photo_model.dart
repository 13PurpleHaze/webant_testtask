import 'package:json_annotation/json_annotation.dart';

import 'package:webant_testtask/src/features/photos/data/file_model.dart';
import 'package:webant_testtask/src/features/photos/data/user_model.dart';
import 'package:webant_testtask/src/features/photos/domain/photo.dart';

part 'photo_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PhotoModel {
  final int id;
  final FileModel file;
  final UserModel? user;
  final String? description;
  final String? name;
  final DateTime? dateCreate;

  PhotoModel({
    required this.id,
    required this.file,
    this.user,
    this.description,
    this.name,
    this.dateCreate,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoModelFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoModelToJson(this);

  Photo toEntity() {
    return Photo(
      id: id,
      filePath: '/get_file/${file.path}',
      user: user?.toEntity(),
      description: description,
      name: name,
      createdAt: dateCreate,
    );
  }
}
