import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../../core/shared_modules/errors_handling/failures/failure_entity.dart';

part 'app_user_dto.g.dart';

/// 📦 [AppUserDto] — concrete data source model for Firestore or API.
/// 🧼 Contains serialization methods, but no business logic.

@JsonSerializable()
class AppUserDto {
  ///------------

  final String id;
  final String name;
  final String email;

  const AppUserDto({required this.id, required this.name, required this.email});

  /// 🏗️ Parse from Firestore document snapshot
  factory AppUserDto.fromDoc(DocumentSnapshot doc) {
    final data = doc.data();

    if (data is! Map<String, dynamic>) {
      throw FirestoreDocMissingFailure();
    }

    return AppUserDto(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
    );
  }

  /// 🔁 From JSON (e.g. REST API)
  factory AppUserDto.fromJson(Map<String, dynamic> json) =>
      _$AppUserDtoFromJson(json);

  /// 🔁 To JSON (e.g. for sending to Firestore)
  Map<String, dynamic> toJson() => _$AppUserDtoToJson(this);

  //
}
