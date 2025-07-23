import 'package:cloud_firestore/cloud_firestore.dart';
import '../../utils_shared/type_definitions.dart';
import '_user_dto.dart';

/// 🧰 [UserDTOFactories] — Static utilities for creating [UserDTO]
/// ✅ Use case: Firestore mapping, default user creation
//
extension UserDTOFactories on UserDTO {
  //-------------------------------

  /// 🔄 Creates [UserDTO] from Firestore document snapshot
  static UserDTO fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    //
    final data = doc.data();
    if (data == null) {
      throw const FormatException('No user data found in document');
    }

    try {
      return UserDTO(
        id: doc.id,
        name: data['name'] as String? ?? '',
        email: data['email'] as String? ?? '',
        profileImage: data['profileImage'] as String? ?? '',
        point:
            (data['point'] is int)
                ? data['point'] as int
                : int.tryParse('${data['point']}') ?? 0,
        rank: data['rank'] as String? ?? '',
      );
    } catch (e) {
      throw const FormatException(
        'Invalid or corrupted Firestore user document',
      );
    }
  }

  ///

  /// 🔄 Creates [UserDTO] from raw Firestore [Map]
  static UserDTO fromMap(DataMap map, {required String id}) => UserDTO(
    id: id,
    name: map['name'] ?? '',
    email: map['email'] ?? '',
    profileImage: map['profileImage'] ?? '',
    point: map['point'] ?? 0,
    rank: map['rank'] ?? '',
  );

  /// 🆕 Creates a new default [UserDTO] for registration
  static UserDTO newUser({
    required String id,
    required String name,
    required String email,
  }) => UserDTO(
    id: id,
    name: name,
    email: email,
    profileImage: 'https://picsum.photos/300',
    point: 0,
    rank: 'bronze',
  );

  //
}
