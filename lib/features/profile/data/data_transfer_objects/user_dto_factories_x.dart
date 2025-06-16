import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/shared_modules/errors_handling/failures/failure_entity.dart';
import 'app_user_dto.dart';

extension AppUserDtoFactoryX on AppUserDto {
  static AppUserDto fromDoc(DocumentSnapshot doc) {
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

  /// 🆕 Creates a new default [UserDTO] for registration
  static AppUserDto newUser({
    required String id,
    required String name,
    required String email,
  }) => AppUserDto(id: id, name: name, email: email);

  //
}
