import './user.dart';

class Photo {
  final int id;
  final String filePath;
  final String? description;
  final String? name;
  final DateTime? createdAt;
  final User? user;

  const Photo({
    required this.id,
    required this.filePath,
    this.description,
    this.name,
    this.createdAt,
    this.user,
  });
}
