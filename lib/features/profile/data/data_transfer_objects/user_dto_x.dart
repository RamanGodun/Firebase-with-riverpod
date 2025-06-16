import 'dart:convert';
import '../../../../core/general_utils/typedef.dart';
import '../../domain/entities/_user_entity.dart';
import '_user_dto.dart';

/// 🔄 [UserDTOMapper] — Instance-level helpers for [UserDTO]
/// ✅ Converts to entity or JSON (for logic or API usage)

extension UserDTOMapper on UserDTO {
  //----------------------------

  /// 🔄 Converts [UserDTO] → Domain [UserEntity] entity
  UserEntity toEntity() => UserEntity(
    id: id,
    name: name,
    email: email,
    profileImage: profileImage,
    point: point,
    rank: rank,
  );

  /// 📦 Converts current [UserDTO] → raw [Map]
  DataMap toJsonMap() => {
    'name': name,
    'email': email,
    'profileImage': profileImage,
    'point': point,
    'rank': rank,
  };

  /// 📦 Converts current [UserDTO] → JSON string
  String toJson() => jsonEncode(toJsonMap());

  /// ❓ Returns true if DTO is empty (based on ID)
  bool get isEmpty => id.isEmpty;

  /// ✅ Negated [isEmpty]
  bool get isNotEmpty => !isEmpty;

  //
}
